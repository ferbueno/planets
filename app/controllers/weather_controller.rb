class WeatherController < ApplicationController
  def index
    render json: Days::Fetcher.call(params.permit(:page, :size))
  end

  def show
    render json: Days::Getter.call(params[:id])
  end
end
