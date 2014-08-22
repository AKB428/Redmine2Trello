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
      card_model = {}
      card_model["name"] = @csv_data[0]
      card_model["desc"] = @csv_data[1]
      card_models.push(card_model)
    end

    card_models
  end
end

end