class Photo < ActiveRecord::Base
  include Recentable

  attr_accessor :company_id

  belongs_to :product
  belongs_to :user
  belongs_to :category

  has_many :user_favourites, as: :favouriteable
  has_many :users, through: :user_favourites
  has_one :picture, as: :imageable

  delegate :url, to: :picture, allow_nil: true # .url

  accepts_nested_attributes_for :picture

  after_create :congratulate_user_if_first_photo

  def self.last_photos(except:, limit:)
    all.where.not(id: except.id).order(created_at: :desc).limit(limit)
  end

  def self.add_billet
    new main: false, day: false, picture: Picture.new
  end

  private
  def congratulate_user_if_first_photo
    return unless user.photos.count == 1
    UserMailer.first_photo_upload(user).deliver_later
  end
end

# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  main        :boolean
#  comment     :text
#  day         :boolean
#  product_id  :integer
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
