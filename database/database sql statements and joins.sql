start transaction;

-- Add New Risk -- all at the same time -- 
WITH ins AS (
        INSERT INTO risks ( name , summary , risk_reporter )
        VALUES ( 'Risk 1' , 'Summary' , 'Brian' )
   RETURNING risk_id),
ins2 AS (
        INSERT INTO images (risk_id , image_file) VALUES 
               ( ( SELECT risk_id FROM ins ), 'image_file' )
   RETURNING risk_id
)
        INSERT INTO locations (risk_id, location_name , client_name , street_address) VALUES 
               ( ( SELECT risk_id FROM ins ), 'location_name' , 'client' , '1234 address' ) 
;

-- Select all information from all tables, single Query and single table -- 
SELECT risks.risk_id, risks.name, risks.risk_reporter, risks.summary, risks.priority, risks.is_repaired, risks.repair_confirmed_by, risks.datefiled, risks.is_duplicate, images.image_id, images.image_file, locations.location_name, locations.location_id, locations.client_name, locations.street_address, locations.risk_location
FROM risks
JOIN images ON risks.risk_id = images.risk_id
JOIN locations ON risks.risk_id = locations.risk_id
;

SELECT * FROM risks WHERE is_duplicate = false;

-- Update Priority at Specific Risk -- 
UPDATE risks
SET priority = 'UPDATED'
WHERE risk_id = 1
;

-- Update isRepaired at Specific Risk -- 
UPDATE risks
SET is_repaired = NOT is_repaired
WHERE risk_id = 1
;

-- Update is_duplicate at Specific Risk -- 
UPDATE risks
SET is_duplicate = NOT is_duplicate
WHERE risk_id = 1
;

-- Update repairDate at Specific Risk -- 
UPDATE risks
SET recommended_repair_date = '2019-12-20'
WHERE risk_id = 1
;

-- Select All Information from specific Location -- NOT CURRENTLY IN USE
SELECT risks.risk_id AS id , risks.name , locations.location_name AS location , images.image_file AS image, risks.summary , risks.priority
FROM risks
JOIN images ON risks.risk_id = images.risk_id
JOIN locations ON risks.risk_id = locations.risk_id
WHERE locations.location_name = '?'
;



-- Simple Data Tables for Reference-- 
SELECT * FROM images;
SELECT * FROM locations;
SELECT * FROM risks;

rollback;

