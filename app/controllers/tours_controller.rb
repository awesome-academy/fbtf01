class ToursController < ApplicationController
  include ToursHelper

  before_action :load_tour, only: :show
  before_action :load_categories, only: :index

  def index
    handle_tours_search params
  end

  def show; end

  private

  def tour_params
    params.require(:tour).permit :name, :description, :min_passengers,
      :max_passengers, :date_from, :date_to, :price, :search
  end

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:danger] = t "tours.flash.tour_not_found"
    redirect_to tours_path
  end

  def load_categories
    @categories = Category.alphabetical
  end
end
