class SearchController < ApplicationController
	def search_by_name
		@verion = Version.where(:name => params[:name])
	end

	def search
		p params
		@version = Version.approved
		@version = @version.where(:name => params[:name]) if params[:name].present?
		@version = @version.where(:city => params[:city]) if params[:city].present?
		@version = @version.where(:country => params[:country]) if params[:country].present?
		redirect_to versions_path(@version)
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
		p "Params " + params.inspect
		if params[:room].present?
			case params[:room].to_i
			when 1
				@version= Version.order(created_at: "DESC")
			when 2
				@version = Version.where(:status => 1)
			when 3
				@version = Version.where(:status => 0)
			when 4
				@version = Version.order(created_at: 'ASC' )
			end
			@version = @version.pluck(:id).to_s
		elsif params[:apply].present?
			@version = []
		else
			@version = Version.where(:name => params[:name])
			@version = @version.pluck(:id).to_s
		end
		p @version.inspect
		p request.referrer
		if request.referrer.include? 'admin/reports'
			redirect_to admin_reports_better_version_path(@version)
		else
			redirect_to admin_room_entries_path(@version)
		end
	end

	def submission
		p "Params " + params.inspect
		if params[:room].present?
			case params[:room].to_i
			when 1
				@version= Version.pending.order(created_at: "DESC")
			when 2
				@version = Version.pending
			when 3
				@version = Version.pending.order(created_at: 'ASC' )
			end
			@version = @version.pluck(:id).to_s
		elsif params[:apply].present?
			@version = []
		else
			@version = Version.pending.where(:name => params[:name])
			@version = @version.pluck(:id).to_s
		end
		p @version.inspect
		p request.referrer
		p @version
		if request.referrer.include? 'admin/reports'
			redirect_to admin_reports_pre_approval_path(@version)
		else
			redirect_to admin_rooms_path(@version)
		end
	end

	def reports
		redirect_to :back
	end
end