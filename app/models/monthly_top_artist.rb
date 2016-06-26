class MonthlyTopArtist < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist

  include TimeHelpers

  # updated_at month is greater than self's month property
  def final?
    month_in_question = month
    final_second = month_end(month_in_question)
    return false if final_second > updated_at
    !same_month?
  end

  private

  def same_month?
    if month.year == updated_at.year && month.month == updated_at.month
      logger.warn "Current month- maybe deal with this more selectively some day"
      return true
    end
    false
  end

end
