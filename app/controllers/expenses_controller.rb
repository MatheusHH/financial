class ExpensesController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :set_models_to_expense, only: [:edit, :update, :new, :create]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = policy_scope(Expense).all.page(params[:page]).per(5)
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
    authorize @expense
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
    respond_to do |format|
      if @expense.save
        format.html { redirect_to expenses_url, notice: t('flash.actions.create.notice', model: @expense.model_name.human) }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expenses_url, notice: t('flash.actions.update.notice', model: @expense.model_name.human) }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    authorize @expense
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: t('flash.actions.destroy.notice') } 
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def set_models_to_expense
      @category = Category.new
      @supplier = Supplier.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:duedate, :category_id, :supplier_id, :account_id, :status, :value, :user_id)
    end
end
