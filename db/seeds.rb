User.create! name:  "Duyet Tran", email: "duyettran0608@gmail.com",
  password: "alice123", password_confirmation: "alice123", admin: true

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name:  name, email: email,
    password: password, password_confirmation: password
end
