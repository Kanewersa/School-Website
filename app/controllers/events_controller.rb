class EventsController < ApplicationController
  layout 'application'

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path
    else
      redirect_back(fallback_location: events_path)
    end
  end

  def edit
    @event = Event.friendly.find(params[:id])
    render :layout => 'dashboard'
  end

  def destroy
    @event = Event.friendly.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  def update
    @event = Event.friendly.find(params[:id])
    @event.update(:title => params[:event][:title],
                  :slug => params[:event][:slug],
                  :body => params[:event][:body],
                  :category_id => params[:event][:category_id],
                  :important => params[:event][:important],
                  :announcement => params[:event][:announcement],
                  :image => params[:event][:image],
                  :updated_at => Time.now)
    redirect_to events_path
  end

  private def event_params
    params.require(:event).permit(:title, :slug, :category_id, :body, :important, :announcement, :image)
  end
end
