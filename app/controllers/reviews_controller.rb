class ReviewsController < ApplicationController
  authorize_resource
  before_action :load_tour, only: :create

  def create
    @review = @tour.reviews.build
    @review.content = params[:review][:content]
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = t ".flash.create_review_successful"
      redirect_to tour_path(@tour)
    else
      flash.now[:danger] = t ".flash.create_review_failed"
      render tour_path(@tour)
    end
  end

  def edit; end

  def update
    @review = Review.find_by id: params[:review][:id]
    @review.content = params[:review][:content]
    if @review.save
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".flash.update_review_failed"
      redirect_to tours_path
    end
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:review][:tour_id]
    return if @tour

    flash[:danger] = t "reviews.flash.tour_not_found"
    redirect_to tours_path
  end
end
