class SourcesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_source, only: [:show, :edit, :update, :destroy]

  # GET /sources
  # GET /sources.json
  def index
    @sources = policy_scope(Source).all
  end

  # GET /sources/1
  # GET /sources/1.json
  def show
  end

  # GET /sources/new
  def new
    @source = Source.new
  end

  # GET /sources/1/edit
  def edit
    authorize @source
  end

  # POST /sources
  # POST /sources.json
  def create
    @source = Source.new(source_params)
    @source.user = current_user
    respond_to do |format|
      if @source.save
        format.html { redirect_to sources_url, notice: t('flash.actions.create.notice', model: @source.model_name.human) }
        format.json { render :show, status: :created, location: @source }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @source.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PATCH/PUT /sources/1
  # PATCH/PUT /sources/1.json
  def update
    respond_to do |format|
      if @source.update(source_params)
        format.html { redirect_to sources_url, notice: t('flash.actions.update.notice', model: @source.model_name.human) }
        format.json { render :show, status: :ok, location: @source }
      else
        format.html { render :edit }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    authorize @source
    @source.destroy
    respond_to do |format|
      format.html { redirect_to sources_url, notice: t('flash.actions.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source
      @source = Source.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_params
      params.require(:source).permit(:name, :phone, :user_id)
    end
end
