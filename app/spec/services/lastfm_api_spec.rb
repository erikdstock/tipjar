require 'rails_helper'
RSpec.describe LastfmApi do
  let(:user) { FactoryGirl.build(:user) }
  let(:api) { LastfmApi.new(user) }
  context '#get_recent_tracks' do
    it 'returns a lastfm api response' do
      VCR.use_cassette('lastfm_user.getrecenttracks') do
        expect(api.get_recent_tracks).to be_a Hash
      end
    end
  end

  context '#get_top_artists' do
    let(:result) do
      VCR.use_cassette('lastfm_user.gettopartists') do
        api.get_top_artists
      end
    end

    it 'returns a lastfm api response' do
      expect(result).to be_a Hash
    end
  end
end
