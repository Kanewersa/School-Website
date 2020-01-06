class Event < ApplicationRecord
  extend FriendlyId
  include Requestable
  friendly_id :title, use: :slugged

  belongs_to :category
  has_rich_text :body
  has_one_attached :image
  has_many :requests, :as => :requestable

  validates :title, :presence => true
  validates :image, :presence => true
  validates :body, :presence => true
end