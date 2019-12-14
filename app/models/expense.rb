class Expense < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  belongs_to :user

  monetize :value_cents

  enum status: [ :pendente, :pago ]
end
