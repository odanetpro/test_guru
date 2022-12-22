# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: %("TestGuru" <robot@testguru.com>)
  layout 'mailer'
end
