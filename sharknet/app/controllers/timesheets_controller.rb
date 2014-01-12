class TimesheetsController < ApplicationController
  before_action :set_timesheet, only: [:show, :edit, :update, :destroy]

  # GET /timesheets
  # GET /timesheets.json
  def index
    @timesheets = current_user.timesheets 
  end

  def departments_index 
    @timesheets = Timesheet.joins(:user).where('users.department_id' => current_user.department_id ).where(status:  'SUBMITTED')
    render 'timesheets/department_index'
  end

  def divisions_index 
    @timesheets = Timesheet.all

    @timesheets.find_all do |timesheet|
      timesheet.user.department.division.id == current_user.department.division.id 
    end

    render 'timesheets/division_index'
  end

  def director_index
    @timesheets = Timesheet.all

    render 'timesheets/director_index'
 
  end



  # GET /timesheets/1
  # GET /timesheets/1.json
  def show
  end

  # GET /timesheets/new
  def new
    @timesheet = Timesheet.new
  end

  # GET /timesheets/1/edit
  def edit
  end

  # POST /timesheets
  # POST /timesheets.json
  def create
    @timesheet = Timesheet.new(timesheet_params)
    @timesheet.user_id = current_user.id

    respond_to do |format|
      if @timesheet.save
        #For testing sending mail UserMailer.info_email(current_user).deliver
        format.html { redirect_to @timesheet, notice: 'Timesheet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @timesheet }
      else
        format.html { render action: 'new' }
        format.json { render json: @timesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timesheets/1
  # PATCH/PUT /timesheets/1.json
  def update
    respond_to do |format|
      if @timesheet.update(timesheet_params)
          if @timesheet.user.user_job.title != 'ANGAJAT' and @timesheet.user.user_job.title != 'ADMINISTRATOR'
              @timesheet.status  = 'APPROVED'
              @timesheet.save
          end

          if ( @timesheet.status == 'REJECTED' )
            UserMailer.rejected_email(@timesheet.user).deliver
          end

          if ( @timesheet.status == 'SUBMITTED' )
            UserMailer.notify_email(@timesheet.user.department.user).deliver
          end

        format.html { redirect_to @timesheet, notice: 'Timesheet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timesheets/1
  # DELETE /timesheets/1.json
  def destroy
    @timesheet.destroy
    respond_to do |format|
      format.html { redirect_to :back}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timesheet
      @timesheet = Timesheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timesheet_params
      params.require(:timesheet).permit(:status, :period)
    end
end
