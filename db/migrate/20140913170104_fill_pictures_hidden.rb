class FillPicturesHidden < ActiveRecord::Migration
  def up
    Picture.update_all hidden: false
  end

  def down
    Picture.update_all hidden: nil
  end
end
