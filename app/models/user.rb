class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, length: { maximum: 150 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :age, numericality: { greater_than_or_equal_to: 0 }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validate :password_complexity, if: -> { password.present? }

  attr_accessor :current_password

  before_validation { email.downcase! }
  before_create :set_default_date_joined

  has_many :tasks, dependent: :destroy

  private

  def set_default_date_joined
    self.date_joined ||= Time.current
  end

  def password_complexity
    # Password cannot contain only numbers
    if password.match?(/\A\d+\z/)
      errors.add(:password, "cannot contain only numbers")
    end
  end
end
