class MonthlyTopArtist < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist

  # updated_at month is greater than self's month property
  def final?
    month.year >= updated_at.year && month.month < updated_at.month
  end
end
