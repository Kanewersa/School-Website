class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def compress_images
    # If model responds to the attached image
    if self.respond_to?(:image) and self.image.attached?
      # and image was not yet compressed
      unless self.image.blob.filename.base.start_with?("lite_")
        # open the blob, compress image and attach it to the model
        self.image.blob.open do |file|
          result = ImageProcessing::Vips.source(file).resize_to_limit!(4096, nil)
          self.image.purge_later
          self.image.attach(io: result, filename: "lite_" + File.basename(result), content_type: "application/image")
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
            puts "OPENING FILE! :D"
            images << ImageProcessing::Vips.source(file).resize_to_limit!(4096, nil)
          end
        end
      end
      # purge old images
      puts "Purging old gallery images..."
      self.gallery_images.purge_later
      # attach new images
      puts "COUNT IS:"
      puts images.count
      images.each do |img|
        puts "Attaching image " + img.to_s
        self.gallery_images.attach(io: img, filename: "lite_" + File.basename(img), content_type: "application/image")
      end
    end
  end
end
