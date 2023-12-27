class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,            presence: true
  validates :encrypted_password,  presence: true, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "is invalid. Include both letters and numbers" }
  validates :first_name_zenkaku,  presence: true
  validates :last_name_zenkaku,   presence: true
  validates :first_name_katakana, presence: true
  validates :last_name_katakana,  presence: true
  validates :birthday,            presence: true

  has_many :items
  has_many :purchases

end
