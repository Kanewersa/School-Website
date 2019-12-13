class Request < ApplicationRecord
  belongs_to :user, :dependent => :destroy
  belongs_to :requestable, :polymorphic => true, :dependent => :destroy

  enum status: { canceled: 0, pending: 1, approved: 2, rejected: 3 }
end
