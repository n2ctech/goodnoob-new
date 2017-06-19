class Region < ActiveRecord::Base
  has_many :countries
  has_many :region_product_urls
end

# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
