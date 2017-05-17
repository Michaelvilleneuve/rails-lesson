# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :posts
  has_many :comments

  before_create :hash_password

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/

  SALT = "coucou"

  def can_log_in?(entered_password)
    self.password == Digest::SHA2.hexdigest(User::SALT + entered_password)
  end

  def to_s
    [first_name, last_name].join(' ')
  end

  private

  def hash_password
    self.password = Digest::SHA2.hexdigest(User::SALT + password)
  end
end
