class Thickness < ActiveRecord::Base
  has_many :surfboard_detail_params

  def to_s
    thickness
  end
end

# == Schema Information
#
# Table name: thicknesses
#
#  id        :integer          not null, primary key
#  thickness :string
#
