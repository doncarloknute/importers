#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'

work_dir = '../work/cong_dist/'

BASE_URL = 'http://www.kidon.com/media-link/'

state_pages = []
open(BASE_URL + 'usa.php').each do |line|
  state_pages += [$1] if line =~ /^\<a href\=\'(us_\w{2}\.php)\'\>.+/
end

#p state_pages

out_file = File.open(work_dir + 'kidon_weeklies.tsv','w')

state_pages.each do |state|
  weekly = false
  open(BASE_URL + state).each do |line|
    weekly = true if line =~ /^\<b\>Weekly and less frequent news sources\<\/b\>.*/
    weekly = false if line =~ /^\<b\>Broadcast news sources\<\/b\>.*/
    out_file << [$1,$2,$3,state[3..4].upcase].join("\t") + "\n" if line =~ /^.+\<[Aa]\s[Hh][Rr][Ee][Ff]\=\"([^\"]+)\"\>([^\<]+)\<\/a\>\s+\(([^\)]+)\)/ && weekly
  end
end