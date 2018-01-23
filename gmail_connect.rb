 require 'gmail'
 require_relative './password'


 $gmail = Gmail.connect(identifiant, password)

 p $gmail

 def send_mail(destinataire)
 	
	email = $gmail.compose do
  to "#{destinataire}"
  subject "on aime la choucroute!"
  body "Spent the day on the road..."
end
email.deliver!


puts "email sent!"
end

def send_mails(destinataires)
	destinataires.each do |destinataire|

send_mail(destinataire)
end


end

