require 'rails_helper'

describe User, type: :model do
  include TimeHelpers
  let(:old_time) { DateTime.new(2016, 5, 12).utc }
  let(:old_time_range) { time_range_month(old_time) }

  describe 'associations' do
    it { should have_many :monthly_top_artists }
    it do
      should have_many(:top_artists).through(:monthly_top_artists).source(:artist)
    end
  end

  describe 'ListeningStats Module' do
    describe '#fetch_top_artists_by_period' do
      context 'using lastFm api' do
        let(:result) do
          user = build :user
          VCR.use_cassette('lastfm_fetch_top_artists', record: :once, :match_requests_on => [:host, :path]) do
            user.fetch_top_artists_by_period(
              from: old_time_range.first,
              to: old_time_range.last.utc
            )
          end
        end

        it 'returns an Array' do
          expect(result).to be_a(Array)
        end

        it 'returns an ordered list of artist data' do
          result.each do |artist_data|
            artist_hash = artist_data[0]
            play_count = artist_data[1]
            expected_keys = %w(name image play_count)
            expect artist_hash.keys.sort.to equal expected_keys.sort
            expect play_count.to be_a Fixnum
          end
        end
      end
    end

    describe '#top_artists_for_month' do
      let(:user) { create(:user) }
      let(:finalized_result) do
        create(:monthly_top_artist, user: user, month: old_time, play_count: 10)
        user.top_artists_for_month(old_time)
      end
      context '- data is complete - no external api call' do

        it 'returns an AR Relation' do
          expect(finalized_result).to be_a ActiveRecord::Relation
        end

        it 'contains monthly_top_artists data plus artist name and image attrs' do
          result = finalized_result.first
          expect { result.play_count && result.artist.name && result.artist.image }.not_to raise_error
        end

        it 'uses existing data if the data was refreshed after the month end' do
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
        skip 'Not Implemented'
      end
    end
  end
end
