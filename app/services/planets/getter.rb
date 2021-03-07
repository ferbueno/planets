module Planets
  class Getter < ApplicationService
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def call
      Planet.find @id
    end
  end
end
