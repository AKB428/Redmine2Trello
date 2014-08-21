require './lib/wrap_trello/core.rb'
require 'json'

conf = nil
File.open './conf/conf.json' do |file|
   conf = JSON.load(file.read)
end

if ARGV.length < 3
  puts "usage"
  puts "./redmine2trello [board_name] [list_name] [redmine.csv]"
  exit
end

#csvを読んでカードモデルを生成

WrapTrello::Core.new(conf);