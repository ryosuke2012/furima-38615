class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new
    if @item.user == current_user
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      Payjp.api_key = "sk_test_90e70af7fa0bafe4cae493a6"
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
      @order_delivery.save
      redirect_to root_path
    else
      render :index
    end      
  end

  private

  def order_params
    params.require(:order_delivery).permit(:postcode, :region_id, :municipality, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
end