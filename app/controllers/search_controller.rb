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
end
