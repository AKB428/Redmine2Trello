require 'trello'
include Trello
include Trello::Authorization

module WrapTrello
  class Core

  def initialize(conf)
    Trello::Authorization.const_set :AuthPolicy, OAuthPolicy
    OAuthPolicy.consumer_credential = OAuthCredential.new conf["key"], conf["secret"]
    OAuthPolicy.token = OAuthCredential.new conf["access_token_key"], nil
    @me = Trello::Member.find("me")
  end

  def regist_model_list(wrap_trello_model_list)

    wrap_trello_model_list.each do |board_name, lists|
      board_object = regist_board(board_name)

      lists.each do |list_name, cards|
        list_object = regist_list(board_object.id, list_name)

        cards.each do |card_model|
          regist_card(list_object.id, card_model)
        end
      end

    end
  end

    def regist_board(board_name)
      # 既存にあったら追加せずオブジェクトを返す
      @me.boards.each do |board|
        if board.name == board_name && !board.closed?
          return board
        end
      end

      # なかったら作成する
      puts "create board = " + board_name
      Board.create(:name => board_name)
    end

    def regist_list(board_id, list_name)
      # 既存にあったら追加せずオブジェクトを返す
      Board.find(board_id).lists.each do |list|
        if list.name == list_name
          return list
        end
      end

      # なかったら作成する
      puts "create list = " + list_name
      List.create(:name => list_name, :board_id => board_id)
    end

    def regist_card(list_id, card_model)
      # 既存にあったら追加せずオブジェクトを返す
      @cards ||= List.find(list_id).cards

      @cards.each do |card|
        if card.name == card_model['name']
          return card
        end
      end

      # なかったら作成する
      puts "create card = " + card_model['name']

      card = Card.create(:name => card_model['name'], :list_id => list_id, :desc => card_model['desc'])

      if(card_model.has_key?("attachment"))
        attachment = File::open(card_model["attachment"])
        card.add_attachment(attachment)
      end
    end

    def regist_card_list(target_board_name, target_list_name, card_model_list)
      board_id = nil
      list_id = nil

      @me.boards.each do |board|
        if board.name == target_board_name
          board_id = board.id
          break
        end
      end

      unless board_id
        puts "ボードが見つかりません"
        throw Exception;
      end

      Board.find(board_id).lists.each do |list|
        if list.name == target_list_name
          list_id = list.id
          break
        end
      end

      unless list_id
        puts "リストが見つかりません"
        throw Exception;
      end

      card_model_list.each do |card_model|
        regist_card(list_id, card_model)
      end
    end
  end
end