require 'csv'
module Trello_Data_Converter


  class Redmine
    ENCODE_CONVERT_DIRECTORY = "./convertUTF8/"

    def initialize(csv_file_path)
      csv_file_path = csv_file_path

      original_data = File.read(csv_file_path, encoding: 'cp932')
      convert_data = original_data.encode('UTF-8', 'cp932')
      convert_file_path =  ENCODE_CONVERT_DIRECTORY + "convert.csv"

      File.open convert_file_path, 'w' do |f|
        f.write convert_data
      end

      @csv_data = CSV.read(convert_file_path)
    end

    def csv_to_card_models()
      card_models = []
      card_model = {}

      @csv_data.each do |csv|

        if (csv[0] == "#")
          next
        end

        card_model = {}
        card_model["name"] = "(" + csv[1].to_i.to_s + ") " + " #" + csv[0] + " " + csv[2]
        card_model["desc"] = csv[3]
        card_models.push(card_model)
      end

      card_models
    end

    def null_to_blank_string(v)
      return "" if v.nil?
      v
    end

  end

end