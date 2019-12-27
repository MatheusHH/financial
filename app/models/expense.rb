class Expense < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  belongs_to :user
  belongs_to :account

  monetize :value_cents

  enum status: [ :pendente, :pago ]

  after_commit :update_account_balance, on: :create
  after_commit :update_balances, on: :update 

  before_destroy :restore_balance


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

  def update_balances
  	if self.account_id.present?
      account = Account.find(self.account_id)
      account.balance_cents += self.previous_changes[:value_cents][0]
      account.update(balance_cents: account.balance_cents)
      if account.balance_cents >= self.previous_changes[:value_cents][1]
        account.balance_cents -= self.previous_changes[:value_cents][1]
        account.update(balance_cents: account.balance_cents) 
      else
        if account.balance_cents < self.value_cents
          self.errors.add :base, "There is not balance available" 
          raise ActiveRecord::RecordInvalid.new(self)
        end 
      end
    end
  end

  def restore_balance
    account = Account.find(self.account_id)
    balance_to_be_restored = self.value_cents
    account.balance_cents += balance_to_be_restored
    account.update(balance_cents: account.balance_cents) 
  end

end

