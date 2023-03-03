class ItemForm
  include ActiveModel::Model

  attr_accessor :name, :description, :images, :price, :category_id, :condition_id, :shipping_fee_id, :region_id, :delivery_time_id
end