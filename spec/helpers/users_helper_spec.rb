require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do

  context '#top_artist_attributes' do
    it "returns a string containing the desired attributes" do
      expect(helper.top_artist_attributes).to be_a String
      expect(helper.top_artist_attributes).to eq(
        "artists.name, artists.image, month, play_count, " +
        "user_id, artist_id, monthly_top_artists.updated_at"
      )
    end
  end

  context '#validate_time' do
    it "raises the proper error if the month begins in the future" do
      time = DateTime.new(2017, 3, 9)
      message = 'month is in the future'
      expect{helper.validate_time(time)}.to raise_error(RuntimeError, message)
    end
  end

  context '#time_range_month' do
    it 'returns a range' do
      time = DateTime.new(2017, 3, 9)
      expect(helper.time_range_month(time)).to be_a Range
    end
  end

  context '#month_start' do
    it 'returns a DateTime object with the first day of the month' do
      time = DateTime.new(2017, 3, 9)
      expect(helper.month_start(time)).to be_a DateTime
      expect(helper.month_start(time)).to eq "Wed, 01 Mar 2017 00:00:00.000000000 +0000"
    end
  end

  context '#month_end' do
    it 'returns a DateTime object with the last day of the month' do
      time = DateTime.new(2017, 3, 9)
      expect(helper.month_end(time)).to be_a DateTime
      expect(helper.month_end(time)).to eq "Fri, 31 Mar 2017 23:59:00.000000000 +0000"
    end
  end

end