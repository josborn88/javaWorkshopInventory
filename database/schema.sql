BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS images; 
DROP TABLE IF EXISTS risks;

CREATE TABLE users (

  user_id serial PRIMARY KEY,
  username varchar(255) NOT NULL UNIQUE,     -- Username
  password varchar(32) NOT NULL,      -- Password
  salt varchar(255) NOT NULL,          -- Password Salt
  role varchar(255) NOT NULL default('user')
  
);

CREATE TABLE risks (

  risk_id serial PRIMARY KEY,
  name varchar(255),
  risk_reporter varchar(255),
  summary varchar(255),
  priority varchar(10), 
  is_repaired BOOLEAN DEFAULT FALSE,
  repair_confirmed_by varchar(255),
  dateFiled DATE DEFAULT NOW(),
  recommended_repair_date VARCHAR(10),
  is_duplicate BOOLEAN DEFAULT FALSE
  
);

CREATE TABLE locations (

 location_id serial PRIMARY KEY,
 risk_id bigint,
 client_name varchar(255),
 location_name varchar(255),
 street_address varchar(255),
 risk_location varchar(255),
 
 CONSTRAINT fk_locations_risk_id FOREIGN KEY (risk_id) REFERENCES risks(risk_id)
 
);
 
 CREATE TABLE images (
 
  image_id serial PRIMARY KEY,
  risk_id bigint,  
  image_file varchar(255),
  
  CONSTRAINT fk_images_risk_id FOREIGN KEY (risk_id) REFERENCES risks(risk_id) 
  
);

--default system adim is Luis, password changemenow--
INSERT INTO users (username, password, salt, role) VALUES('Luis', 'mYmihWjSKULt2zPxUVvMGw==', 'U43RCXJ+neO0dpFB15Kvn9CcUKXprN5uKCxIBzFUayhfHkPzsPpXaxYFb5DrlqCvA2EewbJubwHty+ixgqYLTp+yyUoXHiMNFd+4uzpg81bEHSOG5BDbEwtfgF7sEGkNjjp9d1mFVmrS/T1vWMbEuyhbbLqUxpDtERPy/3qXJQU=', 'systemAdmin');


COMMIT TRANSACTION;
