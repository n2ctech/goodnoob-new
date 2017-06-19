class Info::Question < Info::Base
  translates :header, :description

  validates :header, presence: true
end

# == Schema Information
#
# Table name: info_questions
#
#  id             :integer          not null, primary key
#  header_en      :string
#  description_en :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  header_fr      :string
#  header_es      :string
#  description_fr :text
#  description_es :text
#
