class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_order
  before_action :move_to_index

  def index
    @order_delivery = OrderDelivery.new
    return unless @item.user == current_user

    redirect_to root_path
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:postcode, :region_id, :municipality, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_order
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    return if current_user && @item.order.nil?

    redirect_to root_path
  end
end
