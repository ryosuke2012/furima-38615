class ItemForm
  include ActiveModel::Model

  attr_accessor :name, :description, :images, :price, :category_id, :condition_id, :shipping_fee_id, :region_id, :delivery_time_id, :user_id, :id, :created_at, :updated_at, :tag_name

  validates :name, :description, :images, presence: true
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }

  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      presence: { message: "を入力してください" }
  end

  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :region_id
    validates :delivery_time_id
  end

  def save
    item = Item.create(name: name, description: description, category_id: category_id, condition_id: condition_id, shipping_fee_id: shipping_fee_id, region_id: region_id,
      delivery_time_id: delivery_time_id, price: price, user_id: user_id, images: images)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  def update(params, item)
    item.item_tag_relations.destroy_all
    tag_name = params.delete(:tag_name)
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?
    tag.save if tag_name.present?
    item.update(params)
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
  end
end