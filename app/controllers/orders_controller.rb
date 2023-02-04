class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new
    if @item.user == current_user
      redirect_to root_path
    end
  end
end