require 'rails_helper'
RSpec.describe LastfmApi do

  context "#get_recent_tracks" do
    let(:user) { FactoryGirl.build(:user) }

    it "returns a lastfm api response" do
      # !!! Webmock
      # stub_request(:get, /audioscrobbler.*method=user.getrecenttracks/)
      #   .with(:headers => {'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby'})
      #   .to_return(:status => 200, :body => api_stub(:lastfm_recent_tracks), :headers => {})
      VCR.use_cassette("lastfm_user.getrecenttracks_1") do
        api = LastfmApi.new
        expect(api.get_recent_tracks(user)).to be_a Hash
      end
    end
  end

  context "#get_top_artists" do
    let(:user) { FactoryGirl.build(:user) }
    let(:result) do
      # !!! Webmock
      # stub_request(:get, /audioscrobbler.*method=user.gettopartists/)
      #   .with(:headers => {'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby'})
      #   .to_return(:status => 200, :body => api_stub(:lastfm_top_artists), :headers => {})
      VCR.use_cassette("lastfm_user.gettopartists") do
        api = LastfmApi.new
        api.get_top_artists(user)
      end
    end

    it "returns a lastfm api response" do
      expect(result).to be_a Hash
    end
  end
end
