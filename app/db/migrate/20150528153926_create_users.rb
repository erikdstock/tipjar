class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string  :password
      t.string  :email
      t.string  :name
      t.string  :image

      t.string :uid
      t.string :provider

      t.timestamps null: false

      ####
      # ## Rememberable
      # t.datetime :remember_created_at

      # ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

    end

    add_index :users, :uid, unique: true
  end
end
