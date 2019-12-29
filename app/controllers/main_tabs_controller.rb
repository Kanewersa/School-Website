class MainTabsController < RequestablesController
  layout 'dashboard'

  def index
    @main_tabs = MainTab.all
  end

  def new

  end

  def edit
    @main_tab = MainTab.friendly.find(params[:id])
  end

  def update
    if params[:commit] == 'Podgląd'
      @main_tab = MainTab.new(main_tab_params)
      if main_tab_params[:image] == nil
        @main_tab.image.attach(MainTab.friendly.find(params[:id]).image.blob)
      end
      preview('preview', @main_tab)
      nil
    else
      @main_tab = MainTab.friendly.find(params[:id])
      @main_tab.update(:title => params[:main_tab][:title],
                       :slug => params[:main_tab][:slug],
                       :body => params[:main_tab][:body],
                       :updated_at => Time.now)
      unless params[:main_tab][:image].nil?
        @main_tab.update(:image => params[:main_tab][:image])
      end
      @main_tab.save
      ajax_redirect_to(tabs_path)
    end
  end

  def show
    @main_tabs = MainTab.all
    @categories = Category.all
    @main_tab = MainTab.friendly.find(params[:id])
    render layout: 'application'
  end

  def sub_tabs
    SubTab.where(main_tab: this)
  end

  private def main_tab_params
    params.require(:main_tab).permit(:title, :slug, :body, :image)
  end
end
