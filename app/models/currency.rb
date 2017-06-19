class Currency < ActiveRecord::Base
  cattr_accessor :current_currency

  has_many :users
  has_many :prices
  has_many :countries
end

# == Schema Information
#
# Table name: currencies
#
#  id            :integer          not null, primary key
#  name          :string
#  exchange_rate :float
#  sign          :string
#  code          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
