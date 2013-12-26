class UserJobsController < ApplicationController
  before_action :set_user_job, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /user_jobs
  # GET /user_jobs.json
  def index
    @user_jobs = UserJob.all
  end

  # GET /user_jobs/1
  # GET /user_jobs/1.json
  def show
  end

  # GET /user_jobs/new
  def new
    @user_job = UserJob.new
  end

  # GET /user_jobs/1/edit
  def edit
  end

  # POST /user_jobs
  # POST /user_jobs.json
  def create
    @user_job = UserJob.new(user_job_params)

    respond_to do |format|
      if @user_job.save
        format.html { redirect_to @user_job, notice: 'User job was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_job }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_jobs/1
  # PATCH/PUT /user_jobs/1.json
  def update
    respond_to do |format|
      if @user_job.update(user_job_params)
        format.html { redirect_to @user_job, notice: 'User job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_jobs/1
  # DELETE /user_jobs/1.json
  def destroy
    @user_job.destroy
    respond_to do |format|
      format.html { redirect_to user_jobs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_job
      @user_job = UserJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_job_params
      params.require(:user_job).permit(:title)
    end
end
