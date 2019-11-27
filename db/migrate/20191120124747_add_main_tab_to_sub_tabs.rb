class AddMainTabToSubTabs < ActiveRecord::Migration[6.0]
  def change
    add_reference :sub_tabs, :main_tab, null: false, foreign_key: true
  end
end
