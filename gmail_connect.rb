 require 'gmail'
 require_relative './password'


 $gmail = Gmail.connect(identifiant, password)
 # play with your gmail...

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

# send_mails(["jean25pierre2@gmail.com","jeanmichelcodeur@gmail.com", "sebdoe75@gmail.com"])






# def send_mails(destinataires)
# 	email = $gmail.compose do
# 	destinataires.each do |destinataire|
# 		to "#{destinataire}"
#   	subject "11:57!"
#   body "Spent the day on the road..."
# end
# email.deliver!
# send_mails("jean25pierre2@gmail.com", "")








	# gmail.deliver do
	# to "#{destinataire}" 
 #   #to "jean25pierre2@gmail.com"
 #   subject "11:57"
 #   #text_part do
 #     body "Text of plaintext message."
 #   end
# end

#  send_mail("jean25pierre2@gmail.com")

# puts "email sent!"


   #  html_part do
   #    content_type 'text/html; charset=UTF-8'
   #    body "<p>Text of <em>html</em> message.</p>"
   #  end
   # add_file "/path/to/some_image.jpg"

# def get_credentials

 #en entrée un nom de fichier
 #file.read 
 #ruby json_parse

 #un hash avec password et username 	



 #gmail.logout

