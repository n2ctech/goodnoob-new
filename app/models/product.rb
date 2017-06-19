class Product < ActiveRecord::Base
  include Recentable

  translates :description

  belongs_to :company
  belongs_to :sub_category, inverse_of: :products
  has_one :category, through: :sub_category

  has_many :videos
  has_many :photos
  has_many :prices
  has_many :attrs, class_name: "Attribute"
  has_many :ratings
  has_many :reviews
  has_many :dimensions
  has_many :user_favourites, as: :favouriteable
  has_many :users, through: :user_favourites
  has_many :pictures, as: :imageable
  has_many :region_product_urls
  has_many :similars, -> (p) { where.not(id: p) }, through: :sub_category, source: :products
  has_and_belongs_to_many :filter_options

  has_one :actual_price, -> { where(currency_id: Currency.current_currency.id) }, class_name: 'Price' # .actual_price method

  alias_attribute :characteristics, :attrs # .characteristics method

  delegate :name, to: :company, prefix: true # .company_name method
  delegate :name, to: :sub_category, prefix: true # .sub_category_name method
  delegate :count, to: :photos, prefix: true # .photos_count method
  delegate :count, to: :videos, prefix: true # .videos_count method
  delegate :count, to: :similars, prefix: true # .similars_count method
  delegate :distributors, to: :company, allow_nil: true # .distributors method

  accepts_nested_attributes_for :attrs, allow_destroy: true
  accepts_nested_attributes_for :prices, allow_destroy: true
  accepts_nested_attributes_for :dimensions, allow_destroy: true
  accepts_nested_attributes_for :pictures, allow_destroy: true
  accepts_nested_attributes_for :region_product_urls, allow_destroy: true

  scope :filter, ->(filters) { includes(:filter_options)
                                 .where(filter_options: { id: filters }) if filters.present? }

  scope :companies, ->(companies) { where(company_id: companies) if companies.present? }
  scope :year_from, ->(year_from) { where('year >= ?', year_from) if year_from.present? }
  scope :year_to, ->(year_to) { where('year <= ?', year_to) if year_to.present? }
  scope :price_from, ->(price_from) { joins(:actual_price).where('prices.amount >= ?', price_from) if price_from.present? }
  scope :price_to, ->(price_to) { joins(:actual_price).where('prices.amount <= ?', price_to) if price_to.present? }
  scope :sort_by, ->(field, desc) {
    direction = desc.blank? || desc.eql?('true') ? 'DESC' : 'ASC'
    case field
      when 'price'
        joins(:actual_price).order("prices.amount #{direction}")
      when 'year'
        order(year: direction)
      when 'rating'
        hits = self.joins(:ratings)
                 .select('products.id, avg(ratings.value) as average_raiting, count(ratings.id) as number_of_ratings')
                 .group('products.id')
                 .order("average_raiting #{direction}, number_of_ratings #{direction}").map &:id
        order_clause = get_order_clause(hits)
        if order_clause
          order(order_clause)
        else
          order(created_at: direction)
        end
      when 'name'
        order(name: direction)
      else
        order(created_at: direction)
    end
  }

  def self.get_order_clause(hits)
    if hits.present?
      s = "case products.id "
      hits.each_with_index { |n, i| s << "when #{n} then #{i} " }
      s << "else #{hits.size} "
      s << 'end'
    end
  end

  def title
    "#{name} - #{sub_category_name}"
  end

  def date_string
    created_at.to_date.to_s(:rfc822)
  end

  def price_string
    actual_price&.title
  end

  def rating
    [ratings.average(:value).to_i, 5].min
  end

  def picture
    pictures.recent.last || default_picture
  end

  def picture_url *args
    args.clear if picture == default_picture
    picture.url *args
  end

  def self.media
    media = []
    media += Photo.where(product_id: self.ids)
    media += Video.where(product_id: self.ids)
    media += Review.where(product_id: self.ids)
    media
  end

  cattr_reader :default_picture do
    OpenStruct.new url: 'thumb-img-1.png', title: 'No images found'
  end
  default_picture.deep_freeze

  def self.base_search(search, sub_categories, companies)
    prods = all
    if search || sub_categories.is_a?(Array) || companies.is_a?(Array)
      prods = prods.where('lower(products.name) LIKE lower(:search) or lower(products.description_en) LIKE lower(:search)', search: "%#{search}%") if search
      prods = prods.where(sub_category_id: sub_categories) if sub_categories.is_a?(Array)
      prods = prods.where(company_id: companies) if companies.is_a?(Array)
      prods
    end
    prods
  end

  def self.search(search, sub_categories, companies, start_row_index, take_count)
    prods = self.base_search(search, sub_categories, companies).offset(start_row_index).limit(take_count)
  end

  def self.search_count(search, sub_categories, companies)
    prods = self.base_search(search, sub_categories, companies).count
  end
end

# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  name            :string
#  description_en  :text
#  year            :integer
#  sub_category_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer
#  description_fr  :text
#  description_es  :text
#
