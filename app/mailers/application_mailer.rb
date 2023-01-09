# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: %("#{I18n.t('general.app_title')}" <#{ENV.fetch('FROM_EMAIL')}>)
  layout 'mailer'
end
