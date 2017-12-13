class SizeHeight < ActiveRecord::Base
  has_many :surfboard_detail_params

  def to_s
    height
  end
end

# == Schema Information
#
# Table name: size_heights
#
#  id     :integer          not null, primary key
#  height :string
#
