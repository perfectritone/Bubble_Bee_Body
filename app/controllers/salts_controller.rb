class SaltsController < ApplicationController
  before_action :set_salt, only: [:show, :edit, :update, :destroy]

  # GET /salts
  # GET /salts.json
  def index
    @salts = Salt.all
  end

  # GET /salts/1
  # GET /salts/1.json
  def show
  end

  # GET /salts/new
  def new
    @salt = Salt.new
  end

  # GET /salts/1/edit
  def edit
  end

  # POST /salts
  # POST /salts.json
  def create
    @salt = Salt.new(salt_params)

    respond_to do |format|
      if @salt.save
        format.html { redirect_to @salt, notice: 'Salt was successfully created.' }
        format.json { render action: 'show', status: :created, location: @salt }
      else
        format.html { render action: 'new' }
        format.json { render json: @salt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salts/1
  # PATCH/PUT /salts/1.json
  def update
    respond_to do |format|
      if @salt.update(salt_params)
        format.html { redirect_to @salt, notice: 'Salt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @salt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salts/1
  # DELETE /salts/1.json
  def destroy
    @salt.destroy
    respond_to do |format|
      format.html { redirect_to salts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salt
      @salt = Salt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def salt_params
      params.require(:salt).permit(:name, :description)
    end
end
