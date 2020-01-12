class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@accounts = policy_scope(Account).all
  	@expenses_open = policy_scope(Expense).where(status: :pendente).sum(:value_cents)
  	@expenses_paid = policy_scope(Expense).where(status: :pago).sum(:value_cents)
  	@cards = policy_scope(Card).all
  end
end
