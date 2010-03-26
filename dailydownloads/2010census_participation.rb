#!/usr/bin/env ruby

`wget http://2010.census.gov/2010census/take10map/downloads/participationrates2010.txt`
`mv participationrates2010.txt #{Time.now.strftime("%Y%m%d")}participationrates2010.csv`