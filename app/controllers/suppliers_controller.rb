class SuppliersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  # GET /suppliers
  # GET /suppliers.json
  def index
    @suppliers = policy_scope(Supplier).all.page(params[:page]).per(5)
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
  end

  # GET /suppliers/new
  def new
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
    authorize @supplier
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)
    @supplier.user = current_user
    respond_to do |format|
      if @supplier.save
        format.html { redirect_to suppliers_url, notice: t('flash.actions.create.notice', model: @supplier.model_name.human) }
        format.json { render :show, status: :created, location: @supplier }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to suppliers_url, notice: t('flash.actions.update.notice', model: @supplier.model_name.human) }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    authorize @supplier
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: t('flash.actions.destroy.notice') } 
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params.require(:supplier).permit(:name, :phone, :user_id)
    end
end
