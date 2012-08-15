namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    User.create!(name: "Example User",
                 email: "cycloneuser@cyclonetransfers.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "cycloneuser-#{n+1}@cyclonetransfers.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    users = User.all
    users.each do |user|
      5.times do
        account_number = (Faker::Address.zip + Faker::Address.zip).gsub(/-/, "")
        account_name = Faker::Company.name
        balance = rand(1000) + (1/rand(1..10).to_f * 100).to_i / 100.to_f
        puts account_number
        user.bankaccounts.create!(account_number: account_number,
                          balance: balance,
                          account_name: account_name ) 
      end
    end
  end
end