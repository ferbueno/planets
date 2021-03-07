module Planets
  class PositionCalculator < ApplicationService
    attr_reader :planet, :day

    # @param [Integer, Planet] planet
    #   the planet or the id of the planet to calculate the position
    # @param [Integer] day
    #   the day number for the planet
    def initialize(planet, day)
      @planet = planet.is_a?(Planet) ? planet : Planet.find(planet)
      @day = day
    end

    # Gets the position in its own orbit in a specific day
    # for a planet
    #
    # Presents a 90 degree offset because of the system diagram
    #
    # @return [Integer]
    def call
      initial_position = ((@planet.speed * @day) % 360)
      if !planet.clockwise && initial_position != 0
        return 360 - initial_position
      end
      initial_position
      # initial_position + (@planet.clockwise ? -90 : 90)
    end
  end
end
