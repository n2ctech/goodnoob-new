class Rating < ActiveRecord::Base

  DEFAULT_VALUE = 5

  belongs_to :product
  belongs_to :user
  belongs_to :review
  belongs_to :review, inverse_of: :rating

  validates :review, :value, presence: true

  before_save :set_product
  before_save :set_user
  after_save :update_average

  def set_product
    self.product_id = review.product.id
  end

  def set_user
    self.user_id = review.user.id
  end

  def update_average

  end
end

# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer
#  user_id    :integer
#  review_id  :integer
#
