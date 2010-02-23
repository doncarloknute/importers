#!/usr/bin/env ruby
require 'rubygems'
require 'dm-core'
require 'dm-types'
require 'configliere'
Settings.use :config_file, :define, :commandline
Settings.read 'cong_dist.yaml'  # ~/.configliere/cong_dist.yaml
Settings.define :db_uri,  :description => "Base URI for database -- eg mysql://USERNAME:PASSWORD@localhost:9999", :required => true
Settings.define :db_name, :description => "Database name to use", :required => true
Settings.resolve!

DataMapper::Logger.new(STDOUT, 0)
DB_URI = Settings.db_uri + "/" + Settings.db_name
p DB_URI
DataMapper.setup(:default, DB_URI)

class Districting
  include DataMapper::Resource
  
  property :id,          Serial
  property :postal_code, Integer, :index => :postal_code
  property :zip4min,     Integer, :index => :zip4min 
  property :zip4max,     Integer, :index => :zip4max
  property :state,       String, :length => 2, :index => :state
  property :district_id, Integer, :index => :district_id
  
  has n, :locations, :child_key => [:postal_code], :parent_key => [:postal_code]
  has n, :newspapers, :through => :locations, :child_key => [:postal_code], :parent_key => [:postal_code]
  
end

class Location
  include DataMapper::Resource
  
  property :id,           Integer, :key => true
  property :country_code, String, :index => :country_code
  property :city,         String, :index => :city_region
  property :region_code,  String, :index => :city_region
  property :postal_code,  String, :index => :postal_code
  property :latitude,     Float
  property :longitude,    Float
  property :metro_code,   Integer
  property :area_code,    Integer
  
  has n, :newspapers, :child_key => [:city,:region_code], :parent_key => [:city,:region_code]
  has n, :districtings, :child_key => [:postal_code], :parent_key => [:postal_code]
  
end

class Newspaper
  include DataMapper::Resource
  
  property :id,           String, :key => true
  property :prez_2008,    String
  property :prez_2004,    String
  property :prez_2000,    String
  property :prez_1996,    String
  property :prez_1992,    String
  property :rank,         Integer
  property :circ,         Integer
  property :daily,        Integer
  property :sun,          Integer  
  property :lat,          Float  
  property :lng,          Float  
  property :city,         String, :index => :city_region
  property :region_code,  String, :index => :city_region, :index => :region  
  property :country_code, String, :index => :country_code
  property :paper,        String
  property :pop,          Integer 
  
  has n, :locations, :child_key => [:city,:region_code], :parent_key => [:city,:region_code]
  
end

# Districting.auto_migrate!
# Location.auto_migrate!
# Newspaper.auto_migrate!
