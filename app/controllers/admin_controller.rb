class AdminController < ApplicationController
	before_action :is_admin
	before_action :set_user, only: [:user_ban , :user_del , :user_edit , :user_update]

	def user
		@user = User.all
	end

	def user_ban
		if(@user.ban==false)
			@user.ban = true
			if @user.save
				redirect_to users_path, notice: 'User was successfully banned.'
			else
				redirect_to users_path, notice: 'User was successfully banned.'
			end
		else
			redirect_to users_path, notice: 'User was already banned.'
		end
	end

	def user_del
		redirect_to users_path, notice: 'User was successfully deleted.'
	end

	def user_edit
	end

	def user_update
		p params.inspect
		respond_to do |format|
	      if @user.update(user_params)
	        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
	        format.json { render :user, status: :ok, location: @user }
	      else
	        format.html { render :user_edit }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
	    end
	end

	private
	def set_user
		@user = User.find(params[:id])
	end
	def user_params
		params.require(:user).permit(:status, :username, :role , :ban)
	end
end
