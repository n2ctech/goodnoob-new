class AddImageToCategories < ActiveRecord::Migration

  def up
    add_attachment    :categories, :image
  end

  def down
    remove_attachment :categories, :image
  end

end
