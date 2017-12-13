class SurfboardDetailParam < ActiveRecord::Base
  belongs_to :surfboard_detail

  belongs_to :size_height
  belongs_to :size_width
  belongs_to :thickness
  belongs_to :volume
  belongs_to :tail_shape
  belongs_to :construction
  belongs_to :fin_system
  belongs_to :artwork
end

# == Schema Information
#
# Table name: surfboard_detail_params
#
#  id                  :integer          not null, primary key
#  surfboard_detail_id :integer
#  size_height_id      :integer
#  size_width_id       :integer
#  thickness_id        :integer
#  volume_id           :integer
#  tail_shape_id       :integer
#  construction_id     :integer
#  fin_system_id       :integer
#  artwork_id          :integer
#
