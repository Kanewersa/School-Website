class RemoveBodyFromSubTabs < ActiveRecord::Migration[6.0]
  def change

    remove_column :sub_tabs, :body, :string
  end
end
