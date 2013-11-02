class SheetfilesController < ApplicationController
  before_action :set_sheetfile, only: [:show, :edit, :update, :destroy]

  # GET /sheetfiles
  # GET /sheetfiles.json
  def index
    @timesheet_id = params[ :my_sheetfile ][ :timesheet_id].to_i
    @sheetfiles = Sheetfile.where( timesheet_id: @timesheet_id )
  end

  # GET /sheetfiles/1
  # GET /sheetfiles/1.json
  def show
  end

  # GET /sheetfiles/new
  def new
    @sheetfile = Sheetfile.new 
    @sheetfile.timesheet_id = params[ :my_sheetfile ][ :timesheet_id].to_i
  end

  # GET /sheetfiles/1/edit
  def edit
  end

  # POST /sheetfiles
  # POST /sheetfiles.json
  def create
    @sheetfile = Sheetfile.new(sheetfile_params)

    respond_to do |format|
      if @sheetfile.save
        format.html { redirect_to @sheetfile, notice: 'Sheetfile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sheetfile }
      else
        format.html { render action: 'new' }
        format.json { render json: @sheetfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sheetfiles/1
  # PATCH/PUT /sheetfiles/1.json
  def update
    respond_to do |format|
      if @sheetfile.update(sheetfile_params)
        format.html { redirect_to @sheetfile, notice: 'Sheetfile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sheetfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sheetfiles/1
  # DELETE /sheetfiles/1.json
  def destroy
    @sheetfile.destroy
    respond_to do |format|
      format.html { redirect_to sheetfiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sheetfile
      @sheetfile = Sheetfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sheetfile_params
      params.require(:sheetfile).permit(:day, :timesheet_id)
    end
end
