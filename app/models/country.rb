class Country < ActiveRecord::Base
  belongs_to :region, required: true
  belongs_to :currency, required: true
  belongs_to :language, required: true
  has_and_belongs_to_many :companies

  validates :name, :country_code, presence: true
  validates :country_code, uniqueness: { case_sensitive: false }

  before_save { self.country_code.upcase! }
end

# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  name         :string
#  country_code :string
#  region_id    :integer
#  currency_id  :integer
#  language_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_countries_on_currency_id  (currency_id)
#  index_countries_on_language_id  (language_id)
#  index_countries_on_region_id    (region_id)
#
# Foreign Keys
#
#  fk_rails_6f479b409c  (language_id => languages.id)
#  fk_rails_7cac1212c7  (currency_id => currencies.id)
#  fk_rails_b980326c34  (region_id => regions.id)
#
