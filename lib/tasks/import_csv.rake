require "csv"

namespace :import_csv do
  # タスクの説明
  desc "csvデータをインポートするタスク"

  task users: :environment do
    
    path = "db/csv_data/csv_data.csv"

    list = []

    CSV.foreach(path, headers: true) do |row|
      list << row.to_h
    end
    puts "インポート処理を開始"
    begin
      User.transaction do
        User.create!(list)
      end
      puts "インポート完了!!".green
    rescue StandardError => e
      puts "#{e.class}: #{e.message}".red
      puts "------------------------"
      puts e.backtrace
      puts "------------------------"
      puts "インポート失敗".red
    end
  end
end
