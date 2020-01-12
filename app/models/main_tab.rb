class MainTab < ApplicationRecord
  extend FriendlyId
  include Requestable
  friendly_id :name, use: :slugged
  has_many :sub_tabs, dependent: :destroy

  has_rich_text :body
  has_one_attached :image

  validates :title, :presence => true
  validates :body, :presence => true
  validates :image, :presence => true

  def index
    @main_tabs = MainTab.all
  end

  def show
    @main_tab = MainTab.find(params[:id])
  end

end