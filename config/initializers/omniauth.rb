OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '63573009556-mv9drlea818ueua0qvc9ipelajbeibk9.apps.googleusercontent.com', 'cv6HXcY461mQDaJk53uGxaZY', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end