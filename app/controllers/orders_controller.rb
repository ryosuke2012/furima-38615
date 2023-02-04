class OrdersController < ApplicationController

  def index
    @order_delivery = OrderDelivery.new
  end
end