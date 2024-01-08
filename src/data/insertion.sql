-- Using nyc_row to populate Location table
INSERT INTO Location (LocationID, Borough, ZoneID) 
SELECT nyc_row.LocationID, nyc_row.Borough, nyc_row.ZoneID
FROM nyc_row;

-- Using nyc_row to populate LocationDetails table
INSERT INTO LocationDetails (LocationID, LocationType)
SELECT nyc_row.LocationID, nyc_row.LocationType
FROM nyc_row;

-- Using nyc_row to populate Vendor table
INSERT INTO Vendor (VendorID, VendorName)
SELECT nyc_row.VendorID, nyc_row.VendorName
FROM nyc_row;

-- Using nyc_row to populate VendorDetails table
INSERT INTO VendorDetails (VendorID, VendorType)
SELECT nyc_row.VendorID, nyc_row.VendorType
FROM nyc_row;

-- Using nyc_row to populate Ratecode table
INSERT INTO Ratecode (RatecodeID, RatecodeDescription)
SELECT nyc_row.RatecodeID, nyc_row.RatecodeDescription
FROM nyc_row;

-- Using nyc_row to populate RatecodeDetails table
INSERT INTO RatecodeDetails (RatecodeID, RatecodeType)
SELECT nyc_row.RatecodeID, nyc_row.RatecodeType
FROM nyc_row;

-- Using nyc_row to populate Time table
INSERT INTO Time (TimeID, PickupHour, PickupDay, PickupMonth, PickupYear)
SELECT nyc_row.TimeID, nyc_row.PickupHour, nyc_row.PickupDay, nyc_row.PickupMonth, nyc_row.PickupYear
FROM nyc_row;

-- Using nyc_row to populate TimeDetails table
INSERT INTO TimeDetails (TimeID, HolidayType)
SELECT nyc_row.TimeID, nyc_row.HolidayType
FROM nyc_row;

-- Using nyc_row to populate PaymentType table
INSERT INTO PaymentType (PaymentTypeID, PaymentTypeName)
SELECT nyc_row.PaymentTypeID, nyc_row.PaymentTypeName
FROM nyc_row;

-- Using nyc_row to populate PaymentTypeDetails table
INSERT INTO PaymentTypeDetails (PaymentTypeID, CardNetwork)
SELECT nyc_row.PaymentTypeID, nyc_row.CardNetwork
FROM nyc_row;

-- Using nyc_row to populate Trip table
INSERT INTO Trip (
    TripID, VendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
    passenger_count, trip_distance, RatecodeID, store_and_fwd_flag,
    PULocationID, DOLocationID, payment_type, fare_amount, extra,
    mta_tax, tip_amount, tolls_amount, improvement_surcharge,
    total_amount, congestion_surcharge, airport_fee
)
SELECT
    TripID, VendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
    passenger_count, trip_distance, RatecodeID, store_and_fwd_flag,
    PULocationID, DOLocationID, payment_type, fare_amount, extra,
    mta_tax, tip_amount, tolls_amount, improvement_surcharge,
    total_amount, congestion_surcharge, airport_fee
FROM nyc_row;
