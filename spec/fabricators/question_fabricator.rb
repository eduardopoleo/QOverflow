Fabricator(:question) do
  title {Faker::Lorem.words(6).join(' ')} 
  description {Faker::Lorem.paragraph}
end

