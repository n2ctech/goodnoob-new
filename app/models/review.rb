class Review < ActiveRecord::Base
  include Recentable

  belongs_to :language
  belongs_to :user
  belongs_to :product
  has_one :rating, dependent: :destroy, inverse_of: :review
  accepts_nested_attributes_for :rating

  validates :title, :review, :language, :user, :product, presence: true
  validates_associated :rating
  validates_presence_of :rating
  validates :product_id, uniqueness: { scope: :user_id }

  delegate :name, to: :user, prefix: true # .user_name method

  def date_string
    created_at.to_date.to_s(:long)
  end
end

# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  title       :string
#  review      :text
#  language_id :integer
#  user_id     :integer
#  product_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
