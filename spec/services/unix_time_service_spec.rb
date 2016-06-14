require 'rails_helper'
RSpec.describe TimeHelpers do
  include TimeHelpers
  # describe "#unix_time (private method)" do
  #   it "returns the returns an integer in unix time" do
  #     result = TimeService.send(:to_unix_time,DateTime.new(1970,1,1))
  #     expect(result).to equal 0
  #   end
  # end
  describe '#unix_month' do
    it 'accepts named year and month parameters' do
      expect(unix_month(year: 1970, month: 1)).to be_a Hash
    end
    # it 'accepts a date_time parameter' do
    #   skip 'no it doesnt- not implementing this for now'
    # end
    #
    it 'returns the start and end of the month in unix seconds' do
      result = unix_month(month:1, year: 1970)
      expect(result[1]).to eq 0
      expect(result[-1]).to eq 2_678_399
    end

  end

end
