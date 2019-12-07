class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.boolean :important
      t.boolean :announcement

      t.timestamps
    end
  end
end
