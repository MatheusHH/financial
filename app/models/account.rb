class Account < ApplicationRecord
  belongs_to :user
  has_many :expenses
  has_many :payment_cards
  
  monetize :balance_cents
 
  has_many :senders, class_name: "Transfer",
                          foreign_key: "sender_account"
  has_many :receivers, class_name: "Transfer",
                          foreign_key: "receiver_account"

  validates :bank, presence: true
end
