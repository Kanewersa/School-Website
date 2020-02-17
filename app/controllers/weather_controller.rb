class WeatherController < ApplicationController
  layout 'application'

  def show
    @main_tabs = MainTab.all
    @categories = Category.all

    #url = "https://www.weatherlink.com/embeddablePage/summaryData/68fa4f3ad9034a45bf73705968756fc1"
    url = "https://www.weatherlink.com/embeddablePage/getData/68fa4f3ad9034a45bf73705968756fc1"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
    set_current_weather(data)
    # abort data.inspect
  end


  private def set_current_weather(data)
    @overview = data["forecastOverview"][0]

    ### Get current weather
    @temperature = data["temperature"]
    @humidity = data["humidity"]
    @wind_speed = data["wind"]
    #@wind_direction = @overview[5]["value"]
    #@average_wind_speed_10min = @overview[7]["value"]
    @barometer = data["barometer"]
    @rain = data["rain"]
    #@last_hour_rain = @overview[14]["value"]
    @lowest_temperature = data["loTemp"]

    @weather_code_morning = @overview["morning"]["weatherCode"]
    @weather_code_afternoon = @overview["afternoon"]["weatherCode"]
    @weather_code_evening = @overview["evening"]["weatherCode"]
    @weather_code_night = @overview["night"]["weatherCode"]

    @current_date = @overview["date"]
    @day = Date.current.wday


  end
end
