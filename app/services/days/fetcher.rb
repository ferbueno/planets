module Days
  class Fetcher < ApplicationService
    attr_reader :page, :size

    def initialize(params)
      @page = params[:page] || 1
      @size = params[:size] || 5
    end

    def call
      Day.page(@page).per(@size).order(:day)
    end
  end
end
