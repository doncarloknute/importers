#!/usr/bin/env ruby
require 'rubygems'
require '../ImportYAML/importyaml'
require 'ukdata_dm'

# Make a new collection called Data.gov.uk

collection = [{'collection'=>{'title'=>'Data.gov.uk','description'=>''}}]

# Make a new source of Data.gov.uk

datagovuk_source = 

sources = []

UkDataset.all.each do |dataset|
  next unless dataset.url != ""
  next unless dataset.tags != ""
  
  data_yaml = DatasetYAML.new(:title => dataset.title, :main_link => dataset.url, :description => dataset.description, :tags => dataset.tags.split(", "),
    :owner => "doncarlo", :protected => "true", :collection => "Data.gov.uk")
  sources += dataset.author if !(sources.include?(dataset.author))
  
end