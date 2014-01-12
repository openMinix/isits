class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index

    @sheetfile_id = params[ :my_activity ][ :sheetfile_id].to_i
    @activities = Activity.where( sheetfile_id: @sheetfile_id )
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    @activity.sheetfile_id = params[ :my_activity ][ :sheetfile_id].to_i
  end

  # GET /activities/1/edit
  def edit
  end


#reports for department head
  def departments_search
      render 'activities/departments/departments_search'
  end

  def departments_project_search
      render 'activities/departments/departments_project_search'
  end

  def departments_period_search
      render 'activities/departments/departments_period_search'
  end


  def departments_result

      date_created_start = Date.civil(params[:created_at][:year].to_i, params[:created_at][:month].to_i, params[:created_at][:day].to_i)

      date_created_end = Date.civil(params[:created_at_end][:year].to_i, params[:created_at_end][:month].to_i, params[:created_at_end][:day].to_i)

      @user_activities = Activity.joins(:sheetfile=> [{:timesheet=> :user}])
      .where('users.id'=> params[:id]).where('activities.created_at' => date_created_start.midnight..(date_created_end.midnight + 1.day) )
      .select('sum(activities.work_hours) as hoursw, sum( CASE activities.extra WHEN "true" THEN activities.work_hours ELSE 0 END) as extrah , activities.project_id ').group('activities.project_id')

      @total_hours= Activity.joins(:sheetfile=> [{:timesheet=> :user}])
      .where('users.id'=> params[:id]).where('activities.created_at' => date_created_start.midnight..(date_created_end.midnight + 1.day) )
      .select('sum(activities.work_hours) as totalh' ).take.totalh


      render 'activities/departments/departments_reports'
  end


  def departments_project_result
	date_created_start = Date.civil(params[:created_at][:year].to_i, params[:created_at][:month].to_i, params[:created_at][:day].to_i)

    date_created_end = Date.civil(params[:created_at_end][:year].to_i, params[:created_at_end][:month].to_i, params[:created_at_end][:day].to_i)

	@project_idd = Project.select('id').where('project_name' => params[:project_name])
	
    @user_activities = Activity.joins(:sheetfile=> [{:timesheet=> :user}])
    .where('activities.project_id'=> @project_idd).where('activities.created_at' => date_created_start.midnight..(date_created_end.midnight + 1.day) )
    .select('sum(activities.work_hours) as hoursw,  (CASE activities.extra WHEN "true" THEN activities.work_hours ELSE 0 END) as extrah , activities.project_id, users.user_fullname ').group("users.user_fullname")

    
    render 'activities/departments/departments_project_reports'
  end

  def departments_period_result
	date_created_start = Date.civil(params[:created_at][:year].to_i, params[:created_at][:month].to_i, params[:created_at][:day].to_i)

    date_created_end = Date.civil(params[:created_at_end][:year].to_i, params[:created_at_end][:month].to_i, params[:created_at_end][:day].to_i)
	
   @user_activities= Activity.joins('LEFT OUTER JOIN projects on projects.id = activities.project_id')
   .where('activities.created_at' => date_created_start.midnight..(date_created_end.midnight + 1.day) )
   .select('IFNULL(sum(activities.work_hours),0) as hoursw, projects.project_name' ).group('projects.project_name')


    render 'activities/departments/departments_period_reports'
  end
  
   def pdf_dept_users
	@tmp = params[:par]
	render 'activities/pdf_dept_users'
  end
  
  def pdf_dept_projects
	@tmp = params[:par]
	render 'activities/pdf_dept_projects'
  end
  
  def pdf_dept_periods
	@tmp = params[:par]
	render 'activities/pdf_dept_periods'
  end

#reports for division head
  def divisions_users_search
      render 'activities/divisions/division_users_search'
  end

  def divisions_projects_search
      render 'activities/divisions/division_projects_search'
  end

  def divisions_users_result
	@dept_idd = Department.select('id').where('id' => params[:user][:department_id])
    @users = User.select('user_fullname as uf').where('department_id' => @dept_idd) 
	
    render 'activities/divisions/divisions_users_reports'
  end
  
  def pdf_div_users
	@tmp = params[:par]
	render 'activities/pdf_div_users'
  end
  
  def pdf_div_projects
	@tmp = params[:par]
	
	render 'activities/pdf_div_projects'
  end

  
  def divisions_projects_result

	  date_created_start = Date.civil(params[:created_at][:year].to_i, params[:created_at][:month].to_i, params[:created_at][:day].to_i)
    date_created_end = Date.civil(params[:created_at_end][:year].to_i, params[:created_at_end][:month].to_i, params[:created_at_end][:day].to_i)
	
	  @my_div_id = current_user.department.division.id
	  
    @departments = current_user.department.division.departments


	  @user_activities = Activity.joins(:sheetfile=> [{:timesheet=> :user}])
    .where('activities.created_at' => date_created_start.midnight..(date_created_end.midnight + 1.day) )
    .where('users.department_id' => current_user.department.division.departments.map{ |x| x.id } )
    .select('sum(activities.work_hours) as hoursw, users.department_id,activities.project_id ').group('activities.project_id').group('users.department_id')
    

	  render 'activities/divisions/divisions_projects_reports'
  end

#reports for director

  def director_users_search
      render 'activities/director/director_users_search'
  end

  def director_projects_search
      render 'activities/director/director_projects_search'
  end

  def director_clients_search
      render 'activities/director/director_clients_search'
  end

  def director_users_result
    @dept_idd = Department.select('id').where('id' => params[:user][:department_id])
    @dept_name = Department.select('dept_name').where('id' => params[:user][:department_id])
    @users = User.select('user_fullname as uf').where('department_id' => @dept_idd) 

    render 'activities/director/director_users_reports'
  end
  
   def pdf_director_users
	@tmp = params[:par]
	render 'activities/pdf_director_users'
  end
  
  def pdf_director_projects
	@tmp = params[:par]
	
	render 'activities/pdf_director_projects'
  end
  
  def pdf_director_clients
	@tmp = params[:par]
	
	render 'activities/pdf_director_clients'
  end

  def director_projects_result
	  date_created_start = Date.civil(params[:created_at][:year].to_i, params[:created_at][:month].to_i, params[:created_at][:day].to_i)
    date_created_end = Date.civil(params[:created_at_end][:year].to_i, params[:created_at_end][:month].to_i, params[:created_at_end][:day].to_i)
	
	  
	  @user_activities = Activity.joins(:sheetfile=> [{:timesheet=> :user}])
    .where('activities.created_at' => date_created_start.midnight..(date_created_end.midnight + 1.day) )
    .select('sum(activities.work_hours) as hoursw, users.department_id,activities.project_id ').group('activities.project_id').group('users.department_id')
    

	  render 'activities/director/director_projects_reports'
 
  end

  def director_clients_result

	  date_created_start = Date.civil(params[:created_at][:year].to_i, params[:created_at][:month].to_i, params[:created_at][:day].to_i)
    date_created_end = Date.civil(params[:created_at_end][:year].to_i, params[:created_at_end][:month].to_i, params[:created_at_end][:day].to_i)

    @activities=  Activity
                .where('activities.created_at' => date_created_start.midnight..(date_created_end.midnight + 1.day) )
                .select('sum(activities.work_hours) as hoursw, activities.project_id')
                .group('activities.project_id')

    render 'activities/director/director_clients_reports'
  end



  


#end of reports

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity }
      else
        format.html { render action: 'new' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to :back}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:type_activity, :description, :work_hours, :extra, :sheetfile_id, :project_id)
    end
end
