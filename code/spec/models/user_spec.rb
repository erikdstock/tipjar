require 'rails_helper'
include TimeTools

describe User, type: :model do
  before(:all) { travel_to Time.new(2016, 6, 2).utc }
  after(:all) { travel_to Time.now.utc }

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
      create(:monthly_top_artist, user: user, month: 1.month.ago, play_count: 10)
      user.top_artists_for_month(1.month.ago)
    end

    context 'finalized structure for good data' do
      it 'returns an AR Relation' do
        expect_valid_monthly_top_artists(finalized_result)
        expect(finalized_result.length).to be 1
        expect(finalized_result.first.play_count).to be 10
      end

      it 'contains monthly_top_artists data plus artist name and image attrs' do
        result = finalized_result.first
        expect { result.play_count && result.artist.name && result.artist.image }.not_to raise_error
      end
    end
  end
end
