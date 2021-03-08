module Days
  class Getter < ApplicationService
    attr_reader :day

    def initialize(day)
      @day = Integer(day)
    end

    def call
      new_day = Day.find_by(day: @day)
      return new_day if new_day

      # Failsafe if the day does not exist
      {
        day: @day,
        weather: Days::WeatherCalculator.call(@day),
      }
    end
  end
end
