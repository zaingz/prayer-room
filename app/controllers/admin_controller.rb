class AdminController < ApplicationController
	before_action :is_admin
	before_action :set_user, only: [:user_ban , :user_del , :user_edit , :user_update]
	before_action :set_room, only: [:approve_room ,:reject_room]

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

	def rooms
		@room = Room.pending
	end

	def approve_room
		if @room.status != 'approved'
			@room.status = 1
			respond_to do |format|
				if @room.save
					format.html{ redirect_to admin_rooms_path , notice: "Room was successfully approved" }
					format.json { render :room, status: :ok }
				else
					format.html { redirect_to admin_rooms_path , notice: "Failed to approve room" }
		        	format.json { render json: @room.errors, status: :unprocessable_entity }
				end
			end
		else
			redirect_to admin_rooms_path , notice: "Room was already approved"
		end
	end

	def reject_room
		if @room.status != 'rejected'
			@room.status = 2
			respond_to do |format|
				if @room.save
					format.html{ redirect_to :back , notice: "Room was successfully rejected" }
					format.json { render :room, status: :ok }
				else
					format.html { redirect_to :back , notice: "Failed to approve room" }
		        	format.json { render json: @room.errors, status: :unprocessable_entity }
				end
			end
		else
			redirect_to :back , notice: "Room was already rejected"
		end
	end

	def room_entries
		@room = Room.approve_reject
	end

	def reports
		@room = Room.approve_reject
		@rooms = Room.all
	end

	private
	def set_user
		@user = User.find(params[:id])
	end
	def user_params
		params.require(:user).permit(:status, :username, :role , :ban)
	end
	def set_room
		@room = Room.find(params[:id])
	end
end