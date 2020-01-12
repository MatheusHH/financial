class Card < ApplicationRecord
  belongs_to :user
  
  monetize :limit_value_cents
  monetize :balance_card_cents

  before_create :set_initial_balance

  private

  def set_initial_balance
  	self.balance_card_cents = self.limit_value_cents
  end
end
