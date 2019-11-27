class AddSlugToMainTabs < ActiveRecord::Migration[6.0]
  def change
    add_column :main_tabs, :slug, :string
    add_index :main_tabs, :slug, unique: true
  end
end
