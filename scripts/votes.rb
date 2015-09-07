#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'yaml'

NUM_TALKS = 12

def talk_uri(talk)
  "http://www.geekcamp.sg/talks/#{talk['slug']}.html"
end

def script_path
  File.expand_path(File.dirname(__FILE__))
end

talks = YAML.load_file("#{script_path}/../_data/talks.yml")

talks.each do |talk|
  uri = URI("http://graph.facebook.com/#{talk_uri talk}")
  data = Net::HTTP.get(uri)
  js = JSON.parse(data)
  talk[:votes] = js.fetch('shares', 0)
end

talks.sort_by! { |t| t[:votes] }
talks.reverse!

talks.take(NUM_TALKS).each do |talk|
  puts "#{talk[:votes]}\t#{talk_uri talk}"
end
puts '-'*20 + '>8' + '-'*20
talks.drop(NUM_TALKS).each do |talk|
  puts "#{talk[:votes]}\t#{talk_uri talk}"
end
