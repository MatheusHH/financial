class ChartsController < ApplicationController
  before_action :authenticate_user!

  def index
  	if params[:date_expense].present?
  	  initial_date = formatted_date(params[:date_expense])
  	  final_date = formatted_date(params[:date_expense])
  	  @expenses = policy_scope(Expense).includes(:category).references(:categories).where(
  	  	created_at: initial_date.beginning_of_month..final_date.end_of_month)
  	else
      date = Date.current
  	  @expenses = policy_scope(Expense).includes(:category).references(:categories).where(
        created_at: date.beginning_of_month..date.end_of_month)
  	end
  	if params[:date_income].present?
  	  initial_date = formatted_date(params[:date_income])
  	  final_date = formatted_date(params[:date_income])
  	  @incomes = policy_scope(Income).includes(:kind).references(:kinds).where(
  	  	created_at: initial_date.beginning_of_month..final_date.end_of_month)
  	else
      date = Date.current
  	  @incomes = policy_scope(Income).includes(:kind).references(:kinds).where(
        created_at: date.beginning_of_month..date.end_of_month)
  	end
  	@expenses_total = policy_scope(Expense).all
  	@incomes_total = policy_scope(Income).all
  end

  private

  def formatted_date(date)
  	new_date = Date.new date["(1i)"].to_i, date["(2i)"].to_i, date["(3i)"].to_i
  	new_date 
  end
end


#if params[:date_expense].present?
#  	  initial_date = params[:date_expense].to_date.beginning_of_month
#  	  final_date = params[:date_expense].to_date.end_of_month
#  	  @expenses = policy_scope(Expense).joins(:category).references(:categories).where(
#  	  	created_at: initial_date..final_date)
#  	else
#  	  @expenses = policy_scope(Expense).joins(:category).references(:categories)
#  	end
