class Income < ApplicationRecord
  belongs_to :user

  monetize :value_cents

  before_save :update_account_balance, on: [:create, :update]
  after_save :update_balances, on: [ :update ]

  private

  def update_account_balance
  	if self.account_id.present?
  	  account = Account.find(self.account_id)
  	  account.balance_cents += self.value_cents
  	  account.update(balance_cents: account.balance_cents)
  	end
  end

  def update_balances
    sum_income = 0
    incomes = Income.where(user_id: self.user_id).where(account_id: self.account_id)
    incomes.each do |income|
      sum_income += income.value_cents
    end
    sum_expense = 0
    expenses = Expense.where(user_id: self.user_id).where(account_id: self.account_id)
    expenses.each do |expense|
      sum_expense += expense.value_cents
    end
    account = Account.find(self.account_id)
    account.balance_cents = sum_income - sum_expense
    account.update(balance_cents: account.balance_cents)
  end
end
