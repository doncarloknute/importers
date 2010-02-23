#!/usr/bin/env ruby
require 'rubygems'
require 'yaml'

class DatasetYAML
  
  attr_accessor :title, 
                :subtitle, 
                :description, 
                :owner,
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
