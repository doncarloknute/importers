#!/usr/bin/env ruby
require 'rubygems'
require '../ImportYAML/importyaml'
require 'ukdata_dm'

# Make a new collection called Data.gov.uk

collection = [{'collection'=>{'title'=>'Data.gov.uk','description'=>'Data.gov.uk seeks to give a way into the wealth of government data. As highlighted by the Power of Information Taskforce, this means it needs to be:

* easy to find;
* easy to license; and
* easy to re-use.

They are drawing on the expertise and wisdom of Sir Tim Berners-Lee and Professor Nigel Shadbolt to publish government data as RDF - enabling data to be linked together.'}}]

# Make a new source of Data.gov.uk

datagovuk_source = [{'source'=>{'title'=>'Data.gov.uk','description'=>'Data.gov.uk seeks to give a way into the wealth of government data. As highlighted by the Power of Information Taskforce, this means it needs to be:

* easy to find;
* easy to license; and
* easy to re-use.

They are drawing on the expertise and wisdom of Sir Tim Berners-Lee and Professor Nigel Shadbolt to publish government data as RDF - enabling data to be linked together.','main_link'=>'http://data.gov.uk/'}}]

all_datasets = []
sources = []

UkDataset.all.each do |dataset|
  next unless dataset.url != ""
  next unless dataset.tags != ""
  
  data_yaml = DatasetYAML.new(:title => dataset.title, :main_link => dataset.url, :description => dataset.description, :tags => dataset.tags,
    :owner => "doncarlo", :protected => "true", :collection => "Data.gov.uk")
  data_yaml.sources = ["Data.gov.uk", dataset.author]
  sources += [dataset.author] if !(sources.include?(dataset.author))
  data_yaml.description += "\n\n" + dataset.extras if dataset.extras != ""
  all_datasets += data_yaml.to_a
end

source_yaml = File.open("data.gov.uk_source.yaml","w")
source_yaml << datagovuk_source.to_yaml

collection_yaml = File.open("data.gov.uk_collection.yaml","w")
collection_yaml << collection

data_yaml = File.open("data.gov.uk_datasets.yaml","w")
data_yaml << all_datasets.to_yaml