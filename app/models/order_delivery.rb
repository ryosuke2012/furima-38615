class OrderDelivery
  include ActiveModel::Model
  attr_accessor :postcode, :region_id, :municipality, :house_number, :building_name, :phone_number, :user_id, :item_id
end