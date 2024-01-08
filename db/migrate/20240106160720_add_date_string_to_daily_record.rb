class AddDateStringToDailyRecord < ActiveRecord::Migration[7.1]
  def change
    add_column :daily_records, :date_string, :string
  end
end
