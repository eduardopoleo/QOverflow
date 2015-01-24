Fabricator(:user) do
  name {Faker::Lorem.words(2).join(' ')} 
  email {Faker::Internet.email}
  password {Faker::Internet.password}
  username {Faker::Lorem.words(2).join(' ')} 
  about_me {Faker::Lorem.paragraph}
end
