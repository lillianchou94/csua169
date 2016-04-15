class ElectionsController < ApplicationController
respond_to :html
respond_to :js
  
  
  attr_accessor :election_list, :embed_livestream, :position_list_acc, :curr_election
  
  @@position_list = Hash.new
  def Election.position_list=(x)
    @@position_list = x
  end
  
  def Election.position_list
    return @@position_list
  end
  
  
  def logged_using_omniauth? request
    res = nil
    omniauth = request.env["omniauth.auth"]
    if omniauth != nil
      res = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid']) 
    end
    return res
  end
  
  def show_settings
    @current_user = User.find_by(id: session[:user_id])
    all_same_user = User.where(user_email: @current_user.user_email)
    @my_orgs = Array.new
    for user in all_same_user
      @my_orgs << user.organization
    end
    @org_member_pair = Hash.new
    @org_admin_pair = Hash.new
    for org in @my_orgs
      @org_member_pair[org] = User.where(organization: org, admin_status: 0)
      @org_admin_pair[org] = User.where(organization: org, admin_status: 1)
    end
  end
  
  def import
    begin
      User.import(params[:file], params[:organization])
      redirect_to :action => 'show_settings', notice: "Users imported."
    rescue
      redirect_to :action => 'show_settings', notice: "Invalid CSV file format."
    end
  end
  
  def add_individual
    User.create(:user_name => params[:user_name], :user_email => params[:user_email], :organization => params[:organization], :admin_status => params[:admin_status])
    redirect_to :action => 'show_settings', notice: "#{:user_name} Added."
  end
  
  def delete_individual
    if User.exists? (:user_name => params[:user_name], :user_email => params[:user_email], :organization => params[:organization]){
      user_to_delete = User.where(:user_name => params[:user_name], :user_email => params[:user_email], :organization => params[:organization])
      User.delete(user_to_delete[0].id)
      redirect_to :action => 'show_settings', notice: "#{user_to_delete} imported."
    } else{
      redirect_to :action => 'show_settings', notice: "#{user_to_delete} not found."
    }
    
  end
  
  def show_nominations
    @election_id = params.key?(:election_id) ? params[:election_id] : ''
    @position_id = params.key?(:position_id) ? params[:position_id] : ''
    
    @current_user = User.find_by(id: session[:user_id])
    @user_list = User.all
    if @election_id != '' and @position_id != ''
      respond_to do |format|
            format.html
            format.rss
      end
    end
    #render 'elections/show_nominations.html.erb'
  end
  
  def post_nominations
    # update the db based on the nominations
    @election_id = params.key?(:election_id) ? params[:election_id] : ''
    @position_id = params.key?(:position_id) ? params[:position_id] : ''
    @user_selected = params.key?(:user_selected) ? params[:user_selected] : ''
    puts "WHOA THIS WORKED??"
    
    @current_user_email = params.key?(:user_email) ? params[:user_email] : ''
    @prime = User.where(user_email = @current_user_email).user_prime
    @org = Election.where(election_id = @election_id).organization
    Nomination.create!(:election_id => @election_id, :organization => @org, :user_id => @user_selected, :threshold => 1, :position => @position_id, :num_seconds => 0, :prime_product => @prime)    
    
    render 'elections/submit_nominations.html.erb'
  end
  
  
  def dashboard
  #Super-Admin can only create an organization
    #is_admin = 0-> Regular Access, 1-> Admin Rights, 2-> Super Admin Rights
      #
    #Admin 
      # Button to Start Nomination, Start Voting Button, 
        # Start Nomination
          # Change election phase in the table, 0 - Adding Positions, 1 - Nominations, 2 - Voting, 3 - Voting's closed
        # => If user's username matches the currently logged in User, then allow admin privilegesz
    #The encrypted value will be stored in User.votes
      #Hash conveted to string 
        # {election_name : {"pos" : personA , "pos2" : personB }}, post request to server-side with the decrypted value. 
      #Client-side cookies
        # document.cookies.=> check whether private keys exists, if not => prompt to ask for private key, else => store private key as cookie
      
    #Both
      # Nominate 
      # Vote
    puts "hi"
    if params.key?(:election_id) and params.key?(:position_id)
      puts "redirecting to"
      redirect_to :action => 'show_nominations',:election_id => params[:election_id], :position_id => params[:position_id]
    else
      render 'elections/show_main.html.erb'
    end
    #@embed_livestream = "https://www.youtube.com/embed/KF47Za1lfjM"
    #puts "livestream url is #{@embed_livestream}"
    
   # render 'elections/show_main.html.erb'
  end
  
  def embed_livestream
    @embed_livestream = ""
    if params[:election_id] != nil
      elec = Election.find_by(election_id: params[:election_id])
      if elec != nil
        @embed_livestream = elec.election_livestream
      end
    end
    render 'elections/show_embed.html.erb'
  end
  
  def show_elections
    @election_list = Election.all
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      if @current_user != nil
        @election_list = Election.all
        #@@position_list = Hash.new
        for election in @election_list do
          if @@position_list.key?(election.election_id) == false
            @@position_list[election.election_id] = []
          end
          #@position_list[election.election_id] = ['Secretary','Treasurer','Vice President','President']
          #@position_list[election.election_name]['Secretary'] = []
        end
        @position_list_acc = @@position_list
        respond_to do |format|
          format.html
          format.rss
        end
        # render 'elections/show_elections.html.erb'
      end
    end
  end
  
  def login
    render 'login.html.erb'
  end

  def show_organizations_add
    if params[:new_org] != nil && params[:super_admin_name] != nil && params[:super_admin_email] != nil
      org_param_name = params[:new_org]
      super_admin_param_name = params[:super_admin_name]
      super_admin_param_email = params[:super_admin_email]
    #   election_id_temp = election_param_org+DateTime.now.strftime("%m%d%Y").to_s
    #   if Election.find_by(election_id: election_id_temp) != nil
    #     count = 1
    #     while Election.find_by(election_id: election_id_temp+"_"+count.to_s) != nil
    #       count += 1
    #     end
    #     election_id_temp += "_"+count.to_s
    #   end
    #   election_time_new = DateTime.now.strftime("%m%d%Y").to_s
    #   Election.create!(:election_livestream => embed_livestream, :election_id => election_id_temp, :election_name => election_param_name, :election_time => election_time_new, :organization => "", :position => "", :user_id => "", :num_votes => 0, :did_win => false)    
    #   @election_list = Election.all
    #   @position_list_acc = @@position_list
    end
    render 'elections/show_elections.html.erb'
  end
  
  def show_elections_add
    if params[:new_election_name] != nil && params[:new_election_org] != nil
      election_param_name = params[:new_election_name]
      election_param_org = params[:new_election_org]
      embed_livestream = params[:new_election_livestream]
      election_id_temp = election_param_org+DateTime.now.strftime("%m%d%Y").to_s
      if Election.find_by(election_id: election_id_temp) != nil
        count = 1
        while Election.find_by(election_id: election_id_temp+"_"+count.to_s) != nil
          count += 1
        end
        election_id_temp += "_"+count.to_s
      end
      election_time_new = DateTime.now.strftime("%m%d%Y").to_s
      Election.create!(:election_livestream => embed_livestream, :election_id => election_id_temp, :election_name => election_param_name, :election_time => election_time_new, :organization => "", :position => "", :user_id => "", :num_votes => 0, :did_win => false)    
      @election_list = Election.all
      @position_list_acc = @@position_list
    end
    render 'elections/show_elections.html.erb'
  end
  
  def show_elections_delete
    if params[:election_id] != nil
      tempE = Election.find_by(election_id: params[:election_id])
      puts "wat"
      if tempE.election_livestream == @embed_livestream
        @embed_livestream = ""
      end
      Election.destroy_all(election_id: params[:election_id])
      @election_list = Election.all
      @position_list_acc = @@position_list
    end
    render 'elections/show_elections.html.erb'
  end
  
  def show_positions_add
    if params[:election_id] != nil && params[:new_position_name] != nil
      election_param_id = params[:election_id]
      position_name = params[:new_position_name]
      if @@position_list == nil
        @@position_list = Hash.new
      end
      if @@position_list.key?(election_param_id) == false
        @@position_list[election_param_id] = []
      end
      if @@position_list[election_param_id].include?(position_name) == false
        @@position_list[election_param_id].push(position_name)
      end
      @election_list = Election.all
      @position_list_acc = @@position_list
      render 'elections/show_elections.html.erb'
    end
  end
  
  def show_positions_delete
    if params[:election_id] != nil && params[:position_name] != nil
      if @@position_list != nil && @@position_list.key?(params[:election_id]) == true
        if @@position_list[params[:election_id]].include?(params[:position_name])
          @@position_list[params[:election_id]].delete(params[:position_name])
        end
      end
      @election_list = Election.all
      @position_list_acc = @@position_list
    end
    render 'elections/show_elections.html.erb'
  end
  
  # def show_elections_new

    
  # end


  # def show_elections_in_prog
    
    
  # end
  
  
  # def show_elections_results
    
    
  # end


  # def show_dashboard
    
    
  # end
  

  # def new_election
    
    
  # end

end
