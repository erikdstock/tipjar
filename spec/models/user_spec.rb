require 'rails_helper'

describe User, type: :model do
  include TimeHelpers
  let(:old_time) { DateTime.new(2016, 5, 12).utc }

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
  # May want to define/test explicit structure with #expect_valid_monthly_top_artists above
  #
  describe '#top_artists_for_month' do
    let(:user) { create(:user) }
    let(:finalized_result) do
      create(:monthly_top_artist, user: user, month: old_time, play_count: 10)
      user.top_artists_for_month(old_time)
    end

    # If data is complete (month is over & updated after month end) no api
    # call will be made- VCR/Webmock will block these calls since they are not
    # wrapped in a VCR.use_casette block
    context '- data is complete - no external api call' do
      it 'returns an AR Relation' do
        expect_valid_monthly_top_artists(finalized_result)
      end

      it 'contains monthly_top_artists data plus artist name and image attrs' do
        result = finalized_result.first
        expect { result.play_count && result.artist.name && result.artist.image }.not_to raise_error
      end
    end

    context '- data is unreliable - refreshes with api' do
      let(:this_month_time) { month_start(DateTime.now.utc) }
      let(:stale_time) { DateTime.new(2016, 3, 12).utc }
      let(:this_month_result) do
        create(:monthly_top_artist, user: user, month: this_month_time, play_count: 10)
        user.top_artists_for_month(old_time)
      end
      let(:stale_result) do
        create(:monthly_top_artist, user: user, month: old_time, play_count: 10, updated_at: (this_month_time + 1.hour))
        user.top_artists_for_month(old_time)
      end

      it 'calls the api if data is from the current month' do
        VCR.use_cassette 'lastfm_user_getrecenttracks_this_month' do
          Rails.logger.warn 'assert that api is actually called? or maybe not necessary at all'
          Rails.logger.warn 'might want to actually stub timenow for more reliable data'
          expect_valid_monthly_top_artists(this_month_result)
        end
      end

      it 'calls the api if data is the data has not been updated since the month end' do
        Rails.logger.warn 'assert that api is actually called? or maybe not necessary at all'
        VCR.use_cassette 'lastfm_user_getrecenttracks_stale' do
          expect_valid_monthly_top_artists(stale_result)
        end
      end

      it 'calls the api if there is no data for the month' do
        skip
      end
    end

    it 'can be overridden to refresh with api data' do
      skip 'Not Implemented'
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

        it 'returns an Array' do
          expect(result).to be_a(Array)
        end

        it 'returns an ordered list of artist data' do
          result.each do |artist_data|
            expect(artist_data[:name]).to be_a(String)
            expect(artist_data[:play_count]).to be_a(Fixnum)
          end
        end
      end
    end
  end
end
