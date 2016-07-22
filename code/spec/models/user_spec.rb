require 'rails_helper'
include TimeTools

describe User, type: :model do
  let(:old_time) { DateTime.new(2016, 5, 12).utc }
  before(:all) do
    travel_to Time.new(2016, 6, 2).utc
  end

  def expect_valid_monthly_top_artists(monthly_top_artists, expect_empty: false)
    expect(monthly_top_artists).to be_a ActiveRecord::Relation
    expect_empty ? (expect(monthly_top_artists.length).to eq(0)) : (expect(monthly_top_artists.length).to be > 0)
  end

  describe 'associations' do
    it { should have_many :monthly_top_artists }
    it do
      should have_many(:top_artists).through(:monthly_top_artists).source(:artist)
    end
  end

  # This is the main entry point for the app to a user's top artist data.
  describe '#top_artists_for_month' do
    let(:user) { create(:user) }
    let(:finalized_result) do
      create(:monthly_top_artist, user: user, month: old_time, play_count: 10)
      user.top_artists_for_month(old_time)
    end

    context 'finalized structure for good data' do
      it 'returns an AR Relation' do
        expect_valid_monthly_top_artists(finalized_result)
      end

      it 'contains monthly_top_artists data plus artist name and image attrs' do
        result = finalized_result.first
        expect { result.play_count && result.artist.name && result.artist.image }.not_to raise_error
      end
    end
  end

  describe 'ListeningStats Module' do
    describe '#fetch_top_artists_by_period' do
      context 'using lastFm api' do
        let(:result) do
          user = build :user
          old_time_range = time_range_month(old_time)
          VCR.use_cassette('lastfm_fetch_top_artists', record: :once, :match_requests_on => [:host, :path]) do
            user.fetch_top_artists_by_period(
              from: old_time_range.first,
              to: old_time_range.last.utc
            )
          end
        end

        it 'returns a Hash with proper structure' do
          expect(result).to be_a(Hash)
          result.each do |key, val|
            expect(key).to be_a(String)
            expect(val).to be_a(Hash)
            expect(val[:image]).to be_a(String)
            expect(val[:play_count]).to be_a(Fixnum)
          end
        end
      end
    end
  end
end
