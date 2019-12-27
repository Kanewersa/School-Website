class MainTabsController < ApplicationController
  layout 'dashboard'

  def index
    @main_tabs = MainTab.all
  end

  def new

  end

  def edit
    @main_tab = MainTab.friendly.find(params[:id])
      #abort @main_tab.image.inspect
  end

  def update
    @main_tab = MainTab.friendly.find(params[:id])
    @main_tab.update(:title => params[:main_tab][:title],
                    :slug => params[:main_tab][:slug],
                    :body => params[:main_tab][:body],
                    :updated_at => Time.now)
    unless params[:main_tab][:image].nil?
      @main_tab.update(:image => params[:main_tab][:image])
    end
    @main_tab.save
    redirect_to tabs_path
  end

  def show
    @main_tab = MainTab.friendly.find(params[:id])
  end

  def sub_tabs
    SubTab.where(main_tab: this)
  end

  private def main_tab_params
    params.require(:main_tab).permit(:title, :slug, :body, :image)
  end
end
