FactoryGirl.define do
  factory :guide do
    header { Faker::Lorem.words(2).split '' }
    description Faker::Lorem.paragraph
    video_url { Faker::Internet.url('youtube.com') }
  end

end

# == Schema Information
#
# Table name: guides
#
#  id          :integer          not null, primary key
#  header      :string
#  description :text
#  video_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
