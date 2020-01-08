class RemoveBackgroundColorFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :background_color
  end
end
