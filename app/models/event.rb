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
end