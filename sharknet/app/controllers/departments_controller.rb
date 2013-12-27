class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :user, :parent => false  

  # GET /departments
  # GET /departments.json
  def index
    @division_id = params[ :my_department ][ :division_id].to_i
    @departments = Department.where( division_id: @division_id )
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
  end

  # GET /departments/new
  def new
    @department = Department.new
	  @department.division_id = params[ :my_department ][ :division_id].to_i
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        @userM = User.find(@department.user.id) 
        @userM.user_job_id = UserJob.where(title: 'SEF DEPARTAMENT').take.id
        @userM.save

        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render action: 'show', status: :created, location: @department }
      else
        format.html { render action: 'new' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        @userM = User.find(@department.user.id) 
        @userM.user_job_id = UserJob.where(title: 'SEF DEPARTAMENT').take.id
        @userM.save
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    div_id =@department.division_id
    @department.destroy
    respond_to do |format|
    #departments_path(:my_department => { :division_id => @department.division_id })
      format.html { redirect_to departments_path(:my_department => { :division_id => div_id})}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:dept_name, :division_id, :user_id)
    end
end
