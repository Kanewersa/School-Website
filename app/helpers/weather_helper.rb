module WeatherHelper

  def get_day_name
    @day += 1
    @day_name = Date::DAYNAMES[(@day) % 7]
  end

  def get_time
    hour = Time.now.hour
    case hour
    when 0..6
      @weather_code = @weather_code_night
    when 7..11
      @weather_code = @weather_code_morning
    when 12..16
      @weather_code = @weather_code_afternoon
    when 17..20
      @weather_code = @weather_code_evening
    else
      @weather_code = @weather_code_night
    end
  end

  def get_weather_icon
    get_time
    case @weather_code
    when 116 # Partly cloudy
      "<div class='icon icon-fit sun-shower'>
        <div class='cloud'></div>
        <div class='sun'>
          <div class='rays'></div>
        </div>
      </div>".html_safe
    when 1116 # Partly Cloudy
      "<div class='icon icon-fit sun-shower'>
        <div class='cloud'></div>
        <div class='sun'>
          <div class='rays'></div>
        </div>
      </div>".html_safe
    when 119 # Cloudy
      "<div class='icon icon-fit cloudy'>
        <div class='cloud'></div>
        <div class='cloud'></div>
      </div>".html_safe
    when 113 # Clear/Sunny
      "<div class='icon icon-fit sunny'>
        <div class='sun'>
          <div class='rays'></div>
        </div>
      </div>".html_safe
    when 1113 # Clear
      "<div class='icon icon-fit sunny'>
        <div class='sun'>
          <div class='rays'></div>
        </div>
      </div>".html_safe
    when 326 # Light snow
      "<div class='icon icon-fit flurries'>
        <div class='cloud'></div>
        <div class='snow'>
          <div class=f'lake'></div>
          <div class='flake'></div>
        </div>
      </div>".html_safe
    when 368 # Light snow showers
      "<div class='icon icon-fit flurries'>
        <div class='cloud'></div>
        <div class='snow'>
          <div class=f'lake'></div>
          <div class='flake'></div>
        </div>
      </div>".html_safe
    when 296 # Light rain
      "<div class='icon icon-fit sun-shower'>
        <div class='cloud'></div>
        <div class='sun'>
          <div class='rays'></div>
        </div>
        <div class='rain'></div>
      </div>".html_safe
    when 176 # Patchy rain nearby
      "<div class='icon icon-fit sun-shower'>
        <div class='cloud'></div>
        <div class='sun'>
          <div class='rays'></div>
        </div>
        <div class='rain'></div>
      </div>".html_safe
    else # Unknown weather
      "<div class='icon icon-fit cloudy'>
        <div class='cloud'></div>
        <div class='cloud'></div>
      </div>".html_safe
    end
  end
end
