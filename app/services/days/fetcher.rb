module Days
  class Fetcher < ApplicationService
    attr_reader :page, :size

    def initialize(page: 1, size: 20)
      @page = page
      @size = size
    end

    def call
      Day.page(@page).per(@size).order(:number)
    end
  end
end
