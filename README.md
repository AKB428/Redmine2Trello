#Redmine to Trello
 
 RedmineからTrelloへの移行ツール

## 事前準備
 - RubyとBundlerをインストール
 - このレポジトリを取得したディレクトリで bundle install でモジュールを取得
 - Trelloアカウントを取得 

## Trello開発者用キーの取得
 - アプリケーションKEY
 - アプリケーションSecretKey
 - アクセストークン
 - 上記を取得してconf/conf.jsonに書く

アクセストークンに関しては以下のようなURLにアクセスして書き込み権限を得る

https://trello.com/1/authorize?key=アプリケーションのkey&name=My+Application&expiration=1day&response_type=token&scope=read,write

上記だと1日でトークンが切れるので30日使いたかったら以下にする 1day -> 2日以上は2days

https://trello.com/1/authorize?key=ApplicationKey&name=My+Application&expiration=30days&response_type=token&scope=read,write

## 実行

redmineから出力したCSVを読み込みチケットを、[sprint 15]ボードの[NEW TASK]リストに追加する

	bundle exec ruby redmine2trello.rb "sprint 15" "NEW TASK" omega_project.csv


