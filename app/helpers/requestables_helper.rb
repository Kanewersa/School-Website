module RequestablesHelper
  def main_image_url(requestable)
    if requestable.image
      url_for(requestable.image)
    elsif requestable.main_tab
      url_for(requestable.main_tab.image)
    end
  end

  def gallery_images_urls(requestable)
    urls = []
    requestable.gallery_images.each do |image|
      urls.push(url_for(image))
    end
    urls
  end

  def gallery_images_signed_ids(requestable)
    ids = []
    requestable.gallery_images.blobs.each do |blob|
      ids.push(blob.signed_id)
    end
    ids
  end
end
