class PaymentCardsController < ApplicationController
  before_action :set_payment_card, only: [:show, :edit, :update, :destroy]

  # GET /payment_cards
  # GET /payment_cards.json
  def index
    @payment_cards = policy_scope(PaymentCard).all
  end

  # GET /payment_cards/1
  # GET /payment_cards/1.json
  def show
  end

  # GET /payment_cards/new
  def new
    @payment_card = PaymentCard.new
  end

  # GET /payment_cards/1/edit
  def edit
    authorize @payment_card
  end

  # POST /payment_cards
  # POST /payment_cards.json
  def create
    @payment_card = PaymentCard.new(payment_card_params)
    @payment_card.user = current_user
    respond_to do |format|
      if @payment_card.save
        format.html { redirect_to payment_cards_url, notice: 'Payment card was successfully created.' }
        format.json { render :show, status: :created, location: @payment_card }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @payment_card.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PATCH/PUT /payment_cards/1
  # PATCH/PUT /payment_cards/1.json
  def update
    respond_to do |format|
      if @payment_card.update(payment_card_params)
        format.html { redirect_to payment_cards_url, notice: 'Payment card was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_card }
      else
        format.html { render :edit }
        format.json { render json: @payment_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_cards/1
  # DELETE /payment_cards/1.json
  def destroy
    authorize @payment_card
    @payment_card.destroy
    respond_to do |format|
      format.html { redirect_to payment_cards_url, notice: 'Payment card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_card
      @payment_card = PaymentCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_card_params
      params.require(:payment_card).permit(:invoice_payment_date, :value, :card_id, :account_id, :user_id)
    end
end
