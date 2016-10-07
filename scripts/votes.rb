#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'yaml'

NUM_TALKS = 8

def talk_uri(talk)
  "https://www.geekcamp.sg/talks/#{talk['slug']}.html"
end

def script_path
  File.expand_path(File.dirname(__FILE__))
end

talks = YAML.load_file("#{script_path}/../_data/talks.yml")

talks.each do |talk|
  uri = URI("http://graph.facebook.com/#{talk_uri talk}")
  data = Net::HTTP.get(uri)
  js = JSON.parse(data)
  talk[:votes] = js.fetch('share', {}).fetch('share_count', -1)
  sleep(20)
end

talks.select! { |t| !t['hidden'] }

talks.sort_by! { |t| t[:votes] }
talks.reverse!

talks.take(NUM_TALKS).each do |talk|
  puts "#{talk[:votes]}\t#{talk['slug']}"
end
puts '-'*20 + '>8' + '-'*20
talks.drop(NUM_TALKS).each do |talk|
  puts "#{talk[:votes]}\t#{talk['slug']}"
end
