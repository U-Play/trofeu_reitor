class ApplicationMailer < ActionMailer::Base
  append_view_path "#{Rails.root}/app/views/mailers"
  layout 'trofeu_reitor'
end
