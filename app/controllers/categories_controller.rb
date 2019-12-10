class CategoriesController < ApplicationController
  layout 'application'

  def show
    @main_tabs = MainTab.all
    @categories = Category.all
    @category = Category.friendly.find(params[:id])
    @events = Event.where(:category => @category).order("created_at DESC").all
  end
end
