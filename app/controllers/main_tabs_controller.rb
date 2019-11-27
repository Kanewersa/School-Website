class MainTabsController < ApplicationController
  layout 'dashboard'

  def index
    @main_tabs = MainTab.all
  end

  def new

  end

  def show
    @main_tab = MainTab.friendly.find(params[:id])
  end

  def sub_tabs
    SubTab.where(main_tab: this)
  end

end
