class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many_attached :images
  has_many :comments

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :region
  belongs_to :delivery_time
end