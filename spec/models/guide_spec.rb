require 'rails_helper'

RSpec.describe Guide, type: :model do
  subject { build(:guide, sub_category: create(:sub_category)) }

  it 'is valid' do
    expect(subject).to be_valid
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
