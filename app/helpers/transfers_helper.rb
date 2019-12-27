module TransfersHelper
  def account_bank_name(account_id)
  	account = Account.find(account_id)
  	account_name = account.bank
  	account_name
  end
end
