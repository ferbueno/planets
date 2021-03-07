class Day < ApplicationRecord
  enum weather: {
    rain: 'rain',
    optimal: 'optimal',
    drought: 'drought',
    unavailable: 'unavailable',
  }

end
