class ToursController < ApplicationController
  include ToursHelper

  before_action :load_tour, only: [:show, :create_review]
  before_action :load_locations, :load_reviews, :load_review, only: :show
  before_action :load_categories, only: :index

  def index
    handle_tours_search params
  end

  def show; end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:danger] = t "tours.flash.tour_not_found"
    redirect_to tours_path
  end

  def load_categories
    @categories = Category.alphabetical
  end

  def load_locations
    @locations =
      @tour.locations.includes(:images).limit Settings.tours.locations.limit
  end

  def load_reviews
    @reviews = @tour.reviews.most_likes(@tour.id).includes(:user).paginate page:
      params[:page], per_page: Settings.reviews.paginate.per_page
  end

  def load_review
    @tour.reviews.each do |review|
      @review = review if signed_in? && review.user_id == current_user.id
    end
  end
end
