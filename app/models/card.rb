class Card < ApplicationRecord
  belongs_to :user

  has_many :expense_cards
  has_many :payment_cards

  monetize :limit_value_cents
  monetize :balance_card_cents

  before_create :set_initial_balance

  validates :card_name, presence: true
  validates :invoice_day, :closing_day, numericality: { greater_than_or_equal_to: 1 }

  private

  def set_initial_balance
  	self.balance_card_cents = self.limit_value_cents
  end
end
