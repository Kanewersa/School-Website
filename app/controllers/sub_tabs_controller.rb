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
    # Validate requestables params
    unless validates?(sub_tab_params, SubTab)
      return
    end
    if params[:commit] == 'Podgląd'
      preview
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
      respond_to do |format|
        format.js { render 'validation-success'}
      end
    end
  end

  def edit
    @sub_tab = SubTab.friendly.find(params[:id])
    render :layout => 'dashboard'
  end

  def update
    # Validate requestables params
    unless validates?(sub_tab_params, SubTab)
      return
    end
    if params[:commit] == 'Podgląd'
      preview
      nil
    else
      @sub_tab = SubTab.friendly.find(params[:id])
      # If user is an admin
      if current_user.has_role?(:admin)
        # Update tab's attributes
        @sub_tab.update(:title => params[:sub_tab][:title],
                        :slug => params[:sub_tab][:slug],
                        :body => params[:sub_tab][:body],
                        :updated_at => Time.now)
        # Get new blob id's from params
        blobs = get_blobs_from_ids(params[:sub_tab][:cache][0])
        # Purge old images and replace them with new ones
        @sub_tab.gallery_images.purge_later
        @sub_tab.gallery_images.attach(blobs)
        # Get new images from params
        new_images = params[:sub_tab][:gallery_images]
        # If new images were added add them to the tab
        unless new_images.nil?
          @sub_tab.gallery_images.attach(new_images)
        end
      #If user is not an admin
      else
        #Create new tab with given attributes
        @new_sub_tab = SubTab.new(:title => params[:sub_tab][:title],
                                  :slug => params[:sub_tab][:slug],
                                  :body => params[:sub_tab][:body],
                                  :updated_at => Time.now)
        #Use the same main tab as old tab
        @new_sub_tab.main_tab = @sub_tab.main_tab
        # Get new blob id's from params
        blobs = get_blobs_from_ids(params[:sub_tab][:cache][0])
        # Attach blobs to the new tab
        @new_sub_tab.gallery_images.attach(blobs)
        # Get new images from params
        new_images = params[:sub_tab][:gallery_images]
        # If new images were added add them to the tab
        unless new_images.nil?
          @new_sub_tab.gallery_images.attach(new_images)
        end
        #Change tabs status to unapproved
        @new_sub_tab.status = 2
        @new_sub_tab.save
        #Add new request for the admin
        @request = Request.new(status: 1, user_id: current_user.id, action: "edit/" + @sub_tab.id.to_s,
                               requestable_type: "SubTab", requestable_id: @new_sub_tab.id)
        @request.save
      end
      respond_to do |format|
        format.js { render 'validation-success'}
      end
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

  def preview
    @requestable = SubTab.new(sub_tab_params)
    if @requestable.main_tab_id.nil?
      @requestable.main_tab_id = SubTab.friendly.find(params[:id]).main_tab_id
    end
    super
  end

  def to_param
    "#{title}"
  end

  private def sub_tab_params
    params.require(:sub_tab).permit(:title, :slug, :main_tab_id, :body, :main_tab, :gallery_images => [])
  end

end
