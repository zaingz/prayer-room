class ContactController < ApplicationController
	def contact

	end

	def privacy_policy

	end

	def terms_cond

	end

	def message
		hashi = {"name" => params[:name] , "email" => params[:email] , "subject" => params[:subject] , "message" => params[:message]}
		Contactus.contact_message(hashi).deliver_later
		redirect_to root_path, notice: 'Message sent successfully.'
	end
end
