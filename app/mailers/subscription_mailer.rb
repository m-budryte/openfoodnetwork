class SubscriptionMailer < Spree::BaseMailer
  helper CheckoutHelper
  helper ShopMailHelper
  include I18nHelper

  def confirmation_email(order)
    @type = 'confirmation'
    @order = order
    send_mail(order)
  end

  def empty_email(order, changes)
    @type = 'empty'
    @changes = changes
    @order = order
    send_mail(order)
  end

  def placement_email(order, changes)
    @type = 'placement'
    @changes = changes
    @order = order
    send_mail(order)
  end

  def failed_payment_email(order)
    @order = order
    send_mail(order)
  end

  def placement_summary_email(summary)
    @shop = Enterprise.find(summary.shop_id)
    @summary = summary
    mail(to: @shop.contact.email,
         from: from_address,
         subject: "#{Spree::Config[:site_name]} #{t('subscription_mailer.placement_summary_email.subject')}")
  end

  def confirmation_summary_email(summary)
    @shop = Enterprise.find(summary.shop_id)
    @summary = summary
    mail(to: @shop.contact.email,
         from: from_address,
         subject: "#{Spree::Config[:site_name]} #{t('subscription_mailer.confirmation_summary_email.subject')}")
  end

  private

  def send_mail(order)
    I18n.with_locale valid_locale(order.user) do
      confirm_email_subject = t('order_mailer.confirm_email.subject')
      subject = "#{Spree::Config[:site_name]} #{confirm_email_subject} ##{order.number}"
      mail(to: order.email,
           from: from_address,
           subject: subject,
           reply_to: order.distributor.contact.email)
    end
  end
end
