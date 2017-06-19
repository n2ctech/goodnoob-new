class Price < ActiveRecord::Base
  belongs_to :currency
  belongs_to :product

  validates :currency_id, uniqueness: { scope: :product_id }

  def title
    options = {}
    options.merge! unit: currency.sign if currency && currency.sign.present?
    amount.to_i.to_s :currency, options
  end
end

# == Schema Information
#
# Table name: prices
#
#  id          :integer          not null, primary key
#  amount      :float
#  currency_id :integer
#  product_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
