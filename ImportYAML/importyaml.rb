#!/usr/bin/env ruby
require 'rubygems'
require 'yaml'

# - dataset:
#     title: The title of this dataset
#     subtitle: The subtitle of this dataset
#     main_link: http://www.google.com
#     protected: false
#     description: >-
# 
#       This is my dataset
# 
#     # can be either strings or numeric IDs
#     owner: Infochimps
# 
#     # can be either a string giving an existing collection's title,
#     # handle, or ID or a hash giving a new collection's attributes
#     collection: My Awesome Datasets
#     # or (but not both)
#     collection:
#       title: My Awesome Datasets
#       description: They are really cool
#
#     # tags are always referred to by name, never ID
#     tags:
#       - money
#       - finance
#       - stocks
# 
#     # categories can be referred to by path or ID    
#     categories:
#       - "Social Sciences::Education"
#       - 82
# 
#     # existing sources can be referred to by title or ID if they
#     # already exist
#     sources:
#       - The first source
#       - 1938
#       - The third source
#       # but you can also create a source inline by using a hash with
#       # attributes
#       - title: A new source
#         description: What this new source is like
#         main_link: http://foobar.com
#
#     # payloads can be created as nested subresources
#     payloads:
#       - title: A payload
#       # ... and so on, check the required YAML for payloads to learn
#       # more


# Any payload hash with a key "files_to_upload" will cause the importer
# to output a YAML file consisting of new payload IDs mapped to the list
# of files to upload.  This YAML file can subsequently be fed to the
# bulk upload script.
# 
# - payload:
#     title: The name of this payload
#     fmt: csv
#     price: 10000
#     protected: true
# 
#     # the following can be either strings or numeric IDs
#     dataset: Some Infochimps Dataset
#     owner: Infochimps
# 
#     # An existing license can be referred to by name and a new license
#     # an be created inline by using a hash
#     license: MIT License
#     # or (but not both)
#     license:
#       title: My New License
#       main_link: http://foobar.com
#       description: Whatever dude
#
#     schema_fields:
#       - handle: AvgLength
#         unit:  km
#         datatype: float
#
#         # can be either a string or the numeric ID of a schema_field
#         title: Average Length
#
#         description: >-
#           Average length measurements are defined over...
#
#     snippets:
#       - columns:
#         - FirstField
#         - SecondField
#         data:
#         # give each row of data on its own line
#         - [1,2,3]
#         - ['a', 'b', 'c']
#         - # or split each row and have each entry on a line
#           - 1
#           - 2
#           - 3
#       - columns: ["Another Field", "Yet Another Field"]
#         data: [[1,2,3],[4,5,6],[7,8,9]]
#
#     # list of local paths (relative to this YAML file) to upload.
#     # will be incorporated into an output YAML file suitable for the
#     # bulk uploader.
#     files_for_upload:
#       - relative/path/to/data
#       - /absolute/path/to/data
#       - ../another/relative/path/to/data

# - source:
#     title: The title of this source
#     main_link: "http://www.google.com"
#     description: >-
#
#       This is some description

# - collection:
#     title: The title of this collection
#     description: >-
#
#       This is some description

class PayloadYAML
  attr_accessor :title,
                :description,
                :fmt,
                :price,
                :owner,
                :protected,
                :license,
                :records_count,
                :upload_files
                
  def initialize *args
    return if args.empty?
    args[0].each {|key,value| instance_variable_set("@#{key}", value) }
  end
  
  def to_a
    if @title == nil || @description == nil || @fmt == nil || @license == nil || @owner == nil
      warn "A payload needs a title, description, owner, format, and license."
    end
    @@payload_arry = [{'title'=>@title,
      'description'=>@description,
      'fmt'=>@fmt,
      'owner'=>@owner,
      'license'=>@license}]
    if @upload_files.is_a?(String)
      @@payload_arry[0]['files_for_upload'] = @upload_files.split(", ")
    end
    if @upload_files.is_a?(Array)
      @@payload_arry[0]['files_for_upload'] = @upload_files
    end
    @@payload_arry[0]['protected'] = @protected if @protected != nil
    @@payload_arry[0]['records_count'] = @records_count if @records_count != nil
    @@payload_arry[0]['price'] = @price if @price != nil
    @@payload_arry
  end
  
  def to_yaml
    @@payload_yaml = [{'payloads'=>self.to_a}]
    @@payload_yaml.to_yaml
  end
  
end

class DatasetYAML
  
  attr_accessor :title, 
                :subtitle,
                :main_link, 
                :description, 
                :owner,
                :protected,
                :tags, 
                :categories,
                :collection, 
                :sources,
                :payloads
  
  def initialize *args
    return if args.empty?
    args[0].each {|key,value| instance_variable_set("@#{key}", value) }
  end
  
  def to_yaml
    @@constructed_yaml = [{'dataset'=>{
      'title'=>@title,
      'subtitle'=>@subtitle,
      'description'=>@description,
      'owner'=>@owner,
      'tags'=>@tags,
      'categories'=>@categories,
      'collection'=>@collection,
      'sources'=>@sources,
      'payloads'=>@payloads
      }}]
    @@constructed_yaml.to_yaml
  end    
  
end
