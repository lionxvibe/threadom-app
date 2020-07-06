class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :uid, null: false, unique: true
      t.string :provider, null: false
      t.string :name, null: false
      t.string :nickname, null: false
      t.boolean :is_locked, default: false
      t.boolean :is_admin, default: false

      t.string :timezone, default: 'UTC'

      t.string :access_token, nullable: false
      t.string :access_token_secret, nullable: false

      t.timestamps
    end
  end
end
