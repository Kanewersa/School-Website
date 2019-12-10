class Event < ApplicationRecord
  extend FriendlyId
  include Requestable
  friendly_id :title, use: :slugged

  belongs_to :category
  has_rich_text :body
  has_one_attached :image
  has_one :gallery
end
