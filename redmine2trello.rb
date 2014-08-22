require './lib/wrap_trello/core.rb'
require './lib/trello_data_converter/redmine.rb'
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

csv_file = ARGV[2]

#csvを読んでカードモデルを生成
Trello_Data_Converter::realtime.new(csv_file)

#カードモデルを渡して登録
WrapTrello::Core.new(conf)