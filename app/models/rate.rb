class Rate < ApplicationRecord
  validates :price, :force_price, presence: true
  validate :force_date_time_cannot_be_in_the_past

  def force_date_time_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if force_date_time.present? && force_date_time < Time.current
  end

  def current_price
    if Time.current > force_date_time
      price
    else
      force_price
    end
  end
end
