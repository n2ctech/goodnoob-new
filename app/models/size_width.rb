class SizeWidth < ActiveRecord::Base
  has_many :surfboard_detail_params

  def to_s
    width
  end
end

# == Schema Information
#
# Table name: size_widths
#
#  id    :integer          not null, primary key
#  width :string
#
