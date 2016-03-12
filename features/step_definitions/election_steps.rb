Given /the following elections exist/ do |elections_table|
  movies_table.hashes.each do |movie|
    Election.create!(movie)
  end
end