class Company < ActiveRecord::Base
  translates :description

  has_many :products
  has_many :pos, class_name: 'POS'
  has_many :distributors, through: :pos

  has_one :address, as: :addressable

  has_many :sub_categories, -> { uniq }, through: :products
  has_many :categories, through: :sub_categories

  has_many :user_favourites, as: :favouriteable
  has_many :users, through: :user_favourites
  has_and_belongs_to_many :countries

  accepts_nested_attributes_for :address


  def self.local(country_code)
    country_code ? joins(:address).where(addresses: { country_code: country_code }).uniq : none
  end

  def self.international(country_code)
    where(id:(all - local(country_code)).map(&:id))
  end

  def self.with_sub_categories(sub_categories_ids)
    sub_categories_ids ||= []
    if sub_categories_ids.any?
      joins(:products).where(products: { sub_category_id: sub_categories_ids.map(&:to_i) }).uniq
    else
      all
    end
  end

  def self.search(query)
    return [] if query.blank?
    where('lower(companies.name) LIKE lower(:search)', search: "%#{query}%")
  end

end

# == Schema Information
#
# Table name: companies
#
#  id             :integer          not null, primary key
#  name           :string
#  url            :string
#  description_en :text
#  email          :string
#  phone          :string
#  fax            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  description_fr :text
#  description_es :text
#
