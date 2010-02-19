#!/usr/bin/env ruby
require 'rubygems'
require 'dm-core'
require 'dm-types'
require 'configliere'
Settings.use :config_file, :define, :commandline
Settings.read 'cong_dist.yaml'  # ~/.configliere/ip_census.yaml
Settings.define :db_uri,  :description => "Base URI for database -- eg mysql://USERNAME:PASSWORD@localhost:9999", :required => true
Settings.define :db_name, :description => "Database name to use", :required => true
Settings.resolve!

DB_URI = Settings.db_uri + "/" + Settings.db_name
p DB_URI
DataMapper.setup(:default, DB_URI)

class District
  include DataMapper::Resource
  
  property :district_id, Integer, :key => true
  property :zip5,        Integer
  property :zip4min,     Integer
  property :zip4max,     Integer
  property :state,       String, :length => 2
  property :district,    Integer
  
end

class Location
  include DataMapper::Resource
  
  property :id,           Integer, :key => true
  property :country_code, String, :key => true
  property :region_code,  String, :key => true
  property :city,         String, :key => true
  property :postal_code,  String
  property :latitude,     Float
  property :longitude,    Float
  property :metro_code,   Integer
  property :area_code,    Integer
  
end

class Endorsement
  include DataMapper::Resource
  
  property :id,        String, :key => true
  property :prez_2008, String
  property :prez_2004, String
  property :prez_2000, String
  property :prez_1996, String
  property :prez_1992, String
  property :rank,      Integer
  property :circ,      Integer
  property :daily,     Integer
  property :sun,       Integer  
  property :lat,       Float  
  property :lng,       Float  
  property :st,        String, :key => true  
  property :city,      String
  property :paper,     String
  property :pop,       Integer  
  
end
