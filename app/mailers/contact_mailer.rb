class ContactMailer < ApplicationMailer

  def offers_and_comments(data)
    @data = data
    mail(:template_path => 'contact_mailer', :layout => false, :subject => "#{@data[:name]}, залишив повідомлення ...", :to => SupportEmail.first.offers_and_comments.split(','))
  end
end
