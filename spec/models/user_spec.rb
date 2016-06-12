require 'rails_helper'

describe User, type: :model do

  describe 'associations' do
    it { should have_many :monthly_top_artists }
    it do
      should have_many(:top_artists).through(:monthly_top_artists).source(:artist)
    end
  end

  describe 'ListeningStats Module' do
    describe '#fetch_top_artists_by_period' do
      let(:result) do
        user = build :user
        time = 2.months.ago
        stub_request(:get, /audioscrobbler.*user.gettopartists/)
          .with(:headers => {'Accept' => '*/*; q=0.5, application/xml', 'Accept-Encoding' => 'gzip, deflate', 'User-Agent' => 'Ruby'})
          .to_return(:status => 200, :body => api_stub(:lastfm_top_artists), :headers => {})
        user.fetch_top_artists_by_period(
          from: DateTime.new(time.year, time.month, 1).utc,
          to: DateTime.new(time.year, time.month, -1, -1, -1).utc
        )
      end

      it 'returns an Array' do
        expect(result).to be_a(Array)
      end

      it 'is an ordered list of data like [{artist}, play_count]' do
        result.each do |artist_data|
          artist_hash = artist_data[0]
          play_count = artist_data[1]
          expected_keys = %w(name image play_count)
          expect artist_hash.keys.sort.to equal expected_keys.sort
          expect play_count.to be_a Fixnum
        end
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
          expect { result.artist.name && result.artist.image }.not_to raise_error
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
