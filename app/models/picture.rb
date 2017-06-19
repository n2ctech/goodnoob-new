class Picture < ActiveRecord::Base
  include Recentable

  belongs_to :imageable, polymorphic: true

  has_attached_file :image,
                    processors: [:thumbnail, :paperclip_optimizer],
                    styles: { subcatcover: '1500x844#',
                              thumbnail: '250x190>',
                              medium: '470x300#',
                              avatar: '165x165#' }

  validates_attachment :image,
                       presence: true,
                       content_type: { content_type: /\Aimage\/.*\Z/ }

  delegate :url, to: :image
end

# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  imageable_id       :integer
#  imageable_type     :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#
