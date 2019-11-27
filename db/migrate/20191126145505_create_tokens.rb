class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :value
      t.string :role
      t.string :used_by
      t.string :created_by

      t.timestamps
    end
  end
end
