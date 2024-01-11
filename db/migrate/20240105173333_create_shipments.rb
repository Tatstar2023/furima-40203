class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.string     :postcode,      null: false
      t.integer    :prefecture_id, null: false
      t.string     :city,          null: false
      t.string     :house_number,  null: false
      t.string     :building_name
      t.string     :telephone,     null: false
      t.references :order,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
