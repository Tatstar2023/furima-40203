class OrderShipment
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postcode, :prefecture_id, :city, :house_number, :building_name, :telephone

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
  end

  validates :postcode, presence: true,
                       format: {
                         with: /\A[0-9]{3}-[0-9]{4}\z/,
                         message: 'is invalid. Include hyphen(-)'
                       }
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  with_options presence: true do
    validates :city
    validates :house_number
    validates :telephone, length: { is: 11 },
                          numericality: { only_integer: true, message: ' is invalid. Input only number' }
  end

  def save
    # 購入情報を保存し、変数orderに代入
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    Shipment.create(
      postcode: postcode, prefecture_id: prefecture_id, city: city,
      house_number: house_number, building_name: building_name,
      telephone: telephone, order_id: order.id
    )
  end
end
