class BookingsController < ApplicationController
  load_and_authorize_resource
  before_action :load_tour, only: :new

  def index
    @bookings = @bookings.newest.paginate page: params[:page],
      per_page: Settings.bookings.paginate.per_page
  end

  def show
    return if @booking.tour && @booking.user

    flash[:danger] = t "bookings.flash.objects_not_found"
    redirect_to bookings_path
  end

  def new; end

  def total_price
    @total_price = params[:price].to_f * params[:number_passengers].to_f
    respond_to do |format|
      format.js
    end
  end

  def create
    @booking = Booking.new booking_params
    if @booking.save
      flash[:success] = t ".flash.create_booking_successful"
      redirect_to bookings_path
    else
      @tour = Tour.find_by id: params[:booking][:tour_id]
      flash.now[:danger] = t ".flash.create_booking_failed"
      render :new
    end
  end

  def approve
    if @booking.approved!
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".flash.approve_booking_failed"
      redirect_to bookings_path
    end
  end

  def cancel
    if @booking.canceled!
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".flash.cancel_booking_failed"
      redirect_to bookings_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit :tour_id, :user_id, :number_passengers,
      :total_price
  end

  def load_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour

    flash[:danger] = t "bookings.flash.tour_not_found"
    redirect_to root_path
  end
end
