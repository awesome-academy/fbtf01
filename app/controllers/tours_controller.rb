class ToursController < ApplicationController
  include ToursHelper

  load_and_authorize_resource
  before_action :load_locations, :load_reviews, :load_review, only: :show
  before_action :load_categories, only: :index

  def index
    @q = Tour.ransack params[:tours]
    @tours = load_tours_by_category params[:category_id] if params[:category_id]
    @tours = @q.result(distinct: true).includes :locations if params[:tours]
    @tours = @tours.paginate page: params[:page],
      per_page: Settings.tours.paginate.per_page
  end

  def show; end

  private

  def load_categories
    @categories = Category.alphabetical
  end

  def load_locations
    @locations =
      @tour.locations.includes(:images).limit Settings.tours.locations.limit
  end

  def load_reviews
    @reviews = @tour.reviews.most_likes(@tour.id).includes(:user,
      :likes).paginate page: params[:page],
      per_page: Settings.reviews.paginate.per_page
  end

  def load_review
    @tour.reviews.each do |review|
      @review = review if review.user_id == current_user.try(:id)
    end
  end
end
