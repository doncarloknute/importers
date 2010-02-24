CREATE TABLE IF NOT EXISTS `newspapers` (
	id	varchar(50) NOT NULL,
	prez_2008	varchar(50),
	prez_2004	varchar(50),
	prez_2000	varchar(50),
	prez_1996	varchar(50),
	prez_1992	varchar(50),
	rank	int,
	circ	int,
	daily	int,
	sun	int,
	lat	float NOT NULL,
	lng	float NOT NULL,
	city	varchar(50) NOT NULL,
	region_code	varchar(2) NOT NULL,
	paper	varchar(50) NOT NULL,
	pop	int NOT NULL,
	PRIMARY KEY id(id),
	KEY st(st)
);

ALTER TABLE newspapers DISABLE KEYS;
LOAD DATA INFILE '/Users/doncarlo//data/newspaperendorse/endorsements.tsv' 
   INTO TABLE endorsements
   FIELDS TERMINATED BY "\t"
   IGNORE 1 LINES
   (id, prez_2008, prez_2004, prez_2000, prez_1996, prez_1992, rank, circ, daily, sun, lat, lng, region_code, city, paper, pop)
   SET country_code='US'
;
ALTER TABLE endorsements ENABLE KEYS;

ALTER TABLE refdesknewspapers DISABLE KEYS;
LOAD DATA INFILE '/data/work/cong_dist/refdesk_newspapers.tsv' 
   INTO TABLE refdesknewspapers
   FIELDS TERMINATED BY "\t"
   (url,paper,city,region_code)
   SET country_code='us';
ALTER TABLE refdesknewspapers ENABLE KEYS