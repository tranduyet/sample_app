User.create! name:  "Duyet Tran", email: "duyettran0608@gmail.com",
  password: "alice123", password_confirmation: "alice123", admin: true,
  activated: true, activated_at: Time.zone.now

99.times do |n|
  name  = FFaker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name:  name, email: email,
    password: password, password_confirmation: password,
    activated: true, activated_at: Time.zone.now
end
