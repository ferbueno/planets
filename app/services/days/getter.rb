module Days
  class Getter < ApplicationService
    attr_reader :day

    def initialize(day)
      Integer(day)
      @day = day
    end

    def call
      new_day = Day.find_by(day: @day)
      return new_day if new_day

      # Failsafe if the day does not exist
      Days::WeatherCalculator.call(new_day)
    end
  end
end
