class AddStatusToPartner < ActiveRecord::Migration[6.0]
  def change
    add_column :partners, :status, :int
  end
end
