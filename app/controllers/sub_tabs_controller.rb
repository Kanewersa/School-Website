class SubTabsController < ApplicationController
  layout 'application'

  def index
    @sub_tabs = SubTab.all
  end

  def new
    @sub_tab = SubTab.new
  end

  def create
    main_tab = MainTab.find(sub_tab_params[:main_tab_id])
    sub_tab_params[:main_tab] = main_tab 
    @sub_tab = SubTab.new(sub_tab_params)

    if @sub_tab.save
      redirect_back(fallback_location: sub_tabs_path)
    else
      redirect_back(fallback_location: sub_tabs_path)
    end
  end

  def show
    @main_tabs = MainTab.all
    @sub_tab = SubTab.friendly.find(params[:id])
  end

  def destroy
    @sub_tab = SubTab.find(params[:id])
    @sub_tab.destroy
    redirect_back(fallback_location: sub_tabs_path)
  end

  def to_param
    "#{title}"
  end

  private def sub_tab_params
    params.require(:sub_tab).permit(:title, :slug, :main_tab_id, :body, :main_tab)
  end

end
