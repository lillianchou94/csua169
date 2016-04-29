class ElectionsController < ApplicationController
respond_to :html
respond_to :js
respond_to :json

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
    @user_org_adminstatus_pair = @current_user.getAdminStatus()
    all_same_user = User.where(user_email: @current_user.user_email)
    all_org = @current_user.getAdminStatus()
    @my_orgs = Array.new
    for org in all_org.keys
      if all_org[org] == 1
        @my_orgs << org
      end
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
      User.import(params[:file].tempfile.to_path.to_s, params[:organization])
      flash[:notice] = "Users Imported!" 
      redirect_to :action => 'show_settings'
    rescue
      flash[:notice] = "#{params[:file].tempfile.to_path.to_s} Invalid CSV file format."
      redirect_to :action => 'show_settings'
    end
  end
  
  def add_individual
    user = User.where(:user_name => params[:user_name], :user_email => params[:user_email], :organization => params[:organization], :admin_status => params[:admin_status])
    if user.count > 0
      flash[:notice] = "User already exist"
      redirect_to :action => 'show_settings'
    else
      User.create!(:user_name => params[:user_name], :user_email => params[:user_email], :organization => params[:organization], :admin_status => params[:admin_status], :user_prime => User.getPrime(), :has_voted => false)
      flash[:notice] = "#{:user_name} Added."
      redirect_to :action => 'show_settings'
    end
  end
  
  def delete_individual
    user = User.where(:user_name => params[:user_name], :user_email => params[:user_email], :organization => params[:organization])
    if user.count > 0
      User.destroy(user)
      redirect_to :action => 'show_settings', notice: "#{user} deleted."
    else
      redirect_to :action => 'show_settings', notice: "#{user} not found."
    end
  end
  
  def show_nominations
    @election_id = params.key?(:election_id) ? params[:election_id] : ''
    @position_id = params.key?(:position_id) ? params[:position_id] : ''
    org = ''
    if @election_id != ''
      org = @election_id.sub(@election_id[/([0-9]{8}_?.*)$/],"")
    end
    @current_user = User.find_by(id: session[:user_id])
    @user_list = User.where(:organization => org)
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
    org = Election.find_by(:election_id => @election_id).organization
    @current_user = User.find_by(id: session[:user_id])
    
    if not Nomination.where(:position => @position_id).blank?
      exist = Nomination.find_by(:position => @position_id)
      if exist.prime_product == nil
        exist.update_attribute(:prime_product, 1)
      end
      
      # if current user prime exists in prime product of given position then
      # user cannot nominate again for same position
      if (exist.prime_product != 1) and (exist.prime_product % @current_user.user_prime == 0)
        render 'elections/nominations_error.html.erb'
      else
        if exist.user_id == @user_selected
          exist.update_attribute(:prime_product, exist.prime_product * @current_user.user_prime)
        end
      end
    end
    Nomination.create!(:election_id => @election_id, 
                       :organization => org, 
                       :user_id => @user_selected, 
                       :threshold => 1, 
                       :position => @position_id, 
                       :num_seconds => 0, 
                       :prime_product => @current_user.user_prime, 
                       :num_votes => 0, 
                       :did_win => false)
    render 'elections/submit_nominations.html.erb'
  end
  
  def show_vote
    @election_id = params.key?(:election_id) ? params[:election_id] : ''
    @position_id = params.key?(:position_id) ? params[:position_id] : ''
    @current_user = User.find_by(id: session[:user_id])
    @curr_user_votes = @current_user.votes
    @current_user_prime = @current_user.user_prime
    
   
    
    # only show successfully nominated users
    election = Election.find_by(:election_id => @election_id)
    org = election.organization
    nominated_users_id = Nomination.where(:organization => org, :election_id => @election_id, :position => @position_id).pluck(:user_id)
    nominated_users = User.where(:user_email => nominated_users_id)
    
    @user_list = nominated_users
    if @election_id != '' and @position_id != ''
      respond_to do |format|
            format.html
            format.rss
      end
    end
    render 'elections/show_vote.html.erb'
  end
  
  def post_vote
  #   # update the db based on the voting
  #   @election_id = params.key?(:election_id) ? params[:election_id] : ''
  #   @position_id = params.key?(:position_id) ? params[:position_id] : ''
  #   @user_selected = params.key?(:user_selected) ? params[:user_selected] : ''
  #   @current_user_email = params.key?(:user_email) ? params[:user_email] : ''
  #   @user_organization = params.key?(:user_organization)? params[:user_organization] : ''
    
  #   org = Election.find_by(:election_id => @election_id).organization
  #   curr_user = User.find_by(:user_email => @current_user_email)

  #   curr_user_selected = Nomination.find_by(:user_id => @user_selected)
    
  #   # puts "NUMVOTESSS"
  #   # puts curr_user_selected.num_votes
  end
  
  def show_results
    render 'elections/show_results.html.erb'
  end
  
  def save_votes
    
  end
  
  def show_modal
    @election_id = params.key?(:election_id) ? params[:election_id] : ''
    @position_id = params.key?(:position_id) ? params[:position_id] : ''
    @user_selected = params.key?(:user_selected) ? params[:user_selected] : ''
    @curr_user = params.key?(:curr_user) ? params[:curr_user] : ''
    @current_user_email = params.key?(:user_email) ? params[:user_email] : ''
    
    org = Election.find_by(:election_id => @election_id).organization
    curr_user = User.find_by(:user_email => @current_user_email, :organization => org)
    curr_user_votes = curr_user.votes
    
    curr_user_selected = Nomination.find_by(:user_id => @user_selected)
    
    @curr_user_selected_prime = User.find_by(:user_email => curr_user_selected.user_id).user_prime # Needs to be accessed in the modal controller
    
    
    # if curr_user.has_voted
    #   render 'elections/vote_error.html.erb'
    # else
    #   curr_user.update_attribute(:has_voted, true) # this needs to be reset to false when the admin ends current position voting
    #   curr_user_selected.update_attribute(:num_votes, curr_user_selected.num_votes + 1)
    #   @user_cache = curr_user
    #   render 'elections/show_modal.html.erb'
    # end
  end
  
  def encryption_save
    @encrypted_text = params.key?(:encrypted_text) ? params[:encrypted_text] : ''
    @current_user_email = params.key?(:user_email) ? params[:user_email] : ''
    @election_id = params.key?(:election_id) ? params[:election_id] : ''
    
    org = Election.find_by(:election_id => @election_id).organization
    
    curr_user = User.find_by(:user_email => @current_user_email, :organization => org)
    curr_user.update_attribute(:votes, @encrypted_text)
    # curr_user.update_attribute(:has_voted, true)
    
    if @encrypted_text != ''
      respond_to do |format|
        msg = {:encrypted_text => @encrypted_text}
        format.json {render :json => msg}
      end
    else
      respond_to do |format|
        msg = {:encrypted_text => 1.to_s}
        format.json {render :json => msg}
      end
    end
    # render 'elections/submit_vote.html.erb'
  end
  
  def get_user_prime
    @election_id = params.key?(:election_id) ? params[:election_id] : ''
    org = Election.find_by(:election_id => @election_id).organization
    @current_user_email = params.key?(:user_email) ? params[:user_email] : ''
    curr_user = User.find_by(:user_email => @current_user_email, :organization => org)
    
    if params.key?(:increment_vote)
      curr_user_nom = Nomination.find_by(:user_id => @current_user_email)
      curr_user_nom.update_attribute(:num_votes, curr_user_nom.num_votes + 1)
    end
    
    @curr_user_prime = User.find_by(:user_email => @current_user_email).user_prime # Needs to be accessed in the modal controller
    if @curr_user_prime != ''
      respond_to do |format|
        msg = {:prime => @curr_user_prime.to_s}
        format.json {render :json => msg}
      end
    else
      respond_to do |format|
        msg = {:prime => 1.to_s}
        format.json {render :json => msg}
      end
    end
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
      
    @current_user = User.find_by(id: session[:user_id]) 
    current_election = params.key?(:election_id)
    current_election_id = params.key?(:election_id) ? params[:election_id] : ''
    current_phase = Election.find_by(:election_id => current_election_id)
    if current_phase != nil
      current_phase = current_phase.phase
    end

    if params.key?(:election_id) #and params.key?(:position_id)
      if current_phase == 0   # phase 0 = adding positions 
        curr_election_uid = Election.find_by(:election_id => current_election_id)
        curr_election_uid = curr_election_uid.user_id
        if current_user.user_email == curr_election_uid
          @election_id = current_election_id
          @current_user = User.find_by(id: session[:user_id]) 
          render 'elections/show_start_nominations.html.erb'
        else
          render 'elections/error.html.erb'
        end
      elsif current_phase == 1    # phase 1 = nomination
        @current_user = User.find_by(id: session[:user_id])
        @user_list = User.where(organization: @current_user.organization)
        @position_id = params.key?(:position_id) ? params[:position_id] : ''
        @election_id = current_election_id
        render 'elections/show_nominations.html.erb'
        #redirect_to :action => 'show_nominations',:election_id => params[:election_id], :position_id => params[:position_id]
      elsif current_phase == 2    # phase 2 = voting
        @election_id = params.key?(:election_id) ? params[:election_id] : ''
        @position_id = params.key?(:position_id) ? params[:position_id] : ''
        @current_user = User.find_by(id: session[:user_id])
        @curr_user_votes = @current_user.votes
        @current_user_email = @current_user.user_email
    
        # only show successfully nominated users
        org = Election.find_by(:election_id => @election_id).organization
        nominated_users_id = Nomination.where(:election_id => @election_id, :position => @position_id).pluck(:user_id)
        nominated_users = User.where(:user_email => nominated_users_id, :organization => org)
        @user_list = nominated_users
        @position_id = params.key?(:position_id) ? params[:position_id] : ''
        render 'elections/show_vote.html.erb'
        #redirect_to :action => 'show_vote',:election_id => params[:election_id], :position_id => params[:position_id]
      elsif current_phase == 3    # phase 3 = closed
        nominated_users = Nomination.where(:election_id => current_election_id)
        position_list = []
        for no_us in nominated_users
          if position_list.include?(no_us.position) == false
            position_list.push(no_us.position)
          end
        end
        # given list of positions go through each position and get top votes
        @winners = Hash.new
        @winners_pos = position_list
        for pos in position_list
          users_won = Array.new
          users_in_position = Nomination.where(:election_id => current_election_id, :position => pos)
          users_in_position.sort_by(&:num_votes).reverse!
          max_votes = nominated_users[0].num_votes
          users_who_won = Nomination.where(:election_id => current_election_id, :position => pos, :num_votes => max_votes)
          for u in users_who_won
            u_name = User.find_by(:user_email => u.user_id).user_name
            users_won.push(u_name+" ("+u.user_id+")") 
          end
          @winners[pos] = users_won
        end
        
        render 'elections/show_results.html.erb'
      end
    else
      render 'elections/show_main.html.erb'
    end
    
    #@embed_livestream = "https://www.youtube.com/embed/KF47Za1lfjM"
    #puts "livestream url is #{@embed_livestream}"
    
   # render 'elections/show_main.html.erb'
  end
  
  def get_current_phase
    @election_id = params.key?(:election_id) ? params[:election_id] : ''
    @current_user = User.find_by(id: session[:user_id])
    @current_user_email = @current_user.user_email
    curr_election = ''
    curr_user = ''
    if @election_id != ''
      curr_election = Election.find_by(:election_id => @election_id)
    end

    if @current_user_email != '' && curr_election != '' && curr_election.user_id == @current_user_email
      # set the next phase
      respond_to do |format|
        msg = {:phase => curr_election.phase.to_s}
        format.json {render :json => msg}
      end
      #msg = {:phase => curr_election.phase}
      #respond_with(msg)
    else
      respond_to do |format|
        msg = {:phase => -1.to_s}
        format.json {render :json => msg}
      end
    end
  end
  
  def goto_next_phase
    @election_id = params.key?(:election_id) ? params[:election_id] : ''
    @current_user = User.find_by(id: session[:user_id])
    @current_user_email = @current_user.user_email
    curr_election = ''
    curr_user = ''
    if @election_id != ''
      curr_election = Election.find_by(:election_id => @election_id)
    end
    if @current_user_email != '' && curr_election.user_id == @current_user_email
      # set the next phase
      curr_election.phase = curr_election.phase + 1
      curr_election.save!
    end
    respond_to do |format|
        msg = {:random => 0}
        format.json {render :json => msg}
    end
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
    if session[:user_id] != nil
      @current_user = User.find_by(id: session[:user_id])
      @rows_of_same_user = User.where(:user_email => @current_user.user_email)
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
        #render 'elections/show_elections.html.erb'
      end
    else
      render 'elections/show_elections.html.erb'
    end
  end
  
  def login
    render 'elections/login.html.erb'
  end
  
  def show_elections_add
    @current_user = User.find_by(id: session[:user_id])
    if params[:new_election_name] != nil && params[:new_election_org] != nil
      election_param_name = params[:new_election_name]
      election_param_org = params[:new_election_org]
      embed_livestream = params[:new_election_livestream]
      election_id_temp = election_param_org+DateTime.now.strftime("%m%d%Y").to_s
      curr_user = ''
      if session[:user_id]
        curr_user = User.find_by(id: session[:user_id]).user_email
      end
      if Election.find_by(election_id: election_id_temp) != nil
        count = 1
        while Election.find_by(election_id: election_id_temp+"_"+count.to_s) != nil
          count += 1
        end
        election_id_temp += "_"+count.to_s
      end
      election_time_new = DateTime.now.strftime("%m%d%Y").to_s
      Election.create!(:election_livestream => embed_livestream, :election_id => election_id_temp, :election_name => election_param_name, :election_time => election_time_new, :organization => election_param_org, :position => "", :user_id => curr_user, :phase => 0)    
      @election_list = Election.all
      @position_list_acc = @@position_list
    end
    render 'elections/show_elections.html.erb'
  end
  
  def show_elections_delete
    @current_user = User.find_by(id: session[:user_id])
    if params[:election_id] != nil
      tempE = Election.find_by(election_id: params[:election_id])
      puts "wat"
      if tempE.election_livestream == @embed_livestream
        @embed_livestream = ""
      end
      Election.destroy_all(election_id: params[:election_id])
      Nomination.destroy_all(election_id: params[:election_id])
      @@position_list.delete(params[:election_id])
      @election_list = Election.all
      @position_list_acc = @@position_list
    end
    render 'elections/show_elections.html.erb'
  end
  
  def show_positions_add
    @current_user = User.find_by(id: session[:user_id])
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
    @current_user = User.find_by(id: session[:user_id])
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
