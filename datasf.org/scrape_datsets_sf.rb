#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'

outfile = File.open('../work/datasf.org/datasets_scraped','w')

datalistings = false

(1..8).each do |num|
  open("http://www.datasf.org/?page=#{num}").each do |line|
    if line =~ /\<div id\=\"leftcol\"/
      datalistings = true
    end
    if line =~ /\<div class\=\"pagination\"/
      datalistings = false
    end
    next if line =~ /^\s*<span[^>]+>/
    next if line =~ /^\s*<\/span>\n/
    next if line =~ /^\s+\n/
    outfile << line.gsub(/<br\s?\/>/,"\n") if datalistings
  end
end