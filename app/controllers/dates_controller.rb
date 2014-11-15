class DatesController < ApplicationController
  before_action :set_date, only: [:show, :edit, :update, :destroy]

  # GET /dates
  # GET /dates.json
  def index

	@client = Client.find(params[:client_id])
	if params[:start_date].nil?
		@preset_start_date = Date.today
	else
		@preset_start_date = Date.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i)
		date_from = Date.new(params[:start_date][:year].to_i, params[:start_date][:month].to_i, 1)
		date_to = Date.new(params[:start_date][:year].to_i, params[:start_date][:month].to_i, -1) # -1 is for getting the last day of month
		dates = @client.dates(date_from.strftime("%Y-%m-%d"), date_to.strftime("%Y-%m-%d"))
		@dates = dates[:entries]
		@total_ammount = dates[:total_ammount]
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
