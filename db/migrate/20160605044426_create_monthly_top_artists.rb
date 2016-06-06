class CreateMonthlyTopArtists < ActiveRecord::Migration
  def change
    create_table :monthly_top_artists do |t|
      t.integer :artist_id
      t.integer :user_id
      t.integer :play_count
      t.datetime :month

      t.timestamps null: false
    end
  end
end
