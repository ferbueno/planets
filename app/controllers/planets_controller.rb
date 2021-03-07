class PlanetsController < ApplicationController
  def index
    render json: Planets::Fetcher.call(params.permit(:sort_field, :sort_order))
  end

  def show
    render json: Planets::Getter.call(params.require(:id))
  end
end
