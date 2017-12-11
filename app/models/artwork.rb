class Artwork < ActiveRecord::Base
  has_many :surfboard_detail_params

  has_one :picture, as: :imageable

  accepts_nested_attributes_for :picture, allow_destroy: true

  def to_s
    id
  end
end

# == Schema Information
#
# Table name: artworks
#
#  id    :integer          not null, primary key
#  price :decimal(10, 2)
#
