# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => Rails.application.secrets.sendgrid_user,
  :password       => Rails.application.secrets.sendgrid_password,
  :domain         => '138.197.19.102',
  :enable_starttls_auto => true
}
    