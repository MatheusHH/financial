class Income < ApplicationRecord
  belongs_to :user

  monetize :value_cents

  after_commit :update_account_balance, on: :create
  after_commit :update_balances, on: :update 

  private

  def update_account_balance
  	if self.account_id.present?
  	  account = Account.find(self.account_id)
  	  account.balance_cents += self.value_cents
  	  account.update(balance_cents: account.balance_cents)
  	end
  end

  def update_balances
    if self.account_id.present?
      account = Account.find(self.account_id)
      account.balance_cents -= self.previous_changes[:value_cents][0]
      account.balance_cents += self.previous_changes[:value_cents][1]
      account.update(balance_cents: account.balance_cents)
    end
  end
end
