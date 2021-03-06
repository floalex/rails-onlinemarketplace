class Order < ActiveRecord::Base
  validates :address, :city, :state, presence: true
  belongs_to :listing
  belongs_to :buyer, class_name: "User", foreign_key: "seller_id"
  belongs_to :seller, class_name: "User", foreign_key: "buyer_id"
end
