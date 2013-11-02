class Sheetfile < ActiveRecord::Base
	belongs_to :timesheet
	has_many :activities
end
