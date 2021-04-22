# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    puts "New!"
    super
  end

  # POST /resource
  def create
    puts "Running 3"
    puts params
    params[:user][:user_type_id] = UserType.find_or_create_by(title: params[:user][:user_type]).id
    params[:user][:user_type] = nil
    puts params
    super
#    user_params = params[:user]
#    @user = User.new(
#        :first_name => user_params[:first_name],
#        :last_name => user_params[:last_name],
#        :email => user_params[:email], 
#        :encrypted_password => user_params[:password],
#        :user_type => UserType.find_or_create_by(title: params[:user_type])
#    )
#    if @user.save
#      redirect_to @user
#    else
#      render :new
#    end
  end

  # GET /resource/edit
  def edit
    puts "Edit!"
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params

    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      puts "permitting"
      user_params.permit(:first_name, :last_name, :user_type_id, :email, :password, :password_confirmation)
    end
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_type])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
