#!/usr/bin/env ruby
require 'rubygems'
require './sfdata_dm'

BASEURL = "http://datasf.org"

sfdatasets = File.open('../work/datasf.org/datasets_scraped')

old_title = ''
tags = []
description = ''
extras = ''
url = ''

until sfdatasets.eof?
  line = sfdatasets.readline
  if line =~ /<a href=\"\/story.php\?title=[^\"]+\">([^<]+)<\/a>/ && $1 != " Read More"  #dataset title
    title = $1
    puts "Title: " + title 
    if old_title != ''
      sfdd = SanfranDataset.create(
         :title => title, :url => url, :tags => tags.join(","), :description => description, :extras => extras)
      sfdd.save
#      puts title, url, tags.join(","), description, extras
      url = ''
      description = ''
      extras = ''
      tags = []
    end
    old_title = title
  end
  extras += "Category: " + $1 + "\n" if line =~ /Categorized under <a href=\"\/index.php\?category=[^\"]+\">([^<]+)<\/a>/ #category
  if line =~ /<b>Description: <\/b>/ # description
    line = sfdatasets.readline
    description = line.chomp.lstrip.rstrip
    next
  end
  if line =~ /<b>Location of dataset:<\/b>([^\n]+)/ # main link/location
    url = $1
    url = $1 if url =~ /(http:\/\/[\w\/\.\-\%\?\=]+)/ 
    next
  end
  extras += $1 + ": " + $2 + "\n" if line =~ /<b>([^\:]+)\:<\/b>([^\n]+)/ # other info
  if line =~ /Tags:/  # tags
    until line =~ /<\/span>/
      line = sfdatasets.readline
      tags += [$1] if line =~ /<a href=\"\/search.php\?search=[^\"]+\">([^<]+)<\/a>/
    end
#    puts "Tags:" + tags.join(",")
  end
end