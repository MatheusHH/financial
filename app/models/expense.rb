class Expense < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  belongs_to :user
  belongs_to :account

  monetize :value_cents

  enum status: [ :pendente, :pago ]

  before_create :update_account_balance_create
  before_update :update_account_balance_update 

  before_destroy :restore_balance


  private

  def update_account_balance_create
  	if self.account_id.present?
  	  account = Account.find(self.account_id)
  	  if account.balance_cents >= self.value_cents && self.pago? 
  	  	account.balance_cents -= self.value_cents
  	  	account.update(balance_cents: account.balance_cents)
      elsif self.pago? == false
                          
  	  else
  	  	self.errors.add :base, "There is not balance available" 
  	  	raise ActiveRecord::RecordInvalid.new(self)
  	  end
  	end
  end

  def update_account_balance_update
    if self.account_id.present?
      account = Account.find(self.account_id) 
      if self.status_changed? 
        if account.balance_cents >= self.value_cents && self.status_change[1] == "pago"
          account.balance_cents -= self.value_cents
          account.update(balance_cents: account.balance_cents) 
        elsif self.status_change[1] == "pendente"
          account.balance_cents += self.value_cents
          account.update(balance_cents: account.balance_cents)
        else
          self.errors.add :base, "There is not balance available" 
          raise ActiveRecord::RecordInvalid.new(self)
        end
      elsif self.value_cents_changed? && self.pago?
        account.balance_cents += self.value_cents_was
        if account.balance_cents >= self.value_cents_change[1]
          account.balance_cents -= self.value_cents_change[1]
          account.update(balance_cents: account.balance_cents)
        else
          self.errors.add :base, "There is not balance available" 
          raise ActiveRecord::RecordInvalid.new(self)
        end
      end
    end   
  end

  def restore_balance
    if self.pago?
      account = Account.find(self.account_id)
      balance_to_be_restored = self.value_cents
      account.balance_cents += balance_to_be_restored
      account.update(balance_cents: account.balance_cents) 
    end 
  end

end

