class Sheetfile < ActiveRecord::Base
	belongs_to :timesheet
	has_meny :activities
end
