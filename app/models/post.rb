# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  title              :string
#  content            :text
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Post < ApplicationRecord
  include Writable

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_attached_file :image, styles: { medium: "1600x900>", thumb: "600x400>" }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :title, :user, :image, presence: true

  before_save :generate_slug

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
