class SearchController < ApplicationController
	def search_by_name
		@room = Room.where(:name => params[:name])
	end

	def search
		@room = Room.all
		@room = @room.where(:name => params[:name]) if params[:name].present?
		@room = @room.where(:city => params[:city]) if params[:city].present?
		@room = @room.where(:country => params[:country]) if params[:country].present?
		@room
	end

	def user
		p "Params  "+ params.inspect
		if params[:user].present?
			case params[:user].to_i
			when 1
				@user = User.where(:role => 0)
			when 2
				@user = User.where(:role => 1)
			when 3
				@user = User.where(:status => 1)
			when 4
				@user = User.where(:status => 0)
			end
			@user = @user.pluck(:id).to_s
		elsif params[:apply].present?
			@user = []
		else
			@user = User.where(:username => params[:name])
			@user = @user.pluck(:id).to_s
		end
		p @user.inspect
		redirect_to users_path(@user) 
	end

	def entries
		redirect_to admin_room_entries_path 
	end

	def submission
		redirect_to admin_rooms_path
	end
end