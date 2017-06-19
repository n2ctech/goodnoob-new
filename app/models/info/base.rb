class Info::Base < ActiveRecord::Base
  self.abstract_class = true

  def self.table_name_prefix
    'info_'
  end
end
