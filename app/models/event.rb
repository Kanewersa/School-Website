class Event < ApplicationRecord
  after_commit :compress_images
  extend FriendlyId
  include Requestable
  friendly_id :title, use: :slugged

  belongs_to :category
  has_rich_text :body
  has_one_attached :image
  has_many_attached :gallery_images
  has_many :requests, :as => :requestable

  validates :title, :presence => true
  validates :body, :presence => true
  validates :image, :presence => true


  def compress_images
    if @commit
      return true
    end
    @commit = false
    if self.respond_to?(:image)
      if self.image.attached?
        self.image.blob.open do |file|
          result = ImageProcessing::Vips.source(file).resize_to_limit!(4096, nil)
          self.image.purge_later
          @commit = true
          self.image.attach(io: result, filename: File.basename(result), content_type: "application/image")
          @commit = false
        end
      end
    end
    if self.respond_to?(:gallery_images)
      if self.gallery_images.attached?
        images = []
        self.gallery_images.blobs.each do |blob|
          blob.open do |file|
            images << ImageProcessing::Vips.source(file).resize_to_limit!(4096, nil)
          end
        end
        self.gallery_images.purge_later
        images.each do |img|
          @commit = true
          gallery_images.attach(io: img, filename: File.basename(img), content_type: "application/image")
          @commit = false
        end
      end
    end
  end
end