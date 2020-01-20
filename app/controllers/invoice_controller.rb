class InvoiceController < ApplicationController
  before_action :authenticate_user!
  before_action :load_cards, only: [:index]

  def index
  	if params[:date].present? && params[:card_id].present?
  	  card = Card.find(params[:card_id])
  	  end_date = params[:date].to_date - 1.day
      initial_date = end_date - 30.days
  	  @expense_cards = ExpenseCard.joins(:card).where(user_id: current_user).where(
  	  	"expense_cards.invoice_date between ? and ?", initial_date, end_date)
  	end 
  end

  private

  def load_cards
  	@cards = policy_scope(Card).all
  end
end
