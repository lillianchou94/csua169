class ElectionsController < ApplicationController
respond_to :html
respond_to :js
  
  def show
  end
  
  attr_accessor :election_list, :position_list_acc, :curr_election
  
  @@position_list = Hash.new
    def Election.position_list=(x)
      @@position_list = x
    end
    
    def Election.position_list
      return @@position_list
    end
    
  def show_elections
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
  
  def show_elections_add
    if params[:new_election_name] != nil && params[:new_election_org] != nil
      election_param_name = params[:new_election_name]
      election_param_org = params[:new_election_org]
      
      election_id_temp = election_param_org+DateTime.now.strftime("%m%d%Y")
      if Election.find_by(election_id: election_id_temp) != nil
        count = 1
        while Election.find_by(election_id: election_id_temp+"_"+count.to_s) != nil
          count += 1
        end
        election_id_temp += "_"+count.to_s
      end
      #:election_name => election_param_name, 
      Election.create!({:election_id => ""+election_id_temp, :election_name => election_param_name, :election_time => DateTime.now.strftime("%m%d%Y"), :position => "", :candidate => "", :total_votes => 0, :num_won => 0})
      @election_list = Election.all
      @position_list_acc = @@position_list
    end
    render 'elections/show_elections.html.erb'
  end
  
  def show_elections_delete
    if params[:new_election_id] != nil
      Election.destroy_all(election_id: params[:new_election_id])
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
  
  # def show_positions_delete
  #   if params[:election_id] != nil && params[:position_name] != nil
  #     if @@position_list != nil && @@position_list.key?(params[:election_id]) == true
  #       if @@position_list[params[:election_id]].include?(params[:position_name])
  #         @@position_list[params[:election_id]].delete(params[:position_name])
  #       end
  #     end
  #     @election_list = Election.all
  #     @position_list_acc = @@position_list
  #   end
  #   render 'elections/show_elections.html.erb'
  # end
  
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
