class PaymentCard < ApplicationRecord
  belongs_to :card
  belongs_to :account
  belongs_to :user

  monetize :value_cents
end
