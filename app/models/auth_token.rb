class AuthToken < ApplicationRecord
  belongs_to :user

  validates :value, uniqueness: true

  before_save :set_expiration_date, on: :create

  before_save :set_value, on: :create

  def set_value
    self.value = SecureRandom.uuid
  end

  def set_expiration_date
    self.expired_at = DateTime.now + 2.weeks
  end
end
