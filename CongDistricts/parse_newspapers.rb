#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'

work_dir = '../work/cong_dist/'

NAMES = {
   "Alabama" => "AL", 
   "Alaska" => "AK", 
   "Arizona" => "AZ", 
   "Arkansas" => "AR", 
   "California" => "CA", 
   "Colorado" => "CO", 
   "Connecticut" => "CT", 
   "Delaware" => "DE", 
   "District Of Columbia" => "DC", 
   "Florida" => "FL", 
   "Georgia" => "GA", 
   "Hawaii" => "HI", 
   "Idaho" => "ID", 
   "Illinois" => "IL", 
   "Indiana" => "IN", 
   "Iowa" => "IA", 
   "Kansas" => "KS", 
   "Kentucky" => "KY", 
   "Louisiana" => "LA", 
   "Maine" => "ME", 
   "Maryland" => "MD", 
   "Massachusetts" => "MA", 
   "Michigan" => "MI", 
   "Minnesota" => "MN", 
   "Mississippi" => "MS", 
   "Missouri" => "MO", 
   "Montana" => "MT", 
   "Nebraska" => "NE", 
   "Nevada" => "NV", 
   "New Hampshire" => "NH", 
   "New Jersey" => "NJ", 
   "New Mexico" => "NM", 
   "New York" => "NY", 
   "North Carolina" => "NC", 
   "North Dakota" => "ND", 
   "Ohio" => "OH", 
   "Oklahoma" => "OK", 
   "Oregon" => "OR", 
   "Pennsylvania" => "PA", 
   "Rhode Island" => "RI", 
   "South Carolina" => "SC", 
   "South Dakota" => "SD", 
   "Tennessee" => "TN", 
   "Texas" => "TX", 
   "Utah" => "UT", 
   "Vermont" => "VT", 
   "Virginia" => "VA", 
   "Washington" => "WA", 
   "West Virginia" => "WV", 
   "Wisconsin" => "WI", 
   "Wyoming" => "WY"
 }
 
BASE_URL = 'http://www.refdesk.com'

state_pages = []
open(BASE_URL + '/paper.html').each do |line|
  state_pages += [$1] if line =~ /^\<a href\=\"(\/\w{2}\.html)\"\>.+/
end

#p state_pages

out_file = File.open(work_dir + 'refdesk_newspapers.tsv','w')

state_pages.each do |state|
  open(BASE_URL + state).each do |line|
     out_file << [$1,$2,$3,state[1..2].upcase].join("\t") + "\n" if line =~ /^\<[Ll][Ii]\>\<[Aa]\s[Hh][Rr][Ee][Ff]\=\"([^\"]+)\"\>([^\<]+)\<\/a\>\s+\(([^\)]+)\)/
  end
end