class CreateSubTabs < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_tabs do |t|
      t.string :title
      t.text :body
      t.references :main_tab, null: false, foreign_key: true
      t.string :slug

      t.timestamps
    end
  end
end
