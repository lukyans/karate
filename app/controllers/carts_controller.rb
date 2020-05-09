class CartsController < ApplicationController

  # GET /carts/1
  # GET /carts/1.json
  def show
    @footer_variable = true
    @cart = @current_cart
    @order = Order.new
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @current_cart.line_items.find(params[:line_id]).destroy
    if @current_cart.line_items.empty?
      @cart = @current_cart
      @cart.destroy
      session[:cart_id] = nil
      redirect_to root_path and return
    end
    redirect_to cart_path(@current_cart) and return
  end

  private
    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end
end
