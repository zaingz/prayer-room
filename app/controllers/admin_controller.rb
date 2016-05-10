class AdminController < ApplicationController
	before_action :is_admin , except: [:admin_signin]
	before_action :set_user, only: [:user_ban , :user_del , :user_edit , :user_update]
	before_action :set_room_version, only: [:approve_room ,:reject_room]
	layout "admin"

	def admin_signin
		if user_signed_in?
			if current_user.role == 'admin'
				redirect_to admin_room_entries_path
			else
				redirect_to root_path
			end
		end
	end

	def user
		p "User "+params.inspect
		if params[:format].present?
			user = eval(params[:format])
			if user.count>0
				user.each do |a|
					@user = User.where(:id => user).paginate(:page => params[:page], :per_page => 9)
				end
			else
				@user = User.where(:id => 0).paginate(:page => params[:page], :per_page => 9)
			end
		else
			@user = User.all.paginate(:page => params[:page], :per_page => 9)
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
					@version = Version.where(:id => room).paginate(:page => params[:page], :per_page => 9)
				end
			else
				@version = Version.where(:id => 0).paginate(:page => params[:page], :per_page => 9)
			end
		else
			@version = Version.pending.paginate(:page => params[:page], :per_page => 9)
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
					@version = Version.where(:id => version).paginate(:page => params[:page], :per_page => 9)
				end
			else
				@version = Version.where(:id => 0).paginate(:page => params[:page], :per_page => 9)
			end
		else
			@version= Version.all.paginate(:page => params[:page], :per_page => 9)
		end
	end

	def reports
		@version = Version.pending.better.paginate(:page => params[:page], :per_page => 2)
		@versions = Version.better.approve.where(typ: 1).paginate(:page => params[:page], :per_page => 2)
	end

	def preapproval
		p "My Paraams " + params.inspect
		if params[:format].present?
			version = eval(params[:format])
			if version.count>0
				version.each do |a|
					@version = Version.pending.better.where(:id => version).paginate(:page => params[:page], :per_page => 9)
				end
			else
				@version = Version.where(:id => 0).paginate(:page => params[:page], :per_page => 9)
			end
		else
			@version= Version.pending.better.paginate(:page => params[:page], :per_page => 9)
		end
	end

	def better_version
		p "My Paraams " + params.inspect
		if params[:format].present?
			version = eval(params[:format])
			if version.count>0
				version.each do |a|
					@versions = Version.better.approve.where(:id => version).paginate(:page => params[:page], :per_page => 9)
				end
			else
				@versions = Version.where(:id => 0).paginate(:page => params[:page], :per_page => 9)
			end
		else
			@versions = Version.better.approve.paginate(:page => params[:page], :per_page => 9)
		end
	end

	def spam

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