class AddCategoryToEvent < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :category, null: false, foreign_key: true
  end
end
