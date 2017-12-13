class Volume < ActiveRecord::Base
  has_many :surfboard_detail_params

  def to_s
    volume
  end
end

# == Schema Information
#
# Table name: volumes
#
#  id     :integer          not null, primary key
#  volume :string
#
