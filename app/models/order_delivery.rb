class OrderDelivery
  include ActiveModel::Model
  attr_accessor :postcode, :region_id, :municipality, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'にハイフンを含めてください' }
    validates :municipality
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'をハイフンなしで10桁以上or11桁以内で入力してください' }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :region_id, numericality: { other_than: 1, message: "を選択してください" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(postcode: postcode, region_id: region_id, municipality: municipality, house_number: house_number,
                    building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
