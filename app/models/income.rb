class Income < ApplicationRecord
  belongs_to :user

  monetize :value_cents

  before_create :update_account_balance_create
  before_update :update_balances_update 

  private

  def update_account_balance_create 
  	if self.account_id.present?
  	  account = Account.find(self.account_id)
  	  account.balance_cents += self.value_cents
  	  account.update(balance_cents: account.balance_cents)
  	end
  end

  def update_balances_update
    if self.account_id.present?
      account = Account.find(self.account_id)
      if self.value_cents_changed? && self.account_id_changed? == false
        account.balance_cents -= self.value_cents_was
        account.balance_cents += self.value_cents_change[1]
        account.update(balance_cents: account.balance_cents)
      else
        if self.value_cents_changed? && self.account_id_changed?
          old_account = Account.find(self.account_id_was)
          new_account = Account.find(self.account_id_change[1])

          if old_account.balance_cents >= self.value_cents_was
            old_account.balance_cents -= self.value_cents_was
            old_account.update(balance_cents: old_account.balance_cents)

            new_account.balance_cents += self.value_cents_change[1]
            new_account.update(balance_cents: new_account.balance_cents) 
          else
            self.errors.add :base, "There is not balance available" 
            raise ActiveRecord::RecordInvalid.new(self)
          end
        else
          if self.account_id_changed? && self.value_cents_changed? == false
            old_account = Account.find(self.account_id_was)
            new_account = Account.find(self.account_id_change[1])

            if old_account.balance_cents >= self.value_cents
              old_account.balance_cents -= self.value_cents
              old_account.update(balance_cents: old_account.balance_cents)

              new_account.balance_cents += self.value_cents
              new_account.update(balance_cents: new_account.balance_cents)
            else
              self.errors.add :base, "There is not balance available" 
              raise ActiveRecord::RecordInvalid.new(self)
            end
          end
        end
      end
    end
  end

end
