module Planets
  class Fetcher < ApplicationService
    attr_reader :sort_field, :sort_order

    def initialize(sort_field: nil, sort_order: nil)
      @sort_field = sort_field
      @sort_order = sort_order
    end

    def call
      Planet.all.order_by(@sort_field, @sort_order)
    end
  end
end
