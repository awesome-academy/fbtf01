class ChargesController < ApplicationController
  before_action :load_booking, only: :create

  def new; end

  def create
    card = load_customer_card
    create_charge card, @booking

    @booking.update_column :status, Booking.statuses[:approved]
    flash[:success] = t ".checkout_successful"
    redirect_to bookings_path
  rescue Stripe::CardError => e
    flash[:danger] = t ".checkout_failed", e: e.message
    redirect_to bookings_path
  end

  private

  def load_booking
    @booking = Booking.find_by id: params[:booking_id]
    return if @booking

    flash[:danger] = t "charges.flash.booking_not_found"
    redirect_to root_path
  end

  def load_customer_card
    customer = Stripe::Customer.retrieve current_user.customer_id
    card_fingerprint =
      Stripe::Token.retrieve(params[:stripeToken]).try(:card).try :fingerprint

    selected_card =
      if card_fingerprint
        selected = customer.sources.all.data.select do |card|
          card_fingerprint == card.fingerprint
        end
        selected.last
      end
    selected_card || customer.sources.create(source: params[:stripeToken])
  end

  def create_charge card, booking
    Stripe::Charge.create(
      customer: current_user.customer_id,
      source: card.id,
      amount: (booking.total_price * 100).to_i,
      currency: "usd"
    )
  end
end
