class ChartsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@expenses = policy_scope(Expense).joins(:category).references(:categories)
  	@incomes = policy_scope(Income).joins(:kind).references(:kinds)
  	@expenses_total = policy_scope(Expense).all
  	@incomes_total = policy_scope(Income).all
  end
end
