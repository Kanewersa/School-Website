class AddSortToSubTabs < ActiveRecord::Migration[6.0]
  def change
    add_column :sub_tabs, :sort, :integer
  end
end
