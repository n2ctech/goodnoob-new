class GuidesAddSubcategoryId < ActiveRecord::Migration
  def change
    add_reference :guides, :sub_category, index: true
  end
end
