class CreateMainTabs < ActiveRecord::Migration[6.0]
  def change
    create_table :main_tabs do |t|
      t.string :title

      t.timestamps
    end
  end
end
