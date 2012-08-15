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
    i = 1
      5.times do
        account_number = (Faker::Address.zip + Faker::Address.zip).gsub(/-/, "")
        account_name = Faker::Company.name
        balance = rand(1000) + (1/rand(1..10).to_f * 100).to_i / 100.to_f
        puts i
        bankstatement = "bankstatement-" + user.id.to_s + i.to_s + ".pdf"
        puts bankstatement
        i += 1
        user.bankaccounts.create!(account_number: account_number,
                          balance: balance,
                          account_name: account_name,
                          bankstatement: bankstatement)    
      end
    end
    
    users = User.all
    users.each do |user|
      3.times do
        random = rand(1..99)
        to_user = User.find(random)
        to = to_user.bankaccounts.first.account_number
        from = user.bankaccounts.first.account_number
        amount = rand(100) + (1/rand(1..10).to_f * 100).to_i / 100.to_f
        status = 'successful'
        to_user_id = to_user.id
        user.transfers.create!(to: to, from: from, amount: amount, status: status, to_user_id: to_user_id)
      end
    end
  end
end