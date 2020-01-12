class MainTabsController < RequestablesController
  layout 'application'

  def index
    @main_tabs = MainTab.all
  end

  def edit
    @main_tab = MainTab.friendly.find(params[:id])
    render layout: 'dashboard'
  end

  def update
    @main_tab = MainTab.friendly.find(params[:id])
    parameters = main_tab_params
    puts "PUT!"
    if parameters[:image].nil?
      if @main_tab.image.attached?
        parameters[:image] = @main_tab.image.blob
      end
    end
    # Validate requestables params
    unless validates?(parameters, MainTab)
      return
    end
    if params[:commit] == 'Podgląd'
      @main_tab = MainTab.new(main_tab_params)
      if main_tab_params[:image] == nil
        @main_tab.image.attach(MainTab.friendly.find(params[:id]).image.blob)
      end
      preview('preview', @main_tab)
      nil
    else
      @main_tab = MainTab.friendly.find(params[:id])
      if current_user.has_role?(:admin)
        # Update tab's attributes
        @main_tab.update(:title => params[:main_tab][:title],
                         :slug => params[:main_tab][:slug],
                         :body => params[:main_tab][:body],
                         :updated_at => Time.now)
        # If new image was uploaded update it
        if params[:main_tab][:image]
          @main_tab.update(:image => params[:main_tab][:image])
        end
        # Get new blob id's from params
        blobs = get_blobs_from_ids(params[:main_tab][:cache][0])
        # Purge old images and replace them with new ones
        @main_tab.gallery_images.purge_later
        @main_tab.gallery_images.attach(blobs)
        # Get new images from params
        new_images = params[:main_tab][:gallery_images]
        # If new images were added add them to the tab
        unless new_images.nil?
          @main_tab.gallery_images.attach(new_images)
        end
      # If user is not an admin
      else
        # Create new main tab with given params
        @new_main_tab =  MainTab.new(:title => params[:main_tab][:title],
                                     :slug => params[:main_tab][:slug],
                                     :body => params[:main_tab][:body],
                                     :image => params[:main_tab][:image],
                                     :updated_at => Time.now)
        # Get new blob id's from params
        blobs = get_blobs_from_ids(params[:sub_tab][:cache][0])
        # Attach blobs to the new tab
        @new_main_tab.gallery_images.attach(blobs)
        # Get new images from params
        new_images = params[:sub_tab][:gallery_images]
        # If new images were added add them to the tab
        unless new_images.nil?
          @new_main_tab.gallery_images.attach(new_images)
        end
        #Change tabs status to unapproved
        @new_main_tab.status = 2
        @new_main_tab.save
        #Add new request for the admin
        @request = Request.new(status: 1, user_id: current_user.id, action: "edit/" + @main_tab.id.to_s,
                               requestable_type: "MainTab", requestable_id: @new_main_tab.id)
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
    @main_tab = MainTab.friendly.find(params[:id])
  end

  def sub_tabs
    SubTab.where(main_tab: this)
  end

  private def main_tab_params
    params.require(:main_tab).permit(:title, :slug, :body, :image, :gallery_images => [])
  end
end
