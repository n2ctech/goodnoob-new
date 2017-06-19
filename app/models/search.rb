class Search < ActiveRecord::Base
  belongs_to :user
  has_many :products

  scope :recent, -> {
    order( 'created_at DESC').take(10)
  }

end

# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
