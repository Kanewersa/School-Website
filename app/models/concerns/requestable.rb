module Requestable
  extend ActiveSupport::Concern

  included do
    has_many :requests, :as => :requestable
  end

  enum status: { unapproved: 0, approved: 1, to_edit: 2 }
end