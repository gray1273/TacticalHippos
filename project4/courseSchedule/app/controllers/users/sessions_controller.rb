# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    puts "Running!"
    user = User.find_by( email: params[:user][:email] )
    if user and user.user_type.title == "Instructor" then    
      # instances = Instructor.where( :first_name => user.first_name, :last_name => user.last_name )
      # instances.each
      instructor = Instructor.find_by( :first_name => user.first_name, :last_name => user.last_name )
      instructor.instructor_id = user.id
      instructor.save
    end
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
