#!/usr/bin/env ruby
require 'rubygems'
require 'yaml'
require 'data_dump'

yaml_path = '/Users/doncarlo/data/datamob_dump/yaml/'

def textile_helper text
  textile_text = text.to_s
  textile_text.gsub!(/\<\/?[Pp]\>/,'')
  textile_text.gsub!(/(\<[Bb][Rr]\/?\>)+/,'
')
  textile_text.gsub!(/\<\/?i\>/,'_')
  textile_text.gsub!(/\<\/?strong\>/,'*')
  textile_text.gsub!(/\<\/?b\>/,'*')
  textile_text.gsub!(/\&mdash\;/,'--')
  textile_text.gsub!(/\<a href\s?=\s?\"\"?([^\"]+)\"\"?\>([^<]+)\<\/a\>/,'["\2":\1]')
  textile_text.gsub!(/\"\"/,'"')
  textile_text
end

sources = [{'source'=>{'title'=>'Datamob','main_link'=>'http://www.datamob.org','description'=>'Datamob aims to show, in a very simple way, how public data sources are being used.

Their listings emphasize the connection between data posted by governments and public institutions and the interfaces people are building to explore that data.'}}]

collection = [{'collection'=>{'title'=>'Datamob','description'=>'Datamob aims to show, in a very simple way, how public data sources are being used.

Their listings emphasize the connection between data posted by governments and public institutions and the interfaces people are building to explore that data.'}}]

base_yaml = [{'dataset'=>{
  'title'=>'',
  'description'=>'',
  'main_link'=>'',
  'collection'=>'Datamob',
  'owner'=>'doncarlo',
  'protected'=>'true',
  'tags'=>[],
  'sources'=>[]
}}]

collection_file = File.open(yaml_path + 'datamob_collection.yaml','w')
collection_file << collection.to_yaml
sources_file = File.open(yaml_path + 'datamob_sources.yaml','w')
sources_file << sources.to_yaml

# images_file = File.open(yaml_path + 'datamob_images.sh','w')


DatamobListing.all.each do |@dataset|
  current_yaml = base_yaml.dup
  current_yaml[0]['dataset']['title'] = @dataset.name
  if @dataset.image_url != ''
    current_yaml[0]['dataset']['description'] = '!http://assets2.infochimps.org/static/images/ds/datamob-' + @dataset.image_url[7..-1] + '!:' + @dataset.dmob_link + '
' + textile_helper(@dataset.description)
#    puts '_________________________'
#    puts current_yaml[0]['dataset']['description']
  else  
    current_yaml[0]['dataset']['description'] = textile_helper(@dataset.description)
  end
  current_yaml[0]['dataset']['main_link'] = @dataset.dmob_link
  current_yaml[0]['dataset']['tags'] = []
  @dataset.datamob_tags.each do |tag|
    current_yaml[0]['dataset']['tags'] += [tag.id]
  end
#  sources += [{'source'=>{'title'=>@dataset.name,'main_link'=>@dataset.link,'description'=>textile_helper(@dataset.description)}}]
  current_yaml[0]['dataset']['sources'] = []
  current_yaml[0]['dataset']['sources'] = ['Datamob', {'title'=>@dataset.name,'main_link'=>@dataset.link,'description'=>textile_helper(@dataset.description)}]
#  images_file << 'http://datamob.org' + @dataset.image_url + "\n"
  yaml_file = File.open(yaml_path + 'datamob_' + @dataset.image_url[14..-5] + '.yaml', 'w')
  yaml_file << current_yaml.to_yaml
#  puts current_yaml.to_yaml
end

