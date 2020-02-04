class CardsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :load_expenses_card_current_month, only: [:show]

  # GET /cards
  # GET /cards.json
  def index
    @cards = policy_scope(Card).all.page(params[:page]).per(5)
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    authorize @card
    @card = Card.find(params[:id])
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
    authorize @card
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)
    @card.user = current_user
    respond_to do |format|
      if @card.save
        format.html { redirect_to cards_url, notice: t('flash.actions.create.notice', model: @card.model_name.human) }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to cards_url, notice: t('flash.actions.update.notice', model: @card.model_name.human) }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    authorize @card
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: t('flash.actions.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    def load_expenses_card_current_month
      end_date = (Date.current.beginning_of_month + @card.closing_day.days) - 2.days
      initial_date = (end_date - 1.month)
      @card_expenses = ExpenseCard.joins(:card).where(user_id: current_user).where("expense_cards.invoice_date between ? and ?", initial_date, end_date) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:card_name, :closing_day, :invoice_day, :limit_value, :balance_card, :user_id)
    end
end
