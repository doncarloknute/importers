#!/usr/bin/env ruby
require 'rubygems'
require '../ImportYAML/importyaml'
require 'deelish-dm'
require 'open-uri'

del_user = User.get(2)

del_user.tags.split(", ").each do |tag|
  open('http://feeds.delicious.com/v2/json/' + del_user.name + '/' + tag + '?count=100').each do |line|
    line.split("},{").each do |link|
      link.gsub!(/\\\//,'/')
      link.gsub!(/\\\"/,'')
      if link =~ /\"u\"\:\"([^\"]+)\"\,\"d\"\:\"([^\"]+)\"\,\"t\"\:\[([^\]]+)\]\,\"dt\"\:\"([^\"]+)\"\,\"n\"\:\"([^\"]+)\"\,\"a\"\:\"([^\"]+)\"/
        url, title, tags, timestamp, description, username = [$1, $2, $3, $4, $5, $6]
        puts [url, title, tags.delete('"'), timestamp, description, username].join("\t")
#        bmark = Bookmark.new(:title => title, :description => description, :url => url, :tags => tags.delete('"'), :user => username, :timestamp => timestamp)
      end
    end
  end
end