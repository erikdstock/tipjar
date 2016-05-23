require 'rails_helper'
RSpec.describe LastfmApi do

  context "#get_recent_tracks" do
    let(:user) { FactoryGirl.create(:user) }

    it "returns a hash of headers" do
      stub_request(:get, "http://ws.audioscrobbler.com/2.0/?api_key=&format=json&method=user.getrecenttracks&period=1month&user=testuser").
         with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => api_stub(:lastfm_recent_tracks), :headers => {})
      api = LastfmApi.new
      expect(api.get_recent_tracks(user).headers).to be_a Hash
    end
  end
end
