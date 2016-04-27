RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.authorize_with do
    if @current_user == nil
      redirect_to main_app.root_path
    else
      redirect_to main_app.root_path unless @current_user.is_super_admin?
    end
  end
  
  config.included_models = ["User"]
  config.excluded_models = ["Election", "Nomination"]

  config.model 'User' do
    list do
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

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
