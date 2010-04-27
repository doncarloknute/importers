#!/usr/bin/env ruby
require 'districtsdb'

# # Original list of newspapers from Flip's 2008 newspaper endorsements data
# newspapers = File.open('newspaper_districts.tsv','w')
#
# Newspaper.all.map do |paper|  
#   pd = paper.locations.districtings
#   # pd.length
#   newspapers << [paper.id, paper.city, paper.region_code, pd.map(&:zip5).uniq.join(","), pd.map(&:district_id).uniq.join(",") ].join("\t") + "\n"
# end

# # List of newspapers from refdesk.com
# newspapers = File.open('refdesk_newspaper_dist.tsv','w')
#
# Refdesknewspaper.all.map do |paper|  
#  pd = paper.locations.districtings
#  newspapers << [paper.paper, paper.city, paper.region_code, pd.map(&:zip5).uniq.join(","), pd.map(&:district_id).uniq.join(",") ].join("\t") + "\n"
# end

# List of newspapers from kidon.com
newspapers = File.open('kidon_weeklies_dist.tsv','w')

Kidonnewspaper.all.map do |paper|  
 pd = paper.locations.districtings
 newspapers << [paper.paper, paper.city, paper.region_code, pd.map(&:zip5).uniq.join(","), pd.map(&:district_id).uniq.join(",") ].join("\t") + "\n"
end

