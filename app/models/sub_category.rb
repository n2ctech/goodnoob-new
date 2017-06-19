class SubCategory < ActiveRecord::Base
  translates :name

  belongs_to :category
  has_many :products, inverse_of: :sub_category
  has_many :filters
  has_many :filter_options, through: :filters
  has_one :picture, as: :imageable
  has_many :companies, through: :products
  has_many :prices, through: :products
  has_many :guides

  accepts_nested_attributes_for :filters, allow_destroy: true
  accepts_nested_attributes_for :picture

  delegate :url, to: :picture, prefix: true, allow_nil: true # .picture_url

  scope :with_guides, -> { where id: Guide.all.map(&:sub_category_id).uniq }
end

# == Schema Information
#
# Table name: sub_categories
#
#  id          :integer          not null, primary key
#  name_en     :string
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name_fr     :string
#  name_es     :string
#
