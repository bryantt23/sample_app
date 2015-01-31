User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             
  # (The Time.zone.now method is a built-in Rails helper that returns the 
  # current timestamp, taking into account the time zone on the server.
             activated_at: Time.zone.now)
             
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end