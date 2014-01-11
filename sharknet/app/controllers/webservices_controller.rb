class WebservicesController < ApplicationController
  def showwork

    start_time = Date.civil(params[:start][:year].to_i, params[:start][:month].to_i, params[:start][:day].to_i)
    end_time = Date.civil(params[:end][:year].to_i, params[:end][:month].to_i, params[:end][:day].to_i)

    normal_hours= Activity.joins(:sheetfile=> [{:timesheet=> :user}])
          .where('users.id'=> params[:id])
          .where('activities.extra' => false )
          .where('activities.created_at' => start_time.midnight..(end_time.midnight + 1.day) )
          .select('sum(activities.work_hours) as totalh' ).take.totalh

   
   extra_hours = Activity.joins(:sheetfile=> [{:timesheet=> :user}])
          .where('users.id'=> params[:id])
          .where('activities.extra' => true)
          .where('activities.created_at' => start_time.midnight..(end_time.midnight + 1.day) )
          .select('sum(activities.work_hours) as totalh' ).take.totalh

  if normal_hours == nil
     normal_hours = 0  
  end
  if extra_hours == nil
      extra_hours = 0
  end
      resp = { :normal_hours => normal_hours,

               :extra_hours => extra_hours 
      }

      respond_to do |format|
          format.html
          format.json  { render :json => resp } # don't do msg.to_json
      end
  end

  def showvacation
  end

end
