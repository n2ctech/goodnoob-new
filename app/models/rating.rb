class Rating < ActiveRecord::Base

  DEFAULT_VALUE = 5

  belongs_to :product
  belongs_to :user
  belongs_to :review
  belongs_to :review, inverse_of: :rating

  validates :product_id, :user_id, :value, presence: true
  validates :product_id, uniqueness: { scope: :user_id }

  before_validation do
    self.product_id ||= review&.product_id
    self.user_id ||= review&.user_id
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
