admin = User.create!(name: "Example User",
                           email: "example@railstutorial.org",
                           password: "foobar",
                           password_confirmation: "foobar",
                           institution_id: Institution.first.id,
                           gradyear: rand(User::GRADYEAR_LOWER..User::GRADYEAR_UPPER))
admin.toggle!(:admin)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password  = "password"
  gradyear = rand(User::GRADYEAR_LOWER..User::GRADYEAR_UPPER)
  
  #associate the user to a random institution and campus if applicable
  institution = Institution.first(offset: rand(Institution.count))
  campus_id = institution.campuses.count > 0 ? institution.campuses.first(offset: rand(institution.campuses.count)).id : nil
  
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               institution_id: institution.id,
               campus_id: campus_id,
               gradyear: gradyear)
end