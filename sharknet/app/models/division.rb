class Division < ActiveRecord::Base
	has_many :departments
  belongs_to :user
end
