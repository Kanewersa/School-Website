class AddStatusToSubTabs < ActiveRecord::Migration[6.0]
  def change
    add_column :sub_tabs, :status, :integer
  end
end
