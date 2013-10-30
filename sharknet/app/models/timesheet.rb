class Timesheet < ActiveRecord::Base
  belongs_to :user
  has_many :sheetfiles
end
