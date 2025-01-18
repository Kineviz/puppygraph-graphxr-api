create schema if not exists supply;
create table if not exists supply.customers (id bigint, customername text, city text, state text, location_id bigint);
TRUNCATE TABLE supply.customers;
COPY supply.customers FROM '/tmp/csv_data/customers.csv' delimiter ',' CSV HEADER;

create table if not exists supply.distance (id bigint, from_loc_id bigint, to_loc_id bigint, distance double precision);
TRUNCATE TABLE supply.distance;
COPY supply.distance FROM '/tmp/csv_data/distance.csv' delimiter ',' CSV HEADER;

create table if not exists supply.factory (id bigint, factoryname text, locationid bigint);
TRUNCATE TABLE supply.factory;
COPY supply.factory FROM '/tmp/csv_data/factory.csv' delimiter ',' CSV HEADER;

create table if not exists supply.inventory (id bigint, productid bigint, locationid bigint, quantity bigint, lastupdated timestamp);
TRUNCATE TABLE supply.inventory;
COPY supply.inventory FROM '/tmp/csv_data/inventory.csv' delimiter ',' CSV HEADER;

create table if not exists supply.locations (id bigint, address text, city text, country text, lat double precision, lng double precision);
TRUNCATE TABLE supply.locations;
COPY supply.locations FROM '/tmp/csv_data/locations.csv' delimiter ',' CSV HEADER;

create table if not exists supply.materialfactory (id bigint, material_id bigint, factory_id bigint);
TRUNCATE TABLE supply.materialfactory;
COPY supply.materialfactory FROM '/tmp/csv_data/materialfactory.csv' delimiter ',' CSV HEADER;

create table if not exists supply.materialinventory (id bigint, materialid bigint, locationid bigint, quantity bigint, lastupdated timestamp);
TRUNCATE TABLE supply.materialinventory;
COPY supply.materialinventory FROM '/tmp/csv_data/materialinventory.csv' delimiter ',' CSV HEADER;

create table if not exists supply.materialorders (id bigint, materialid bigint, factoryid bigint, quantity bigint, orderdate timestamp, expectedarrivaldate timestamp, status text);
TRUNCATE TABLE supply.materialorders;
COPY supply.materialorders FROM '/tmp/csv_data/materialorders.csv' delimiter ',' CSV HEADER;

create table if not exists supply.materials (id bigint, materialname text);
TRUNCATE TABLE supply.materials;
COPY supply.materials FROM '/tmp/csv_data/materials.csv' delimiter ',' CSV HEADER;

create table if not exists supply.productcomposition (id bigint, productid bigint, materialid bigint, quantity bigint);
TRUNCATE TABLE supply.productcomposition;
COPY supply.productcomposition FROM '/tmp/csv_data/productcomposition.csv' delimiter ',' CSV HEADER;

create table if not exists supply.products (id bigint, productname text, price double precision);
TRUNCATE TABLE supply.products;
COPY supply.products FROM '/tmp/csv_data/products.csv' delimiter ',' CSV HEADER;

create table if not exists supply.productsales (id bigint, productid bigint, customerid bigint, quantity bigint, saledate timestamp, totalprice double precision);
TRUNCATE TABLE supply.productsales;
COPY supply.productsales FROM '/tmp/csv_data/productsales.csv' delimiter ',' CSV HEADER;

create table if not exists supply.productshipment (id bigint, productid bigint, fromlocationid bigint, tolocationid bigint, quantity bigint, shipmentdate timestamp, expectedarrivaldate timestamp, status text);
TRUNCATE TABLE supply.productshipment;
COPY supply.productshipment FROM '/tmp/csv_data/productshipment.csv' delimiter ',' CSV HEADER;
