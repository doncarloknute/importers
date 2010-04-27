#!/usr/bin/env ruby

data_path = './del_data//'

out_file = File.open('delicious_mrflip.tsv','w')

Dir.foreach(data_path) do |filename|
#  p filename
  if filename =~ /^[^\.]+\.xml/
    File.open(data_path + filename).each do |line| 
      out_file << [$3,$6,$1,$4.split(" ").join(","),$5].join("\t") + "\n" if line =~ /^\s+\<post\shref\=\"([^\"]+)\"\shash\=\"([^\"]+)\"\sdescription\=\"([^\"]+)\"\stag\=\"([^\"]+)\"\stime\=\"([^\"]+)\"\sextended\=\"([^\"]*)\"\smeta\=\"([^\"]+)\".+/
    end
  end
end