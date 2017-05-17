# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  title      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  include Writable

  belongs_to :post
  belongs_to :user

  validates :title, :user, :post, presence: true
  validate :cannot_write_too_many_comments

  DELAY = 30

  private

  def cannot_write_too_many_comments
    if user.comments.any? && Time.now.to_f - user.comments.last.created_at.to_f < Comment::DELAY
      errors.add(:vous, "devez attendre #{Comment::DELAY - (Time.now.to_f - user.comments.last.created_at.to_f)} secondes avant de poster à nouveau.")
    end
  end
end
