module Days
  class Getter < ApplicationService
    attr_reader :day

    def initialize(day)
      @day = day
    end

    def call
      Day.find_by(day: @day)
    end
  end
end
