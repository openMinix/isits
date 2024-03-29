class DivisionsController < ApplicationController
  before_action :set_division, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :user, :parent => false, :only =>[:index]

  # GET /divisions
  # GET /divisions.json
  def index
    @divisions = Division.all
  end

  # GET /divisions/1
  # GET /divisions/1.json
  def show
  end

  # GET /divisions/new
  def new
    @division = Division.new
  end

  # GET /divisions/1/edit
  def edit
  end

  # POST /divisions
  # POST /divisions.json
  def create
    @division = Division.new(division_params)
	
    respond_to do |format|
      if @division.save
        @userM = User.find(@division.user.id) 
        @userM.user_job_id = UserJob.where(title: 'SEF DIVIZIE').take.id
        @userM.save

        format.html { redirect_to @division, notice: 'Division was successfully created.' }
        format.json { render action: 'show', status: :created, location: @division }
      else
        format.html { render action: 'new' }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /divisions/1
  # PATCH/PUT /divisions/1.json
  def update

   if @division.user != nil
        @division.user.update("user_job_id"=> 1 )
   end

    respond_to do |format|
      if @division.update(division_params)
        @userM = User.find(@division.user.id) 
        @userM.user_job_id = UserJob.where(title: 'SEF DIVIZIE').take.id
        @userM.save

        format.html { redirect_to @division, notice: 'Division was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /divisions/1
  # DELETE /divisions/1.json
  def destroy
    @division.departments.each do | department |
      department.destroy
    end

    @division.destroy
    respond_to do |format|
      format.html { redirect_to :back}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_division
      @division = Division.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def division_params
      params.require(:division).permit(:div_name, :user_id)
    end
end
