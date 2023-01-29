class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :region
  belongs_to :delivery_time

  validates :name, :description, :price, :image, presence: true

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :region_id
    validates :delivery_time_id
  end
end