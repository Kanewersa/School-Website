class EventsController < RequestablesController
  include Rails.application.routes.url_helpers
  layout 'application'
  respond_to :js, :html

  def create
    # Validate requestables params
    unless validates?(event_params, Event)
      return
    end
    # Check if user asked for preview
    if params[:commit] == 'Podgląd'
      preview
      return true
    end

    #Create new event
    @event = Event.new(event_params)
    if @event.announcement
      @event.important = 1
    end
    if current_user.has_role?(:admin)
      @event.status = 1
      @event.save
    else
      @event.save
      @request = Request.new(status: 1, user_id: current_user.id, action: "create",
                             requestable_type: "Event", requestable_id: @event.id)
      @request.save
    end
    respond_to do |format|
      format.js { render 'validation-success' }
    end

  end

  def edit
    @event = Event.friendly.find(params[:id])
    render :layout => 'dashboard'
  end

  def destroy
    @event = Event.friendly.find(params[:id])
    if current_user.has_role?(:admin)
      @event.destroy
    else
      @request = Request.new(status: 1, user_id: current_user.id, action: "destroy",
                             requestable_type: "Event", requestable_id: @event.id)
      @request.save
    end
    redirect_to events_path
  end

  def show
    @main_tabs = MainTab.all
    @categories = Category.all
    @event = Event.friendly.find(params[:id])
  end

  def update
    @event = Event.friendly.find(params[:id])
    parameters = event_params
    if parameters[:image].nil?
      if @event.image.attached?
        parameters[:image] = @event.image.blob
      end
    end
    # Validate requestables params
    unless validates?(parameters, Event)
      return
    end
    # Check if user asked for preview
    if params[:commit] == 'Podgląd'
      preview
      return
    end
    @event = Event.friendly.find(params[:id])
    #If user is an admin
    if current_user.has_role?(:admin)
      #Update event's attributes
      @event.update(:title => params[:event][:title],
                    :slug => params[:event][:slug],
                    :body => params[:event][:body],
                    :category_id => params[:event][:category_id],
                    :important => params[:event][:important],
                    :announcement => params[:event][:announcement],
                    :valid_date => params[:event][:valid_date],
                    :updated_at => Time.now)
      #If banner image was changed replace it
      unless params[:event][:image].nil?
        @event.update(:image => params[:event][:image])
      end
      # Get new blob id's from params
      blobs = get_blobs_from_ids(params[:event][:cache][0])
      # Purge old images and replace them with new ones
      @event.gallery_images.purge_later
      @event.gallery_images.attach(blobs)
      # Get new images from params
      new_images = params[:event][:gallery_images]
      #If new images were added add them to the event
      unless new_images.nil?
        @event.gallery_images.attach(new_images)
      end
      #If user is not an admin
    else
      #Create new event with given attributes
      @new_event = Event.new(:title => params[:event][:title],
                             :slug => params[:event][:slug],
                             :body => params[:event][:body],
                             :category_id => params[:event][:category_id],
                             :important => params[:event][:important],
                             :announcement => params[:event][:announcement],
                             :valid_date => params[:event][:valid_date],
                             :updated_at => Time.now)
      #If banner image was included add it
      unless params[:event][:image].nil?
        @new_event.update(:image => params[:event][:image])
        # Else use the one from original event
      else
        @new_event.image.attach(@event.image.blob)
      end
      # Get new blob id's from params
      blobs = get_blobs_from_ids(params[:event][:cache][0])
      # Attach blobs to the new event
      @new_event.gallery_images.attach(blobs)
      # Get uploaded images from params
      new_images = params[:event][:gallery_images]
      #If new images were added add them to the event
      unless new_images.nil?
        @new_event.gallery_images.attach(new_images)
      end
      #Change event status to unapproved
      @new_event.status = 2
      @new_event.save
      #Add new request for the admin
      @request = Request.new(status: 1, user_id: current_user.id, action: "edit/" + @event.id.to_s,
                             requestable_type: "Event", requestable_id: @new_event.id)
      @request.save
    end
    respond_to do |format|
      format.js { render 'validation-success' }
    end

  end

  def preview
    @event = Event.new(event_params)
    if event_params[:image] == nil
      @event.image.attach(Event.friendly.find(params[:id]).image.blob)
    end
    super
  end

  private def event_params
    params.require(:event).permit(:title, :slug, :category_id, :body, :important, :announcement, :image, :valid_date, :gallery_images => [])
  end
end
