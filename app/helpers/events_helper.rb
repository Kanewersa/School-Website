module EventsHelper

  def event_image_url
    url_for(@event.image)
  end

  def gallery_images_urls
    urls = []
    @event.gallery_images.each do |image|
      urls.push(url_for(image))
    end
    urls
  end
end
