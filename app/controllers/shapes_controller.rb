class ShapesController < ApplicationController
  def index
    @shapes = Shape.all
    render json: @shapes.to_json(:except => :_id)
  end

  def show
    @shape = Shape.where(shape_id: params[:id])
    render json: @shape.to_json(:except => :_id)
  end
end
