class Gallery < ApplicationRecord
  # NOTE: Images get deleted on gallery destroy
  has_many_attached :images

  def show
    @images = self.images
  end
end
