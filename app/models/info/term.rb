class Info::Term < Info::Base
  validates :header, presence: true
end

# == Schema Information
#
# Table name: info_terms
#
#  id          :integer          not null, primary key
#  header      :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
