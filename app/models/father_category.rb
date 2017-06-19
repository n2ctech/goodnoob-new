class FatherCategory < ActiveRecord::Base
  translates :name

  has_many :categories
end

# == Schema Information
#
# Table name: father_categories
#
#  id         :integer          not null, primary key
#  name_en    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name_fr    :string
#  name_es    :string
#
