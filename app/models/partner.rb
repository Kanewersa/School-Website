class Partner < ApplicationRecord
  include Requestable

  has_one_attached :image

  validates :link, :presence => true

end
