class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  geocoded_by :full_address do |address, result|
    if result && result.first
    address.country_code = result.first.country_code
    address.latitude = result.first.latitude
    address.longitude = result.first.longitude
    end
  end
  after_validation :geocode

  def full_address
    "#{street}, #{city}"
  end

end

# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  street           :string
#  postcode         :string
#  city             :string
#  country          :string
#  latitude         :float
#  longitude        :float
#  addressable_id   :integer
#  addressable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  country_code     :string
#
