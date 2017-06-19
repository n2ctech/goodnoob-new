class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name
end

# == Schema Information
#
# Table name: companies
#
#  id          :integer          not null, primary key
#  name        :string
#  url         :string
#  description :text
#  email       :string
#  phone       :string
#  fax         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
