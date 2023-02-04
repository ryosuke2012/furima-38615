class OrderDelivery
  include ActiveModel::Model
  attr_accessor :postcode, :region_id, :municipality, :house_number, :building_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipality
    validates :house_number
    validates :phone_number, format: {/\A\d{10,11}\z/, message: 'is invalid'}
    validates :user_id
    validates :item_id
  end
  validates :region_id, numericality: {other_than: 0, message: "can't be blank"}
end