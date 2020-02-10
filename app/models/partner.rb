class Partner < ApplicationRecord
  after_commit :compress_images
  include Requestable

  has_one_attached :image

  validates :link, :presence => true

end
