class ElectionsController < ApplicationController
respond_to :html
respond_to :js
  def show
  end

  def show_elections
    respond_to do |format|
      format.html
      format.rss
    end
    # render 'elections/show_elections.html.erb'
  end


  def show_elections_start
    
    
  end


  def show_elections_in_prog
    
    
  end
  
  
  def show_elections_results
    
    
  end


  def show_dashboard
    
    
  end
  

  def new_election
    
    
  end

end
