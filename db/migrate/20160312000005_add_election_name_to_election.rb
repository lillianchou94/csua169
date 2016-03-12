class AddElectionNameToElection < ActiveRecord::Migration
  def change
    add_column :elections, :election_name, :string
  end
end
