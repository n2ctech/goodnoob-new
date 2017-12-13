class SurfboardDetail < ActiveRecord::Base
  belongs_to :product

  has_many :surfboard_detail_params

  accepts_nested_attributes_for :surfboard_detail_params, allow_destroy: true
end

# == Schema Information
#
# Table name: surfboard_details
#
#  id                    :integer          not null, primary key
#  product_id            :integer
#  perfect_for           :string
#  perfecto_para         :string
#  parfait_pour          :string
#  manufacturing_time_en :string
#  manufacturing_time_es :string
#  manufacturing_time_fr :string
#  rocker_en             :string
#  rocker_es             :string
#  rocker_fr             :string
#  rails_en              :string
#  rails_es              :string
#  rails_fr              :string
#  concave_en            :string
#  concave_es            :string
#  concave_fr            :string
#  wave_size_en          :string
#  wave_size_es          :string
#  wave_size_fr          :string
#
