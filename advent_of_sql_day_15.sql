CREATE EXTENSION IF NOT EXISTS postgis;

----Get data
SELECT  sl.timestamp,
	    --ST_AsText(sl.coordinate) AS location_point,
	    a.place_name AS area_name
FROM sleigh_locations sl
JOIN areas a 
	ON ST_Intersects(sl.coordinate, a.polygon)
where 1=1;

----Look at tables
select *
from sleigh_locations
limit 100;

select *
from areas
limit 100;


----Sample data
drop table if exists sleigh_locations;
CREATE TABLE sleigh_locations (
id SERIAL PRIMARY KEY,
timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
coordinate GEOGRAPHY(POINT) NOT NULL
);


drop table if exists areas;
CREATE TABLE areas (
    id SERIAL PRIMARY KEY,
    place_name VARCHAR(255) NOT NULL,
    polygon GEOGRAPHY(POLYGON) NOT NULL
);

INSERT INTO sleigh_locations (timestamp, coordinate) VALUES
('2024-12-24 22:00:00+00', ST_SetSRID(ST_Point(37.717634, 55.805825), 4326));

INSERT INTO areas (place_name, polygon) VALUES
('New_York', ST_SetSRID(ST_GeomFromText('POLYGON((-74.25909 40.477399, -73.700272 40.477399, -73.700272 40.917577, -74.25909 40.917577, -74.25909 40.477399))'), 4326)),
('Los_Angeles', ST_SetSRID(ST_GeomFromText('POLYGON((-118.668176 33.703652, -118.155289 33.703652, -118.155289 34.337306, -118.668176 34.337306, -118.668176 33.703652))'), 4326)),
('Tokyo', ST_SetSRID(ST_GeomFromText('POLYGON((139.691711 35.589487, 139.891711 35.589487, 139.891711 35.789487, 139.691711 35.789487, 139.691711 35.589487))'), 4326)),
('London', ST_SetSRID(ST_GeomFromText('POLYGON((-0.224828 51.446878, 0.024828 51.446878, 0.024828 51.546878, -0.224828 51.546878, -0.224828 51.446878))'), 4326)),
('Paris', ST_SetSRID(ST_GeomFromText('POLYGON((2.224973 48.815573, 2.424973 48.815573, 2.424973 48.915573, 2.224973 48.915573, 2.224973 48.815573))'), 4326)),
('Berlin', ST_SetSRID(ST_GeomFromText('POLYGON((13.304644 52.454563, 13.504644 52.454563, 13.504644 52.554563, 13.304644 52.554563, 13.304644 52.454563))'), 4326)),
('Sydney', ST_SetSRID(ST_GeomFromText('POLYGON((151.108398 -33.917085, 151.308398 -33.917085, 151.308398 -33.817085, 151.108398 -33.817085, 151.108398 -33.917085))'), 4326)),
('Singapore', ST_SetSRID(ST_GeomFromText('POLYGON((103.819836 1.264850, 104.019836 1.264850, 104.019836 1.364850, 103.819836 1.364850, 103.819836 1.264850))'), 4326)),
('Dubai', ST_SetSRID(ST_GeomFromText('POLYGON((55.270782 25.195302, 55.470782 25.195302, 55.470782 25.295302, 55.270782 25.295302, 55.270782 25.195302))'), 4326)),
('Moscow', ST_SetSRID(ST_GeomFromText('POLYGON((37.617634 55.755825, 37.817634 55.755825, 37.817634 55.855825, 37.617634 55.855825, 37.617634 55.755825))'), 4326)),
('Toronto', ST_SetSRID(ST_GeomFromText('POLYGON((-79.383184 43.653225, -79.183184 43.653225, -79.183184 43.753225, -79.383184 43.753225, -79.383184 43.653225))'), 4326)),
('Chicago', ST_SetSRID(ST_GeomFromText('POLYGON((-87.629798 41.878114, -87.429798 41.878114, -87.429798 41.978114, -87.629798 41.978114, -87.629798 41.878114))'), 4326)),
('Mexico_City', ST_SetSRID(ST_GeomFromText('POLYGON((-99.133208 19.432608, -98.933208 19.432608, -98.933208 19.532608, -99.133208 19.532608, -99.133208 19.432608))'), 4326)),
('Sao_Paulo', ST_SetSRID(ST_GeomFromText('POLYGON((-46.633309 -23.550520, -46.433309 -23.550520, -46.433309 -23.450520, -46.633309 -23.450520, -46.633309 -23.550520))'), 4326)),
('Mumbai', ST_SetSRID(ST_GeomFromText('POLYGON((72.877656 19.075984, 73.077656 19.075984, 73.077656 19.175984, 72.877656 19.175984, 72.877656 19.075984))'), 4326)),
('Shanghai', ST_SetSRID(ST_GeomFromText('POLYGON((121.473701 31.230416, 121.673701 31.230416, 121.673701 31.330416, 121.473701 31.330416, 121.473701 31.230416))'), 4326)),
('Seoul', ST_SetSRID(ST_GeomFromText('POLYGON((126.977969 37.566535, 127.177969 37.566535, 127.177969 37.666535, 126.977969 37.666535, 126.977969 37.566535))'), 4326)),
('Istanbul', ST_SetSRID(ST_GeomFromText('POLYGON((28.979530 41.008238, 29.179530 41.008238, 29.179530 41.108238, 28.979530 41.108238, 28.979530 41.008238))'), 4326)),
('Bangkok', ST_SetSRID(ST_GeomFromText('POLYGON((100.501765 13.756331, 100.701765 13.756331, 100.701765 13.856331, 100.501765 13.856331, 100.501765 13.756331))'), 4326)),
('Cairo', ST_SetSRID(ST_GeomFromText('POLYGON((31.235712 30.044420, 31.435712 30.044420, 31.435712 30.144420, 31.235712 30.144420, 31.235712 30.044420))'), 4326));