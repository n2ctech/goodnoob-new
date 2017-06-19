class UserFavourite < ActiveRecord::Base

  belongs_to :user
  belongs_to :favouriteable, polymorphic: true

  validates :user, presence: true

  scope :categories, -> { where( favouriteable_type: 'Category' ) }
  scope :companies, -> { where( favouriteable_type: 'Company' ) }
  scope :products, -> { where( favouriteable_type: 'Product' ) }
  scope :user_products, -> (id) { where( favouriteable_type: 'Product', user_id: id) }
  scope :photos, -> { where( favouriteable_type: 'Photo' ) }
  scope :videos, -> { where( favouriteable_type: 'Video' ) }

  def self.get_favourites(user:, element:)
    where(user_id: user.id, favouriteable: element)
  end

  def self.in_favourites?(user:, element:)
    get_favourites(user:user, element:element).any?
  end

  def self.add_to_favourites(user:, element:)
    return if in_favourites?(user:user, element:element)
    create user_id: user.id, favouriteable: element
  end

  def self.remove_from_favourites(user:, element:)
    get_favourites(user:user, element:element).destroy_all if in_favourites?(user:user, element:element)
  end

end

# == Schema Information
#
# Table name: user_favourites
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  favouriteable_id   :integer
#  favouriteable_type :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  favouriteable_polymorphic_index   (favouriteable_type,favouriteable_id)
#  index_user_favourites_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_3b7ddd5886  (user_id => users.id)
#
