class SubTabsController < RequestablesController
  layout 'application'
  respond_to :js, :html

  def index
    @sub_tabs = SubTab.all
  end

  def new
    @sub_tab = SubTab.new
  end

  def create
    if params[:commit] == 'Podgląd'
      @main_tabs = MainTab.all
      @categories = Category.all
      @sub_tab = SubTab.new(sub_tab_params)
      preview('preview', @sub_tab)
      nil
    else
      main_tab = MainTab.find(sub_tab_params[:main_tab_id])
      sub_tab_params[:main_tab] = main_tab
      @sub_tab = SubTab.new(sub_tab_params)

      if current_user.has_role?(:admin)
        @sub_tab.status = 1
        @sub_tab.save
      else
        @sub_tab.save
        @request = Request.new(status: 1, user_id: current_user.id, action: "create",
                               requestable_type: "SubTab", requestable_id: @sub_tab.id)
        @request.save
      end
      @sub_tab.sort = SubTab.count + 1
      @sub_tab.save
      ajax_redirect_to(tabs_path)
    end
  end

  def edit
    @sub_tab = SubTab.friendly.find(params[:id])
    render :layout => 'dashboard'
  end

  def update
    if params[:commit] == 'Podgląd'
      @main_tabs = MainTab.all
      @categories = Category.all
      @sub_tab = SubTab.new(sub_tab_params)
      @sub_tab.main_tab_id = SubTab.friendly.find(params[:id]).main_tab_id
      preview('preview', @sub_tab)
      nil
    else
      @sub_tab = SubTab.friendly.find(params[:id])
      if current_user.has_role?(:admin)
        @sub_tab.update(:title => params[:sub_tab][:title],
                        :slug => params[:sub_tab][:slug],
                        :body => params[:sub_tab][:body],
                        :updated_at => Time.now)
      else
        @new_sub_tab = SubTab.new(:title => params[:sub_tab][:title],
                                  :slug => params[:sub_tab][:slug],
                                  :body => params[:sub_tab][:body],
                                  :updated_at => Time.now)
        @new_sub_tab.status = 2
        @new_sub_tab.save
        @request = Request.new(status: 1, user_id: current_user.id, action: "edit/" + @sub_tab.id.to_s,
                               requestable_type: "Event", requestable_id: @new_sub_tab.id)
        @request.save
      end
      ajax_redirect_to(tabs_path)
    end
  end

  def show
    @main_tabs = MainTab.all
    @categories = Category.all
    @sub_tab = SubTab.friendly.find(params[:id])
  end

  def destroy
    @sub_tab = SubTab.find(params[:id])
    if current_user.has_role?(:admin)
      @sub_tab.destroy
    else
      @request = Request.new(status: 1, user_id: current_user.id, action: "destroy",
                             requestable_type: "SubTab", requestable_id: @sub_tab.id)
      @request.save
    end
    redirect_back(fallback_location: tabs_path)
  end

  def to_param
    "#{title}"
  end

  private def sub_tab_params
    params.require(:sub_tab).permit(:title, :slug, :main_tab_id, :body, :main_tab)
  end

end
