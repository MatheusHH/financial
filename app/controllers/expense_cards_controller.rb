class ExpenseCardsController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_expense_card, only: [:show, :edit, :update, :destroy]

  # GET /expense_cards
  # GET /expense_cards.json
  def index
    @expense_cards = policy_scope(ExpenseCard).all.page(params[:page]).per(5)
  end

  # GET /expense_cards/1
  # GET /expense_cards/1.json
  def show
  end

  # GET /expense_cards/new
  def new
    @expense_card = ExpenseCard.new
  end

  # GET /expense_cards/1/edit
  def edit
    authorize @expense_card
  end

  # POST /expense_cards
  # POST /expense_cards.json
  def create
    @expense_card = ExpenseCard.new(expense_card_params)
    @expense_card.user = current_user
    respond_to do |format|
      if @expense_card.save
        format.html { redirect_to expense_cards_url, notice: t('flash.actions.create.notice', model: @expense_card.model_name.human) }
        format.json { render :show, status: :created, location: @expense_card }
      else
        format.html { render :new }
        format.json { render json: @expense_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expense_cards/1
  # PATCH/PUT /expense_cards/1.json
  def update
    respond_to do |format|
      if @expense_card.update(expense_card_params)
        format.html { redirect_to expense_cards_url, notice: t('flash.actions.update.notice', model: @expense_card.model_name.human) }
        format.json { render :show, status: :ok, location: @expense_card }
      else
        format.html { render :edit }
        format.json { render json: @expense_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_cards/1
  # DELETE /expense_cards/1.json
  def destroy
    authorize @expense_card
    @expense_card.destroy
    respond_to do |format|
      format.html { redirect_to expense_cards_url, notice: t('flash.actions.destroy.notice') } 
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_card
      @expense_card = ExpenseCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_card_params
      params.require(:expense_card).permit(:invoice_date, :value, :status, :card_id, :user_id)
    end
end
