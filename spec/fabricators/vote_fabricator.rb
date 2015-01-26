Fabricator(:vote) do
  vote {[true, false].sample} 
  user
end
