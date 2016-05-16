require 'rails_helper'

describe User, type: :model do
  describe 'ListeningStats Module' do
    describe '#get_top_artists' do
      it 'returns an Array' do
        user = create :user
        stub_request(:get, "http://ws.audioscrobbler.com/2.0/?method=user.getTopArtists&user=testuser")
          .to_return(:status => 200, :body => api_stub(:lastfm_top_artists), :headers => {})
        expect(user.get_top_artists).to be_a(Array)
      end
    end
  end
end
