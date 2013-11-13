class MembershipsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication # , :only => :shxow

  load_and_authorize_resource :user, :parent => false, except: [:create]
  def create
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
       # sign_up(resource_name, resource)

        redirect_to :controller => 'timesheets', :action => 'index'
      else
        #set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        #expire_data_after_sign_in!
        #respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        redirect_to :controller => 'timesheets', :action => 'index'
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def index

    @users = User.all;
  end
end
