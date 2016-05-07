class AdminController < ApplicationController
	before_action :is_admin
	before_action :set_user, only: [:user_ban , :user_del , :user_edit , :user_update]
	before_action :set_room_version, only: [:approve_room ,:reject_room]
	layout "admin"

	def user
		p "User "+params.inspect
		if params[:format].present?
			user = eval(params[:format])
			if user.count>0
				user.each do |a|
					@user = User.where(:id => user)
				end
			else
				@user = []
			end
		else
			@user = User.all
		end
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

	def rooms
		p "Params Pending " + params.inspect
		if params[:format].present?
			room = eval(params[:format])
			if room.count>0
				room.each do |a|
					@version = Version.where(:id => room)
				end
			else
				@version = []
			end
		else
			@version = Version.pending
		end
	end

	def approve_room
		if @version.status != 'approved'
			@version.status = 1
			respond_to do |format|
				if @version.save
					format.html{ redirect_to admin_rooms_path , notice: "Room was successfully approved" }
					format.json { render :version, status: :ok }
				else
					format.html { redirect_to admin_rooms_path , notice: "Failed to approve room" }
		        	format.json { render json: @version.errors, status: :unprocessable_entity }
				end
			end
		else
			redirect_to admin_rooms_path , notice: "Room was already approved"
		end
	end

	def reject_room
		if @version.status != 'rejected'
			@version.status = 2
			respond_to do |format|
				if @version.save
					format.html{ redirect_to :back , notice: "Room was successfully rejected" }
					format.json { render :version, status: :ok }
				else
					format.html { redirect_to :back , notice: "Failed to approve room" }
		        	format.json { render json: @version.errors, status: :unprocessable_entity }
				end
			end
		else
			redirect_to :back , notice: "Room was already rejected"
		end
	end

	def room_entries
		p "My Paraams " + params.inspect
		if params[:format].present?
			version = eval(params[:format])
			if version.count>0
				version.each do |a|
					@version = Version.where(:id => version)
				end
			else
				@version = []
			end
		else
			@version= Version.all
		end
	end

	def reports
		@version = Version.pending
		@versions = Version.where(typ: 1)
	end

	private
	def set_user
		@user = User.find(params[:id])
	end
	def user_params
		params.require(:user).permit(:status, :username, :role , :ban)
	end
	def set_room_version
		@version = Version.find(params[:id])
	end
end