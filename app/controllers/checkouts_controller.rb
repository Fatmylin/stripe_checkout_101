class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    current_user.set_payment_processor :stripe
    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      line_items: 'price_1RdA5xRoKBHfySNXuL2XpcHl',
      success_url: checkout_success_url,
    )
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:stripe_checkout_session_id])
    @line_items = Stripe::Checkout::Session.list_line_items(params[:stripe_checkout_session_id])
  end
end
