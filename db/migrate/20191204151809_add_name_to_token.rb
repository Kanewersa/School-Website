class AddNameToToken < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :name, :string
  end
end
