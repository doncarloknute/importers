#!/usr/bin/env ruby
require 'rubygems'
require '../ImportYAML/importyaml'
require 'deelish-dm'
require 'digest/md5'
require 'restclient'
require 'json'

def md5 str
  Digest::MD5.hexdigest(str)
end

def delicious_usertag user,tag
  %Q{http://feeds.delicious.com/v2/json/#{user}/#{tag}?count=100}
end

User.all.each do |del_user|
  next if del_user.id == 'mrflip'
  del_user.tags.split(", ").each do |tag|
    del_url = delicious_usertag(del_user.id,tag)
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
      url_hash = md5(url)
      if url.length > 255
        warn "URL too long.  Setting to nil.  Use url_hash:#{url_hash} for future reference. \n #{url}"
        url = nil
      end
      # puts [url, md5(url), title, tags, timestamp, description, username].join("\t")
      bmark = Bookmark.create(:title => title, :description => description, :url => url, :url_hash => url_hash, :tags => tags, :user_id => username, :timestamp => timestamp)
      bmark.save
    end
  end
end