class Activity < ActiveRecord::Base
	belongs_to :sheetfiles
  belongs_to :project
end
