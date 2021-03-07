module Days
  class WeatherCalculator < ApplicationService
    attr_reader :day, :positions, :coordinates

    def initialize(day)
      @day = day
      @positions = Planet.all.map do |planet|
        {
          distance: planet.distance,
          position: Planets::PositionCalculator.call(planet, day)
        }
      end
      @coordinates = transform_to_coordinates(@positions)
    end

    def call
      return 'drought' if check_sun_alignment

      return 'optimal' if check_slopes

      if check_triangle
        return {
          weather: 'rain',
          max_intensity: max_perimeter?
        }
      end

      'unavailable'
    end

    private

    # Checks if all planets are aligned on the same angle
    #
    # If they all are, it means at least two of them
    # share a common angle
    #
    # @return [Boolean]
    def check_sun_alignment
      positions = @positions.map do |position| position[:position] end
      unique = positions.uniq
      unique.size == 1 ||
        (unique.size == 2 && invert_angle(unique[0]) == unique[1])
    end

    # Inverts the angle to check
    # alignment
    #
    # For example:
    #   invert_angle(90)
    #     => 270
    #
    #   invert_angle(180)
    #     => 0
    #
    #   invert_angle(235)
    #     => 55
    #
    # @return [Integer]
    def invert_angle(angle)
      if angle >= 180
        angle - 180
      else
        angle + 180
      end
    end

    # this value can be calculated through a formula that
    # depends on the biggest triangle's inner circle
    #
    # For more information, check:
    # https://math.stackexchange.com/questions/467460/finding-maximum-perimeter-of-a-triangle
    # https://www.wolframalpha.com/input/?i=1%E2%88%92%28%281%2F250000%29%2B%281%2F1000000%29%2B%281%2F4000000%29%29r%5E2%E2%88%92%282%2F%28500*1000*2000%29%29r%5E3+%3D+0
    # https://www.wolframalpha.com/input/?i=6327.5242369476575833734941092435500905470491342264738580979&assumption=ClashPrefs_*Math-
    MAX_PERIMETER = 6327.5 # 6327.5242

    def check_slopes
      # Follows the formula for equal slopes
      # (y2 - y1)/(x2 - x1) == (y3 - y1) / (x3 - x1)
      ((@coordinates[1][1] - @coordinates[0][1]) / (@coordinates[1][0] - @coordinates[0][0])) ==
        ((@coordinates[2][1] - @coordinates[0][1]) / (@coordinates[2][0] - @coordinates[0][0]))
    end

    def check_triangle
      total_area = area(@coordinates)
      area_1 = area([[0, 0], @coordinates[1], @coordinates[2]])
      area_2 = area([@coordinates[0], [0, 0], @coordinates[2]])
      area_3 = area([@coordinates[0], @coordinates[1], [0, 0]])
      total_area == area_1 + area_2 + area_3
    end

    # Calculates the area of the passed coordinates triangle
    #
    # @param [<Array<Array<Float>>] coordinates
    #   the coordinates matrix to calculate the area for
    #
    # @return[Numeric]
    def area(coordinates)
      ((coordinates[0][0] * (coordinates[1][1] - coordinates[2][1]) + coordinates[1][0] * (coordinates[2][1]
      - coordinates[0][1]) + coordinates[2][0] * (coordinates[0][1] - coordinates[1][1])) / 2.0).abs
    end

    # Transforms the planets into coordinates depending on
    # their position and their distance to the sun
    #
    # Returns a matrix in the form of:
    #   [[x1, y1], [x2, y2], [x3, y3]]
    #
    # @return [Array<Array<Integer>>]
    def transform_to_coordinates(planets)
      planets.map do |planet|
        [Math.cos(planet[:position]) * planet[:distance], Math.sin(planet[:position]) * planet[:distance]]
      end
    end

    # Calculates the perimeter of the triangle and
    # checks if the perimeter is the maximum
    #
    # It's checked with >= because MAX_PERIMETER is rounded to 1 decimal
    # to avoid checking for loss of precision thanks to float
    #
    # @return [Boolean]
    def max_perimeter?
      distance_a_b = Math.sqrt((@coordinates[0][0] - @coordinates[1][0])**2 + (@coordinates[0][1] - @coordinates[1][1])**2)

      distance_b_c = Math.sqrt((@coordinates[1][0] - @coordinates[2][0])**2 + (@coordinates[1][1] - @coordinates[2][1])**2)

      distance_a_c = Math.sqrt((@coordinates[0][0] - @coordinates[2][0])**2 + (@coordinates[0][1] - @coordinates[2][1])**2)

      (distance_a_b + distance_b_c + distance_a_c) >= MAX_PERIMETER
    end



#     def max_perimeter(planets)
#       query = "1%E2%88%92((1%2F#{planets[0][:distance]**2})%2B(1%2F#{planets[1][:distance]**2})%2B(1%2F#{planets[2][:distance]**2}))
# r%5E2%E2%88%92(2%2F(#{planets[0][:distance]}*#{planets[1][:distance]}*#{planets[2][:distance]}))
# r%5E3+%3D+0&format=plaintext&output=JSON&appid=#{ENV['WOLFRAM_APP_ID']}"
#
#       response = Faraday.get ""
#
#     end
  end
end
