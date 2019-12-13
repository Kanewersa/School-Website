class EventsController < RequestablesController
  layout 'application'

  def create
    @event = Event.new(event_params)

    if current_user.has_role?(:admin)
      @event.status = 1
      @event.save
    else
      @event.save
      @request = Request.new(status: 1, user_id: current_user.id, action: "create",
                             requestable_type: "Event", requestable_id: @event.id)
      @request.save
    end

    redirect_to events_path
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

  def update
    @event = Event.friendly.find(params[:id])
    if current_user.has_role?(:admin)
      @event.update(:title => params[:event][:title],
                    :slug => params[:event][:slug],
                    :body => params[:event][:body],
                    :category_id => params[:event][:category_id],
                    :important => params[:event][:important],
                    :announcement => params[:event][:announcement],
                    :image => params[:event][:image],
                    :updated_at => Time.now)
    else
      @new_event = Event.new(:title => params[:event][:title],
                             :slug => params[:event][:slug],
                             :body => params[:event][:body],
                             :category_id => params[:event][:category_id],
                             :important => params[:event][:important],
                             :announcement => params[:event][:announcement],
                             :image => params[:event][:image],
                             :updated_at => Time.now)
      @new_event.status = 2
      @new_event.save
      @request = Request.new(status: 1, user_id: current_user.id, action: "edit/" + @event.id,
                             requestable_type: "Event", requestable_id: @new_event.id)
      @request.save
    end
    redirect_to events_path
  end

  private def event_params
    params.require(:event).permit(:title, :slug, :category_id, :body, :important, :announcement, :image)
  end
end
