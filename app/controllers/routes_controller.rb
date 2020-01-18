class RoutesController < ApplicationController
  def index
    @routes = Route.all
    render json: @routes.to_json
  end

  def show
    @route = Route.find(params[:id])
    render json: @route.to_json
  end
end
