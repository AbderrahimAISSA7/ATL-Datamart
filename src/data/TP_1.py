import urllib.request
import requests
from bs4 import BeautifulSoup 
from minio import Minio
import sys
import re
import io

def main():
    local_file_paths = grab_data()
    local_file_paths += grab_last_month_data()
    write_data_minio(local_file_paths)

def grab_data():
    links = []
    local_file_paths = []
    url = "https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page"
    response = requests.get(url)
    site = response.text
    soup = BeautifulSoup(site, "html.parser")
    all_links = [link for link in soup.find_all("a") if link["href"].startswith("https://d37ci6vzurychx.cloudfront.net/trip-data/yellow")]
    years = {"2023"}  # Consider using a variable for dynamic year selection
    for elem in all_links:
        link = elem["href"]
        for year in years:
            if year in link:
                links.append(link)

    for link in links:
        file_name = link.split("/trip-data/")[-1]
        folder = f"../../data/raw/{file_name}"
        urllib.request.urlretrieve(link, folder)
        local_file_paths.append(folder)

    return local_file_paths

def grab_last_month_data():
    links_with_dates = {}
    local_file_paths = []
    url = "https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page"
    response = requests.get(url)
    site = response.text
    soup = BeautifulSoup(site, "html.parser")

    all_links = [link for link in soup.find_all("a") if link.get("href", "").startswith("https://d37ci6vzurychx.cloudfront.net/trip-data/yellow")]

    for elem in all_links:
        link = elem["href"]
        date_match = re.search(r"(\d{4})-(\d{2})", link)
        if date_match:
            year = int(date_match.group(1))
            month = int(date_match.group(2))
            links_with_dates[link] = (year, month)

    latest_link = max(links_with_dates, key=links_with_dates.get)

    file_name = latest_link.split("/trip-data/")[-1]
    folder = f"../../data/raw/{file_name}"
    urllib.request.urlretrieve(latest_link, folder)
    local_file_paths.append(folder)

    return local_file_paths

def write_data_minio(local_file_paths):
    client = Minio(
        "localhost:9000",
        secure=False,
        access_key="minio",
        secret_key="minio123"
    )
    bucket = "nyc-taxi"
    found = client.bucket_exists(bucket)
    if not found:
        client.make_bucket(bucket)
    else:
        print("Bucket " + bucket + " already exists")

    for file_path in local_file_paths:
        file_name = file_path.split("/")[-1]
        with open(file_path, "rb") as data:
            data_bytes = io.BytesIO(data.read())
            client.put_object(bucket, file_name, data_bytes, length=data_bytes.getbuffer().nbytes)

if __name__ == '__main__':
    sys.exit(main())
