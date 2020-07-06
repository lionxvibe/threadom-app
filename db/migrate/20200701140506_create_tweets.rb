class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.belongs_to :twitter_thread
      t.string :content
      t.integer :position, null: false

      t.timestamps
    end
  end
end
