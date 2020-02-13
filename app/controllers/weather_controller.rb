class WeatherController < ApplicationController
  layout 'application'

  def show
    @main_tabs = MainTab.all
    @categories = Category.all
  end
end
