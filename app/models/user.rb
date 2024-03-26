class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, presence: true
  validate :date_of_birth_format

  has_many :articles, dependent: :nullify
  has_many :comments, dependent: :nullify

  private

  def date_of_birth_format
    Date.parse(date_of_birth.to_s)
  rescue ArgumentError
    errors.add(:date_of_birth, "is not a valid date")
  end
end
