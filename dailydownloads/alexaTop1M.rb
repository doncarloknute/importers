#!/usr/bin/env ruby

`wget -q http://s3.amazonaws.com/alexa-static/top-1m.csv.zip`
`mv top-1m.csv.zip /data/ripd/computer/internet/alexa/#{Time.now.strftime("%Y%m%d")}top-1m.csv.zip`
