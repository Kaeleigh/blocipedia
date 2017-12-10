require 'faker'

9.times do
  User.create!(
    email:  Faker::Internet.email,
    password: Faker::Internet.password,
    role: 'standard'
  )
end
standard_users = User.where(role: 'standard')

4.times do
  User.create!(
    email:  Faker::Internet.email,
    password: Faker::Internet.password,
    role: 'premium'
  )
end
premium_users = User.where(role: 'premium')

10.times do
  Wiki.create!(
    user: standard_users.sample,
    title:  Faker::HarryPotter.book,
    body: Faker::HarryPotter.quote,
    private: false
  )
end

10.times do
  Wiki.create!(
    user: premium_users.sample,
    title: Faker::RickAndMorty.character,
    body: Faker::RickAndMorty.quote,
    private: Faker::Boolean.boolean
  )
end

standard_member = User.create!(
  email:  'standard@test.com',
  password: 'password1',
  role: 'standard'
)

premium_member = User.create!(
  email: 'premium@test.com',
  password: 'password2',
  role: 'premium'
)

admin = User.create!(
  email: 'admin@test.com',
  password: 'password3',
  role: 'admin'
)

puts "Seeds finished"
puts "#{standard_users.count} standard users created"
puts "#{premium_users.count} premium users created"
puts "#{User.where(role: 'admin').count} admins created"
puts "#{Wiki.count} topics created"
