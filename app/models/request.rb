class Request < ApplicationRecord
  belongs_to :user
  belongs_to :requestable, :polymorphic => true

  enum status: { canceled: 0, pending: 1, approved: 2, rejected: 3 }
end
