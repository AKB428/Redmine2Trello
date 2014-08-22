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

board_name = ARGV[0]
list_name = ARGV[1]
csv_file = ARGV[2]

#csvを読んでカードモデルを生成
card_models = Trello_Data_Converter::Redmine.new(csv_file).csv_to_card_models()

#カードモデルを渡して登録
WrapTrello::Core.new(conf).regist_card_list(board_name, list_name, card_models)