class FinSystem < ActiveRecord::Base
  has_many :surfboard_detail_params

  def to_s
    name
  end
end

# == Schema Information
#
# Table name: fin_systems
#
#  id    :integer          not null, primary key
#  name  :string
#  price :decimal(10, 2)
#
