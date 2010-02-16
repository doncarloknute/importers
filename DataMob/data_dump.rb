#!/usr/bin/env ruby
require 'rubygems'
require 'dm-core'
require 'dm-types'
require 'configliere'
Settings.use :config_file, :define, :commandline
Settings.read 'importers.yaml'  # ~/.configliere/ip_census.yaml
Settings.define :db_uri,  :description => "Base URI for database -- eg mysql://USERNAME:PASSWORD@localhost:9999", :required => true
Settings.define :db_name, :description => "Database name to use", :required => true
Settings.resolve!

DB_URI = Settings.db_uri + "/" + Settings.db_name
p DB_URI
DataMapper.setup(:default, DB_URI)

class DatamobTag
  include DataMapper::Resource
  
  property :id, String, :key => true
  
  has n, :datamob_taggings
  has n, :datamob_listings, :through => :datamob_taggings 
  
end

class DatamobTagging
  include DataMapper::Resource
  
  property :dataset_id, Integer, :key => true
  property :tag_id,     String, :key => true, :index => :tag_id
  
  belongs_to :datamob_tag
  belongs_to :datamob_listing
  
end

class DatamobListing
  include DataMapper::Resource
  
  property :id,          Integer, :key => true
  property :name,        String
  property :link,        String, :length => 255
  property :description, Text
  property :image_url,   String, :length => 255
  property :thumb_url,   String, :length => 255
  property :dmob_link,   String, :length => 255
  
  has n, :datamob_taggings
  has n, :datamob_tags, :through => :datamob_taggings
  
end

# DatamobTag.auto_migrate!
# DatamobTagging.auto_migrate!
# DatamobListing.auto_migrate!

# DataMapper.auto_migrate!

# Need to load in data here first if not loaded already.  See bulk_load.sql

DatamobListing.all.each do |listing|
  taggings = DatamobTagging.all(:dataset_id => listing.id)
  listing.datamob_taggings = taggings
  listing.save
end

DatamobTag.all.each do |tag|
  taggings = DatamobTagging.all(:tag_id => tag.id)
  tag.datamob_taggings = taggings
  tag.save
end