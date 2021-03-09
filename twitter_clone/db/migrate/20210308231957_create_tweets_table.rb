class CreateTweetsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets_tables do |t|
      t.text :tweet
      t.timestamps
    end
  end
end
