create external table if not exists companies (
    name string,
    code string, 
    industry string
) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "\""
)  
LOCATION '/app/companies';

create external table if not exists asx200 (
    code string
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/app/asx200';

create external table if not exists data (
    code string,
    dt int,
    open float,
    high float,
    low float,
    close float,
    volume float
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/app/data';

INSERT OVERWRITE LOCAL DIRECTORY '/app/1yr' 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
select d1.code, c.name, c.industry, d2.open, d1.min, d1.avg, d1.max from (
    select code, avg(open) as avg, max(open) as max, min(open) as min from data where dt > 20160602 group by code
) d1
join data d2 on d1.code = d2.code and d2.dt = 20170602
join asx200 a2 on d1.code = a2.code
join companies c on d1.code = c.code
where d2.open < d1.avg and d2.open < (d1.min + (d1.max - d1.min) / 3)
order by c.industry;

INSERT OVERWRITE LOCAL DIRECTORY '/app/2yr' 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
select d1.code, c.name, c.industry, d2.open, d1.min, d1.avg, d1.max from (
    select code, avg(open) as avg, max(open) as max, min(open) as min from data where dt > 20150602 group by code
) d1
join data d2 on d1.code = d2.code and d2.dt = 20170602
join asx200 a2 on d1.code = a2.code
join companies c on d1.code = c.code
where d2.open < d1.avg and d2.open < (d1.min + (d1.max - d1.min) / 3)
order by c.industry;
