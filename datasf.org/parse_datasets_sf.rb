#!/usr/bin/env ruby
require 'rubygems'
require './sfdata_dm'

BASEURL = "http://datasf.org"

sfdatasets = File.open('../work/datasf.org/datasets_scraped')

old_title = ''
tags = []

until sfdatasets.eof?
  line = sfdatasets.readline
  if line =~ /<a href=\"\/story.php\?title=[^\"]+\">([^<]+)<\/a>/ && $1 != " Read More"  #dataset title
    title = $1
    if old_title != ''
      tags = []
      puts "_____________________________________________"
    end
    puts "Title: " + title 
    old_title = title
  end
  puts "Category: " + $1 if line =~ /Categorized under <a href=\"\/index.php\?category=[^\"]+\">([^<]+)<\/a>/ #category
  if line =~ /<b>Description: <\/b>/ # description
    line = sfdatasets.readline
    puts "Description: " + line.chomp.lstrip.rstrip
  end
  if line =~ /<b>Location of dataset:<\/b>([^\n]+)/ # main link/location
    puts "Main Link: " + $1 
    next
  end
  puts $1 + ": " + $2 if line =~ /<b>([^\:]+)\:<\/b>([^\n]+)/ # other info
  if line =~ /Tags:/  # tags
    until line =~ /<\/span>/
      line = sfdatasets.readline
      tags += [$1] if line =~ /<a href=\"\/search.php\?search=[^\"]+\">([^<]+)<\/a>/
    end
    puts "Tags:" + tags.join(",")
  end
end