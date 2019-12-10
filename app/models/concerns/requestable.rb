module Requestable
  extend ActiveSupport::Concern

  included do
    has_many :requests, :as => :requestable
  end
end