class HomeController < ApplicationController
  def index
    @footer_variable = true
    @products = Product.all
  end
end
