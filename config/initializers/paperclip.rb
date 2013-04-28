if Rails.env.production?
  # TODO
  # Paperclip::Attachment.default_options[:storage] = :fog
  # Paperclip::Attachment.default_options[:fog_credentials] = {:provider => "Local", :local_root => "#{Rails.root}/public"}
  # Paperclip::Attachment.default_options[:fog_directory] = ""
  # Paperclip::Attachment.default_options[:fog_host] = "http://localhost:3000"
end

# user#picture: public/system/uploads/users/pictures/:id.:extension
Paperclip::Attachment.default_options[:path] = ':rails_root/public/uploads/:class/:attachment/:id/:style.:extension'
Paperclip::Attachment.default_options[:url]  = '/uploads/:class/:attachment/:id/:style.:extension'
