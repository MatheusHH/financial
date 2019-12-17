class Expense < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  belongs_to :user
  belongs_to :account

  monetize :value_cents

  enum status: [ :pendente, :pago ]

  before_save :update_account_balance, on: [ :create, :update ]
  #before_update :update_balances


  private

  def update_account_balance
  	if self.account_id.present?
  	  account = Account.find(self.account_id)
  	  if account.balance_cents >= self.value_cents
  	  	account.balance_cents -= self.value_cents
  	  	account.update(balance_cents: account.balance_cents) 
  	  else
  	  	if account.balance_cents < self.value_cents
  	  	  self.errors.add :base, "There is not balance available" 
  	  	  raise ActiveRecord::RecordInvalid.new(self)
  	  	end 
  	  end
  	end
  end

  #def update_balances
  #	sum_income = 0
  #	incomes = Income.find(user_id: self.user_id)
  #	incomes.each do |income|
  #	  sum_income += income.value_cents
  #	end
  #	sum_expense = 0
  #	expenses = Expense.find(user_id: self.user_id)
  #	expenses.each do |expense|
  #	  sum_expense += expense.value_cents
  #	end
  #	account = Account.find(self.account_id)
  #	account.balance_cents = sum_income - sum_expense
  #	self.account.update(balance_cents: account.balance_cents)
  #end

end
