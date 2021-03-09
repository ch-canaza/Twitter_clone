class ChangeTweetsTablesName < ActiveRecord::Migration[6.1]
  def change
    rename_table :tweets_tables, :tweets
  end
end
