-- Vendor table to store information about service providers
CREATE TABLE Vendor (
    vendorID BIGINT PRIMARY KEY,
    vendor_name VARCHAR(100) -- Changed column name to be more descriptive
);

-- Table to define different service zones
CREATE TABLE ServiceZone (
    service_zoneID BIGINT PRIMARY KEY,
    zone_name VARCHAR(100) -- Changed column name to be more descriptive
);

-- Zone table to specify different zones and link them to service zones
CREATE TABLE Zone (
    zoneID BIGINT PRIMARY KEY,
    zone_name VARCHAR(100), 
    service_zoneID BIGINT,
    FOREIGN KEY (service_zoneID) REFERENCES ServiceZone(service_zoneID)
);

-- Location table to store various locations with borough information
CREATE TABLE Location (
    locationID BIGINT PRIMARY KEY,
    borough_name VARCHAR(100), -- Changed column name to be more descriptive
    zoneID BIGINT,
    FOREIGN KEY (zoneID) REFERENCES Zone(zoneID)
);

-- Table to define different rate codes for services
CREATE TABLE RateCode (
    ratecodeID BIGINT PRIMARY KEY,
    rate_code_name VARCHAR(100) -- Changed column name to be more descriptive
);

-- Table to define different payment types
CREATE TABLE PaymentType (
    payment_typeID BIGINT PRIMARY KEY,
    payment_type_name VARCHAR(100) -- Changed column name to be more descriptive
);

-- Assuming nyc_row is a table; add constraints for linking tables
ALTER TABLE nyc_row 
    ADD CONSTRAINT fk_vendor FOREIGN KEY (vendorid) REFERENCES Vendor(vendorID),
    ADD CONSTRAINT fk_ratecode FOREIGN KEY (ratecodeid) REFERENCES RateCode(ratecodeID),
    ADD CONSTRAINT fk_payment_type FOREIGN KEY (payment_typeid) REFERENCES PaymentType(payment_typeID),
    ADD CONSTRAINT fk_pulocation FOREIGN KEY (pulocationid) REFERENCES Location(locationID),
    ADD CONSTRAINT fk_dolocation FOREIGN KEY (dolocationid) REFERENCES Location(locationID);
