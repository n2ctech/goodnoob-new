class RegionProductUrl < ActiveRecord::Base
  belongs_to :region, required: true
  belongs_to :product, required: true

  validates :url, presence: true
  validates :region_id, uniqueness: { scope: :product_id }
end

# == Schema Information
#
# Table name: region_product_urls
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  product_id :integer
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_region_product_urls_on_product_id                (product_id)
#  index_region_product_urls_on_product_id_and_region_id  (product_id,region_id) UNIQUE
#  index_region_product_urls_on_region_id                 (region_id)
#
# Foreign Keys
#
#  fk_rails_3f48dc2509  (product_id => products.id)
#  fk_rails_f8262e46c0  (region_id => regions.id)
#
