class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def is_admin
  	if user_signed_in?
	  	if current_user.role == 'admin'
	  		@admin = current_user
	  	else
	  		respond_to do |format|
	  			format.html { redirect_to versions_path, notice: 'You are not admin!.' }
	  		end
	  	end
	else
		redirect_to admin_signin_path, notice: 'Please signin first!.' 
	end
  end
end
