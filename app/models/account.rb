class Account < ApplicationRecord
  belongs_to :user
  has_many :expenses

  monetize :balance_cents
 
  has_many :senders, class_name: "Transfer",
                          foreign_key: "sender_account"
  has_many :receivers, class_name: "Transfer",
                          foreign_key: "receiver_account"
end
