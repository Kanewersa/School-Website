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
    # If model responds to the attached image
    if self.respond_to?(:image) and self.image.attached?
      # and image was not yet compressed
      unless self.image.blob.filename.base.start_with?("lite_")
        # open the blob, compress image and attach it to the model
        self.image.blob.open do |file|
          result = ImageProcessing::Vips.source(file).resize_to_limit!(4096, nil)
          self.image.purge_later
          @commit = true
          self.image.attach(io: result, filename: "lite_" + File.basename(result), content_type: "application/image")
          @commit = false
        end
      end

    end
    # If model responds to the attached gallery
    if self.respond_to?(:gallery_images) and self.gallery_images.attached?
      images = []
      # For each image in the gallery
      self.gallery_images.blobs.each do |blob|
        # compress the image if it was not yet compressed
        unless blob.filename.base.start_with?("lite_")
          blob.open do |file|
            images << ImageProcessing::Vips.source(file).resize_to_limit!(4096, nil)
          end
        end
      end
      # purge old images
      self.gallery_images.purge_later
      # attach new images
      images.each do |img|
        @commit = true
        gallery_images.attach(io: img, filename: File.basename(img), content_type: "application/image")
        @commit = false
      end
    end
  end
end