class ChargesController < ApplicationController
  def new
  end

  def create
  # Amount in cents
  amount_in_dollars = @current_cart.sub_total
  @amount = @current_cart.dollars_to_cents(amount_in_dollars)

  @current_cart.line_items.each do |item|
    item.cart_id = nil
  end
  Cart.destroy(session[:cart_id])
  session[:cart_id] = nil

  customer = Stripe::Customer.create({
    email: params[:stripeEmail],
    source: params[:stripeToken],
  })

  charge = Stripe::Charge.create({
    customer: customer.id,
    amount: @amount,
    description: 'Rails Stripe customer',
    currency: 'usd',
  })

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
