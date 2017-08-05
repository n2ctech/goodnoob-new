class GuideImage < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end

# == Schema Information
#
# Table name: guide_images
#
#  id         :integer          not null, primary key
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
