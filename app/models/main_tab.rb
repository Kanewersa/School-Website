class MainTab < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :sub_tabs, dependent: :destroy

  def index
    @main_tabs = MainTab.all
  end

  def show
    @main_tab = MainTab.find(params[:id])
  end


end