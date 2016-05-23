require 'rails_helper'

describe User, type: :model do
  describe 'ListeningStats Module' do
    describe '#get_top_artists' do
      it 'returns an Array' do
        user = create :user
        stub_request(:get, "http://ws.audioscrobbler.com/2.0/?api_key=&format=json&method=user.gettopartists&user=testuser").
         with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => api_stub(:lastfm_top_artists), :headers => {})
        result = user.get_top_artists
        expect(result).to be_a(Array)
      end
    end
  end
end
