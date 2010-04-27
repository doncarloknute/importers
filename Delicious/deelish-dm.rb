#!/usr/bin/env ruby
require 'rubygems'
require 'dm-core'
require 'dm-types'
require 'configliere'
Settings.use :config_file, :define, :commandline
Settings.read 'deelish-dm.yaml'  # ~/.configliere/deelish-dm.yaml
Settings.define :db_uri,  :description => "Base URI for database -- eg mysql://USERNAME:PASSWORD@localhost:9999", :required => true
Settings.define :db_name, :description => "Database name to use", :required => true
Settings.resolve!

# DataMapper::Logger.new(STDOUT, 0)
DB_URI = Settings.db_uri + "/" + Settings.db_name
p DB_URI
DataMapper.setup(:default, DB_URI)

class Bookmark
  include DataMapper::Resource
  
  property :id,          Serial
  property :title,       String, :length => 255
  property :description, Text
  property :url,         String, :length => 255
  property :url_hash,    String, :length => 32
  property :tags,        Text
  property :user_id,     String, :index => :user_id
  property :timestamp,   DateTime, :index => :timestamp
  property :uploaded_on, DateTime, :index => :uploaded_on
  
  has 1, :user, :child_key => [:id], :parent_key => [:user_id]
  
end

class User
  include DataMapper::Resource

  property :id, String, :key => true
  property :tags, Text
  
  has n, :bookmarks, :child_key => [:user_id], :parent_key => [:id]

end

# Bookmark.auto_migrate!
# User.auto_migrate!