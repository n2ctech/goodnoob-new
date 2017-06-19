class AddImageToGuides < ActiveRecord::Migration

  def up
    add_attachment    :guides, :image
  end

  def down
    remove_attachment :guides, :image
  end

end
