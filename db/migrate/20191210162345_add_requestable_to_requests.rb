class AddRequestableToRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :requests, :requestable, polymorphic: true, index: true
  end
end
