class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid?
      @item_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
  end

  def update
    @item_form = ItemForm.new(item_form_params)
    @item_form.images ||= @item.images.blobs
    if @item_form.valid?
      @item_form.update(item_form_params, @item)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if @item.user == current_user
    redirect_to root_path
  end

  private

  def item_form_params
    params.require(:item_form).permit(:name, :description, :category_id, :condition_id, :shipping_fee_id, :region_id,
                                 :delivery_time_id, :price, {images: []}).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    return redirect_to root_path if @item.user != current_user ||  @item.order.present?
  end
end