#!/usr/bin/env ruby
require 'rubygems'
require '../ImportYAML/importyaml'
require 'deelish-dm'

collection_yaml = [{'collection'=>{'title'=>"mrflip's Delicious Links",
  'description'=>''}}]

datatset = DatasetYAML.new('collection'=>"mrflip's Delicious Links",'owner'=>'doncarlo')