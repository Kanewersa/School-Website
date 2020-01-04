class EventsController < RequestablesController
  include Rails.application.routes.url_helpers
  layout 'application'
  respond_to :js, :html

  def create
    if params[:commit] == 'Podgląd'
      @event = Event.new(event_params)
      preview('preview', @event)
      nil
    else
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
      ajax_redirect_to(events_path)
    end
  end

  def edit
    @event = Event.friendly.find(params[:id])
    #abort @event.gallery_images.blobs[0].inspect
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
    new_keys = params[:event][:cache][0].split(',')
    new_keys = new_keys.reject { |key| key.empty? }
    @event = Event.friendly.find(params[:id])

    #@event.gallery_images = params[:event][:gallery_images]
    #@event.save
    #return
    images = params[:event][:gallery_images]
    blobs = []
    new_keys.each do |key|
      blobs.push(ActiveStorage::Blob.find_signed(key))
    end
    @event.gallery_images.purge_later
    @event.gallery_images.attach(blobs)

    unless images.nil?
        @event.gallery_images.attach(images)
    end

    ajax_redirect_to(edit_event_path(:id => params[:id]))
    return
    #
    abort @event.gallery_images.blobs.inspect
    if params[:commit] == 'Podgląd'
      @event = Event.new(event_params)
      if event_params[:image] == nil
        @event.image.attach(Event.friendly.find(params[:id]).image.blob)
      end
      preview('preview', @event)
      nil
    else
      @event = Event.friendly.find(params[:id])
      if current_user.has_role?(:admin)
        @event.update(:title => params[:event][:title],
                      :slug => params[:event][:slug],
                      :body => params[:event][:body],
                      :category_id => params[:event][:category_id],
                      :important => params[:event][:important],
                      :announcement => params[:event][:announcement],
                      :valid_date => params[:event][:valid_date],
                      :updated_at => Time.now)
        unless params[:event][:image].nil?
          @event.update(:image => params[:event][:image])
        end
        old_keys []
        new_keys = []
        @event.gallery_images.blobs.each do |blob|
          old_keys.push(blob.signed_id)
        end
        params[:event][:gallery_images].each do |key|
          new_keys.push(key)
        end

        #unless params[:event][:gallery_images].nil?
        #  @event.update(:gallery_images => params[:event][:gallery_images])
        #end
      else
        @new_event = Event.new(:title => params[:event][:title],
                               :slug => params[:event][:slug],
                               :body => params[:event][:body],
                               :category_id => params[:event][:category_id],
                               :important => params[:event][:important],
                               :announcement => params[:event][:announcement],
                               :valid_date => params[:event][:valid_date],
                               :updated_at => Time.now)
        unless params[:event][:image].nil?
          @new_event.update(:image => params[:event][:image])
        end

        @new_event.status = 2
        @new_event.save
        @request = Request.new(status: 1, user_id: current_user.id, action: "edit/" + @event.id.to_s,
                               requestable_type: "Event", requestable_id: @new_event.id)
        @request.save
      end
      ajax_redirect_to(events_path)
    end
  end

  private def event_params
    params.require(:event).permit(:title, :slug, :category_id, :body, :cache, :important, :announcement, :image, :valid_date)
  end
end
