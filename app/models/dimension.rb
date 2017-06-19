class Dimension < ActiveRecord::Base
  belongs_to :product
end

# == Schema Information
#
# Table name: dimensions
#
#  id         :integer          not null, primary key
#  text       :string
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
