class Account < ApplicationRecord
  belongs_to :user
  has_many :expenses

  monetize :balance_cents
end
