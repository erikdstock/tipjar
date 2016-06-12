require 'rails_helper'
RSpec.describe LastfmApi do

  context "#get_recent_tracks" do
    let(:user) { FactoryGirl.build(:user) }

    it "returns a lastfm api response" do
      skip "need a stub for this. maybe look into vcr?"
      stub_request(:get, /audioscrobbler.*method=user.getrecenttracks/)
        .with(:headers => {'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby'})
        .to_return(:status => 200, :body => api_stub(:lastfm_recent_tracks), :headers => {})
      api = LastfmApi.new
      expect(api.get_recent_tracks(user)).to be_a Hash
    end
  end


  context "#get_top_artists" do
    let(:user) { FactoryGirl.build(:user) }

    it "returns a lastfm api response" do
      stub_request(:get, /audioscrobbler.*method=user.gettopartists/)
        .with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'})
        .to_return(:status => 200, :body => api_stub(:lastfm_top_artists), :headers => {})
      api = LastfmApi.new
      expect(api.get_top_artists(user)).to be_a Hash
    end
  end
end
