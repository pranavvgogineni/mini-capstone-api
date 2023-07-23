class User < ApplicationRecord
  has_many :orders
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :carted_products
end
