#!/usr/bin/env ruby
require 'rubygems'
require 'imw'

WORK_DIR = "/data/ripd/computer/internet/isohunt/"

isohunt = IMW.open('http://isohunt.com/stats.php?mode=zg')
top300 = isohunt.parse ["table.forumline", {:search_terms => ["td.row1", {:term => "a",:rank => "../td.row2"}]}]

ranked_terms = []

(0..3).each{ |i| ranked_terms += top300[i][:search_terms].map{ |term| term = [term[:rank].inner_text, term[:term].inner_text] }}

outfile = File.open(WORK_DIR + "Isohunt_Top300_" + Time.now.strftime("%Y%m%d") + ".tsv","w")

ranked_terms.each{ |term| outfile << term.join("\t") + "\n"}
