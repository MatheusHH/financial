class IncomesController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_income, only: [:show, :edit, :update, :destroy]
  before_action :set_models_to_income, only: [:edit, :update, :new, :create]

  # GET /incomes
  # GET /incomes.json
  def index
    @incomes = policy_scope(Income).all.page(params[:page]).per(5)
  end

  # GET /incomes/1
  # GET /incomes/1.json
  def show
  end

  # GET /incomes/new
  def new
    @income = Income.new
  end

  # GET /incomes/1/edit
  def edit
    authorize @income
  end

  # POST /incomes
  # POST /incomes.json
  def create
    @income = Income.new(income_params)
    @income.user = current_user
    respond_to do |format|
      if @income.save
        format.html { redirect_to incomes_url, notice: t('flash.actions.create.notice', model: @income.model_name.human) }
        format.json { render :show, status: :created, location: @income }
      else
        format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incomes/1
  # PATCH/PUT /incomes/1.json
  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to incomes_url, notice: t('flash.actions.update.notice', model: @income.model_name.human) }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1
  # DELETE /incomes/1.json
  def destroy
    authorize @income
    @income.destroy
    respond_to do |format|
      format.html { redirect_to incomes_url, notice: t('flash.actions.destroy.notice') } 
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income
      @income = Income.find(params[:id])
    end

    def set_models_to_income
      @source = Source.new
      @kind = Kind.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def income_params
      params.require(:income).permit(:receipt_date, :account_id, :kind_id, :source_id, :value, :user_id)
    end
end
