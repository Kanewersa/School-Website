class PagesController < ApplicationController
  layout 'application'

  def main
    @main_tabs = MainTab.all
    @categories = Category.all
    @events_count = properEventsAmount
    @events = Event.order("important DESC, created_at DESC").take(@events_count)
  end

  def properEventsAmount
    important = Event.where('important').all.count
    if important > 3
      return important + 9 - 3
    end
    9
  end

  def dashboard
    if user_signed_in?
      render :layout => 'dashboard'
    else
      redirect_to login_path
    end
  end

  def test
    render :layout => 'test'
  end
end
