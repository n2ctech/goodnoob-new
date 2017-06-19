class Info::Privacy < Info::Base
  validates :header, presence: true
end

# == Schema Information
#
# Table name: info_privacies
#
#  id          :integer          not null, primary key
#  header      :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
