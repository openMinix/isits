class MembershipsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication # , :only => :shxow

  load_and_authorize_resource :user, :parent => false, except: [:create ]
  def create
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
       # sign_up(resource_name, resource)

        redirect_to :controller => 'memberships', :action => 'index'
      else
        #set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        #expire_data_after_sign_in!
        #respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        redirect_to :controller => 'memberships', :action => 'index'
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update

    @user = User.find(params[:id])
    account_update_params.delete(:current_password)
    if @user.update_with_password(account_update_params)
        redirect_to :controller => 'memberships', :action => 'index'
    else
      clean_up_passwords resource
      respond_with @user 
    end
  end

  # DELETE /resource
  def destroy
    @user = User.find(params[:id])
    Department.where(:user_id => @user.id).update_all(:user_id => nil )
    Division.where(:user_id => @user.id).update_all(:user_id => nil )
    @user.destroy

    if @user.destroy
      redirect_to :controller => 'memberships', :action => 'index'
    end
  end

  def index
    @users = User.all;
  end
end
