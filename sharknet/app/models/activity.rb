class Activity < ActiveRecord::Base
	belongs_to :sheetfile
  belongs_to :project
end
