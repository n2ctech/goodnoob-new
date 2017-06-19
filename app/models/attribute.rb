class Attribute < ActiveRecord::Base
  translates :title, :value

  belongs_to :product
end

# == Schema Information
#
# Table name: attributes
#
#  id         :integer          not null, primary key
#  title_en   :string
#  value_en   :text
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title_fr   :string
#  title_es   :string
#  value_fr   :string
#  value_es   :string
#
