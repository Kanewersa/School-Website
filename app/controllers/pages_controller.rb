class PagesController < ApplicationController
  layout 'application'

  def main
    @main_tabs = MainTab.all
    @categories = Category.all
    @partners = Partner.all
    @events_count = properEventsAmount
    @events = Event.where("status = 1").order("important DESC, created_at DESC").take(@events_count)
    @plan_tab = SubTab.where("title = ?", "Plan lekcji").take!
    @classes_tab = SubTab.where("title = ?", "Zajęcia pozalekcyjne").take!
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

  private
  def properEventsAmount
    important = Event.where('important').all.count
    if important > 3
      return important + 9 - 3
    end
    9
  end
end
