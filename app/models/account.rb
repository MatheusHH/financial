class Account < ApplicationRecord
  belongs_to :user
  has_many :expenses

  monetize :balance_cents

  has_many :Transfers, class_name: "Transfer",
                          foreign_key: "transfer_id"
end
