RailsAdmin.config do |config|
  # REQUIRED:
  # Include the import action
  # See https://github.com/sferik/rails_admin/wiki/Actions
  config.actions do
    all
    import
  end
  
  config.current_user_method do
    current_user = @current_user
  end

  # Optional:
  # Configure global RailsAdminImport options
  config.configure_with(:import) do |config|
    config.logging = true
  end

  # Optional:
  # Configure model-specific options using standard RailsAdmin DSL
  # See https://github.com/sferik/rails_admin/wiki/Railsadmin-DSL
  config.model 'User' do
    list do
      include_all_fields
      exclude_fields :provider, :uid, :oauth_token, :oauth_expires_at, :user_prime, :votes, :has_voted
    end
    
    import do
      include_all_fields
      exclude_fields :provider, :uid, :oauth_token, :oauth_expires_at, :user_prime, :votes, :has_voted
    end
    
    edit do
      field :user_name
      field :user_email
      field :admin_status
      field :organization
      field :is_active
      field :user_prime, :hidden do
        default_value do
          User.getPrime()
        end
      end
    end
  end
end