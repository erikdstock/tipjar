require 'rails_helper'

describe User, type: :model do
  describe 'ListeningStats Module' do
    describe '#api_top_artists' do
      it 'returns an Array' do
        user = create :user
        stub_request(:get, "http://ws.audioscrobbler.com/2.0/?api_key=&format=json&method=user.gettopartists&user=testuser")
          .with(:headers => {'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby'})
          .to_return(:status => 200, :body => api_stub(:lastfm_top_artists), :headers => {})
        result = user.api_top_artists
        expect(result).to be_a(Array)
      end
    end

    describe '#monthly_top_artists' do
      context 'data is complete' do
        it 'returns an AR Relation' do
          user = create(:user)
          create(:monthly_top_artist, user: user, month: 2.months.ago)
          expect(user.monthly_top_artists(2.months.ago)).to be_a ActiveRecord::Relation
        end

        it 'contains monthly_top_artists data plus artist name and image attrs' do
          user = create(:user)
          create(:monthly_top_artist, user: user, month: 2.months.ago)
          result = user.monthly_top_artists(2.months.ago).first
          expect { result.name && result.image }.not_to raise_error
        end

        it 'uses existing data if the data was refreshed after the month end' do
          skip
        end

        it 'uses existing data if the data was refreshed in the past 24 hours' do
          skip
        end

      end

      it 'calls the api if data is stale (more than 24 hours old)' do
        skip
      end

      it 'calls the api if there is no data for the month' do
        skip
      end

      it 'can be overridden to refresh with api data' do
        skip
      end

      it 'merges play count into each artist' do
        skip
      end

    end
  end
end
