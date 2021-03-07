class WeatherJob < ApplicationJob
  queue_as :default

  def perform
    # Start at 0
    next_day = (Day.order(day: :desc).pluck(:day)&.first || -1) + 1
    weather = Days::WeatherCalculator.call(next_day)
    if weather.is_a?(String)
      Day.create!(
        day: next_day,
        weather: weather
      )
    else
      Day.create!(
        day: next_day,
        weather: weather[:weather],
        max_intensity: weather[:max_intensity]
      )
    end
  end
end
