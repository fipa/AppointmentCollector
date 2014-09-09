class DatesController < ApplicationController
  before_action :set_date, only: [:show, :edit, :update, :destroy]

  # GET /dates
  # GET /dates.json
  def index
    client_id = params[:tenant_id]
    client_id = params[:patient_id] if client_id.nil?


    unless (session[:user_id].nil?)
    #TODO que hacer cuando user_id es nil?
        @client = User.find(session[:user_id]).clients.find(client_id)
        @dates = Array.new

        if params[:start_date].nil?
            @preset_start_date = Date.today
            @preset_end_date = Date.today
        else
            @preset_start_date = Date.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i)
            @preset_end_date = Date.civil(params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i)
            date_from = params[:start_date][:year] + "-" + params[:start_date][:month] + "-" + params[:start_date][:day]
            date_to = params[:end_date][:year] + "-" + params[:end_date][:month] + "-" + params[:end_date][:day]
            @dates = @client.dates(date_from, date_to)
        end

        
	end
    

  end

  # GET /dates/1
  # GET /dates/1.json
  def show
  end

  # GET /dates/new
  def new
    @date = Date.new
  end

  # GET /dates/1/edit
  def edit
  end

  # POST /dates
  # POST /dates.json
  def create
    @date = Date.new(date_params)

    respond_to do |format|
      if @date.save
        format.html { redirect_to @date, notice: 'Date was successfully created.' }
        format.json { render :show, status: :created, location: @date }
      else
        format.html { render :new }
        format.json { render json: @date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dates/1
  # PATCH/PUT /dates/1.json
  def update
    respond_to do |format|
      if @date.update(date_params)
        format.html { redirect_to @date, notice: 'Date was successfully updated.' }
        format.json { render :show, status: :ok, location: @date }
      else
        format.html { render :edit }
        format.json { render json: @date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dates/1
  # DELETE /dates/1.json
  def destroy
    @date.destroy
    respond_to do |format|
      format.html { redirect_to dates_url, notice: 'Date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date
      @date = Date.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def date_params
      params.require(:date).permit(:full_name, :email, :ammount, :comments)
    end

end
