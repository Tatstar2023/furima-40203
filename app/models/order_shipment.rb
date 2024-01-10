class OrderShipment
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postcode, :prefecture_id, :city, :house_number, :building_name, :telephone

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postcode,
              format: {
                with: /\A[0-9]{3}-[0-9]{4}\z/,
                message: 'is invalid. Include hyphen(-)'
              }
    validates :city
    validates :house_number
    validates :telephone, format: {
                            with: /\A\d{10,11}\z/,
                            message: 'is the wrong length (should be 10 or 11 characters)'
                          },
                          numericality: { only_integer: true, message: 'is invalid. Input only number' }
  end

  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

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
