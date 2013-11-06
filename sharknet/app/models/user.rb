class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :timesheets

  def self.create_timesheets
    User.all.each do |user|
      @timesheet = Timesheet.new
      @timesheet.user_id = user.id
         
      @timesheet.status = "OPEN"
      @timesheet.period = Date.today

      @timesheet.save
                        
    end 
  end
end
