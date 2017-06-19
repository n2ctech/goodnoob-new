FactoryGirl.define do
  factory :user_favourite do
    user nil
favourite ""
favourite ""
favourite ""
favourite ""
favourite ""
favourite ""
favourite ""
favourite ""
favourite ""
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
