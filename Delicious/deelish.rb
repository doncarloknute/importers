#!/usr/bin/env ruby
require 'rubygems'
require '../ImportYAML/importyaml'
require 'deelish-dm'
require 'restclient'
require 'json'

def delicious_usertag user,tag
  %Q{http://feeds.delicious.com/v2/json/#{user}/#{tag}}
end

del_user = User.get(2)

del_user.tags.split(", ").each do |tag|
  del_url = delicious_usertag(del_user.name,tag)
  begin
    del_json =  RestClient.get(del_url)
  rescue RuntimeError => e
    warn "Dataset #{dataset_id} error fetching #{del_url}: #{e}"
    sleep 5
    next
  end
  del_taggings = JSON.load(del_json)
  next if del_taggings.blank?
  del_taggings.each do |del_hsh|
    url, timestamp, username, title, description, tags = del_hsh.values_at("u", "dt", "a", "d", "n", "t")
    tags = tags.join(",")
    puts [url, title, tags, timestamp, description, username].join("\t")
    # bmark = Bookmark.create(:title => title, :description => description, :url => url, :tags => tags, :user => username, :timestamp => timestamp)
    # bmark.save
  end
end