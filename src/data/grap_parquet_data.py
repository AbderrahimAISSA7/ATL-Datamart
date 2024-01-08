

import requests

# URL du lien de téléchargement direct
download_url = "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2018-01.parquet"

# Téléchargez le fichier
response = requests.get(download_url)

if response.status_code == 200:
    with open("yellow_tripdata_2018-01.parquet", "wb") as f:
        f.write(response.content)
    print("Ensemble de données téléchargé avec succès.")
else:
    print(f"La requête a échoué avec le code de statut {response.status_code}")

