class Contactus < ApplicationMailer
	default from: 'noreply@wifiexplore.com'

	def contact_message(message)
		mail(to: "muhammad.tayyabmukhtar@yahoo.com", subject: message["subject"], body: message["message"]   + "\n\nName: " + message["name"]  +"\nEmail: " + message["email"])
	end
end
