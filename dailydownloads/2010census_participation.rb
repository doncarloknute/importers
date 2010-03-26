#!/usr/bin/env ruby

`wget -q http://2010.census.gov/2010census/take10map/downloads/participationrates2010.txt`
`mv participationrates2010.txt /data/ripd/demographics/census/2010participation/#{Time.now.strftime("%Y%m%d")}participationrates.csv`
