ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true

#if Rails.env.production?
accounts  = YAML::load(File.open(File.join(Rails.root, 'config', 'accounts.yml'))).to_hash
mail_account = accounts['mail'][Rails.env.to_s]


ActionMailer::Base.smtp_settings = {
  user_name: mail_account['username'],
  password:  mail_account['password'],
  domain:    mail_account['domain'],
  address: 'smtp.gmail.com',
  port: 587,
  authentication: 'plain',
  enable_starttls_auto: true
}

ActionMailer::Base.default_url_options[:host] = mail_account['host']
ActionMailer::Base.default_url_options[:port] = 3000 unless Rails.env.production?
