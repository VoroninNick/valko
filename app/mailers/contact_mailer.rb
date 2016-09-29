class ContactMailer < ApplicationMailer

  def offers_and_comments(data)
    @data = data
    mail(:template_path => 'contact_mailer', :layout => false, :subject => "#{@data[:name]}, залишив повідомлення ...", :to => SupportEmail.first.offers_and_comments.split(','))
  end

  def contact_form(data)
    @data = data
    mail(:template_path => 'contact_mailer', :layout => false, :subject => "#{@data[:name]}, залишив повідомлення ...", :to => SupportEmail.first.contact_form.split(','))
  end

  def call_order(data)
    @data = data
    mail(:template_path => 'contact_mailer', :layout => false, :subject => "Замовили дзвінок!", :to => SupportEmail.first.call_order.split(','))
  end

  def order_products(data)
    @data = data
    @current_cart = Cart.find(@data[:cart_id])
    mail(:template_path => 'contact_mailer', :layout => false, :subject => "#{@data[:first_name]} #{@data[:last_name]}, замовили товарів на суму #{@current_cart.total_price.round()} грн.", :to => SupportEmail.first.cart.split(','))
  end


  def wd_order_product(data)
    @data = data
    @product = WindowAndDoorItem.find(data[:product])
    mail(:template_path => 'contact_mailer', :layout => false, :subject => 'Замовлення з розділу "Вікна двері"', :to => SupportEmail.first.wd_order_product.split(','))
  end
end
