class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.string :action

      t.timestamps
    end
  end
end
