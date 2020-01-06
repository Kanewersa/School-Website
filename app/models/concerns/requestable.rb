module Requestable
  extend ActiveSupport::Concern

  included do
    has_many :requests, :as => :requestable
    has_many_attached :gallery_images
  end
  
end