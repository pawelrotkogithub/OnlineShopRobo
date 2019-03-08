class OrderMailer < ApplicationMailer

  def order_canfirmation(order)
    @order = order
    mail to: order.address.email, subject: "Dziękujemy za zamówienie"
  end

  def order_in_progress(order)
    @order = order
    mail to: order.address.email, subject: "Dziękujemy za zamówienie"
  end

  def order_shipped(order)
    @order = order
    mail to: order.address.email, subject: "Zamówienie wysłane"
  end

  def order_cancelled(order)
    @order = order
    mail to: order.address.email, subject: "Zamówienie anulowane"
  end

  
end
