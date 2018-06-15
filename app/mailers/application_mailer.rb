# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "phucbitran@gmail.com"
  layout "mailer"
end
