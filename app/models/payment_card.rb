class PaymentCard < ApplicationRecord
  belongs_to :card
  belongs_to :account
  belongs_to :user

  monetize :value_cents

  before_create :update_card_and_account_balance
  before_destroy :restore_card_balance

  private

  def update_card_and_account_balance
  	if self.card_id.present? && self.account_id.present?
  	  card = Card.find(self.card_id)
  	  closing_date = (self.invoice_payment_date.beginning_of_month + card.closing_day.days) - 1.day
  	  invoice_total_value = sum_expense_cards(closing_date, self.user_id)
  	  if self.invoice_payment_date == closing_date && invoice_total_value == self.value_cents
  	    updated_value = self.value_cents + card.balance_card_cents
  	    if updated_value <= card.limit_value_cents
  	  	  card.update(balance_card_cents: updated_value) 
  	  	  update_expenses_card(closing_date, self.user_id, "pago")
  	    else
  	  	  self.errors.add :base, "Payment is bigger than balance card" 
  	  	  raise ActiveRecord::RecordInvalid.new(self)
  	    end
 
  	    account = Account.find(self.account_id)
  	    if self.value_cents <= account.balance_cents
  	  	  account.balance_cents -= self.value_cents
  	  	  account.update(balance_cents: account.balance_cents)
  	    else
  	  	  self.errors.add :base, "There is not balance available" 
  	  	  raise ActiveRecord::RecordInvalid.new(self)
  	    end
  	  else
  	  	self.errors.add :base, "There is not invoice with current closing date or the value is not equal" 
  	  	raise ActiveRecord::RecordInvalid.new(self)
  	  end  
  	end
  end

  def restore_card_balance
  	card = Card.find(self.card_id)
  	account = Account.find(self.account_id)
  	closing_date = (self.invoice_payment_date.beginning_of_month + card.closing_day.days) - 1.day
  	restored_balance_card = self.value_cents
  	restore_account_balance = self.value_cents
  	if restored_balance_card <= card.balance_card_cents
  	  card.balance_card_cents -= restored_balance_card
  	  card.update(balance_card_cents: card.balance_card_cents)
  	  update_expenses_card(closing_date, self.user_id, "pendente")
  	else
  	  self.errors.add :base, "there is not balance card available" 
  	  raise ActiveRecord::RecordInvalid.new(self)
  	end

  	account.balance_cents += restore_account_balance
  	account.update(balance_cents: account.balance_cents)
  end

  # auxiliar methods
  def update_expenses_card(closing_date, user_id, status)
  	end_date = closing_date - 1.day
    initial_date = end_date - 29.days
  	expense_cards = ExpenseCard.joins(:card).where(user_id: user_id).where(
  	  "expense_cards.invoice_date between ? and ?", initial_date, end_date)
  	expense_cards.each do |expense_card|
  	  expense_card.update(status: status)
  	end
  end

  def sum_expense_cards(closing_date, user_id)
  	end_date = closing_date - 1.day
    initial_date = end_date - 29.days
  	expense_cards_total = ExpenseCard.joins(:card).where(user_id: user_id).where(
  	  "expense_cards.invoice_date between ? and ?", initial_date, end_date).where(status: :pendente).sum(:value_cents)
  	expense_cards_total
  end
end
