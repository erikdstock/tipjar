require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do

  describe '#top_artist_attributes' do
    it "returns a string containing the desired attributes" do
      expect(helper.top_artist_attributes).to be_a String
      expect(helper.top_artist_attributes).to eq(
        "artists.name, artists.image, month, play_count, " +
        "user_id, artist_id, monthly_top_artists.updated_at"
      )
    end
  end

  describe '#validate_time' do
    it "raises the proper error if the month begins in the future" do
      time = DateTime.new(2017, 3, 9)
      message = 'month is in the future'
      expect{helper.validate_time(time)}.to raise_error(RuntimeError, message)
    end
  end

end