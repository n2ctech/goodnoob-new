class Category < ActiveRecord::Base
  include Paperclip::Glue

  translates :name

  belongs_to :father_category
  has_many :sub_categories
  has_many :videos
  has_many :photos
  has_many :products, through: :sub_categories
  has_many :companies, through: :products

  has_many :user_favourites, as: :favouriteable
  has_many :users, through: :user_favourites

  delegate :url, to: :image

  scope :with_guides, -> { where id: SubCategory.with_guides.map(&:category_id).uniq }

  has_attached_file :image, default_url: 'surf-bg-test.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  # Searched by subcategories
  def searched_for?(sub_categories_ids)
    sub_categories_ids ||= []
    (sub_categories.ids - sub_categories_ids.map(&:to_i)).count < sub_categories.ids.count
  end

  # Searched by subcategories but not for all
  def searched_not_for_all?(sub_categories_ids)
    searched_for?(sub_categories_ids) && (sub_categories.ids - sub_categories_ids.map(&:to_i)).count > 0
  end

end

# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  name_en            :string
#  father_category_id :integer
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  name_fr            :string
#  name_es            :string
#
