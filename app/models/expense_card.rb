class ExpenseCard < ApplicationRecord
  belongs_to :card
  belongs_to :user

  monetize :value_cents

  before_create :update_limit_card
  before_destroy :update_limit_card_deteted

  private

  def update_limit_card
  	if self.card_id.present?
  	  card = Card.find(self.card_id)
  	  if card.balance_card_cents >= self.value_cents
  	  	card.balance_card_cents -= self.value_cents
  	  	card.update(balance_card_cents: card.balance_card_cents)
  	  else
  	  	self.errors.add :base, "There is not limit available" 
  	  	raise ActiveRecord::RecordInvalid.new(self)
  	  end
  	end
  end

  def update_limit_card_deteted
    card = Card.find(self.card_id)
    value_to_be_restored = self.value_cents
    card.balance_card_cents += value_to_be_restored
    card.update(balance_card_cents: card.balance_card_cents) 
  end
end
