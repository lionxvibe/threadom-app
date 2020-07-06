class CreateTwitterThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :twitter_threads do |t|
      t.datetime :scheduled_at
      t.datetime :posted_at
      t.belongs_to :user

      t.timestamps
    end
  end
end
