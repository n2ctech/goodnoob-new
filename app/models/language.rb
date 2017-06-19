class Language < ActiveRecord::Base
  translates :name

  has_many :users
  has_many :reviews
  has_many :countries
end

# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name_en    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name_fr    :string
#  name_es    :string
#
