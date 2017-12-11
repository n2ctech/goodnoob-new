class TailShape < ActiveRecord::Base
  has_many :surfboard_detail_params

  def to_s
    name
  end
end

# == Schema Information
#
# Table name: tail_shapes
#
#  id    :integer          not null, primary key
#  name  :string
#  price :decimal(10, 2)
#
