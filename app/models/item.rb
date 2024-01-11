class Item < ApplicationRecord
  validates :title,               presence: true
  validates :description,         presence: true
  validates :category_id,         presence: true,
                                  numericality: { other_than: 0, message: "can't be blank" }
  validates :condition_id,        presence: true,
                                  numericality: { other_than: 0, message: "can't be blank" }
  validates :shippingfee_id,      presence: true,
                                  numericality: { other_than: 0, message: "can't be blank" }
  validates :shippingorigin_id,   presence: true,
                                  numericality: { other_than: 0, message: "can't be blank" }
  validates :shippingleadtime_id, presence: true,
                                  numericality: { other_than: 0, message: "can't be blank" }
  validates :price, presence: true,
                    format: {
                      with: /\A\d+\z/,
                      message: 'is not a number'
                    },
                    numericality: {
                      greater_than_or_equal_to: 300,
                      allow_blank: true,
                      message: 'must be greater than or equal to 300',
                      less_than_or_equal_to: 9999999,
                      message: 'must be less than or equal to 9999999'
                    }
  validates :image, presence: true

  belongs_to :user
  has_one    :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shippingfee
  belongs_to :shippingorigin
  belongs_to :shippingleadtime
end
