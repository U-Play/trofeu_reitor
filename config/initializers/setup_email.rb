ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true

if Rails.env.production?
  file = File.open '/home/deploy/config/accounts.yml'
else
  filename = File.join(Rails.root, 'config', 'accounts.yml')
  file = File.open filename if File.exists?(filename)

  ActionMailer::Base.default_url_options[:port] = 3000
end

if file
  accounts  = YAML::load(file).to_hash
  mail_account = accounts['trofeu_reitor']['mail'][Rails.env.to_s]
  ActionMailer::Base.default_url_options[:host] = mail_account['host']
  ActionMailer::Base.smtp_settings = {
    user_name: mail_account['username'],
    password:  mail_account['password'],
    domain:    mail_account['domain'],
    address: 'smtp.gmail.com',
    port: 587,
    authentication: 'plain',
    enable_starttls_auto: true
  }
end
