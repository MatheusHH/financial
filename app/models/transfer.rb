class Transfer < ApplicationRecord
  belongs_to :user

  belongs_to :sender, class_name: "Account",
                          foreign_key: "sender_account"
  belongs_to :receiver, class_name: "Account",
                          foreign_key: "receiver_account"

  monetize :value_cents
  

  before_create :update_account
  before_destroy :restore_balance_account

  private

  def update_account
  	if self.sender_account.present? && self.receiver_account.present?
  	  account_sender = Account.find(self.sender_account)
  	  account_receiver = Account.find(self.receiver_account)
  	  if account_sender.balance_cents >= self.value_cents
  	  	account_sender.balance_cents -= self.value_cents
  	  	account_sender.update(balance_cents: account_sender.balance_cents)
  	  	account_receiver.balance_cents += self.value_cents
  	  	account_receiver.update(balance_cents: account_receiver.balance_cents)
  	  else
  	  	self.errors.add :base, "There is not balance available" 
  	  	raise ActiveRecord::RecordInvalid.new(self)
  	  end
  	end
  end

  def restore_balance_account
  	account_sender = Account.find(self.sender_account)
  	account_receiver = Account.find(self.receiver_account)
  	balance_to_be_restored = self.value_cents
    account_sender.balance_cents += balance_to_be_restored
    account_sender.update(balance_cents: account_sender.balance_cents)

    if balance_to_be_restored <= account_receiver.balance_cents	
      account_receiver.balance_cents -= balance_to_be_restored
      account_receiver.update(balance_cents: account_receiver.balance_cents)
    else
  	  self.errors.add :base, "There is not balance available to restore balance" 
	  raise ActiveRecord::RecordInvalid.new(self)
	end
  end 
end
