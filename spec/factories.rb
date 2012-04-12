FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
  end
  
  factory :institution do
    sequence(:name) { |n| "University #{n} of Foobar" }
    sequence(:state) { |n| "S#{n}" }
  end
  
  factory :campus do
    sequence(:name) { |n| "Campus #{n}" }
    institution
  end
  
  factory :position do
    sequence(:name) { |n| "Fellowhip #{n}" }
    sequence(:description) { |n| "This is the description of fellowship number #{n}"}
    sequence(:location_city) { |n| "City #{n}" }
    sequence(:location_state) { |n| "State #{n}" }
    sequence(:location_country) { |n| "Country #{n}" }
    sequence(:deadline) { Time.now.strftime("%Y-%m-%d") }
    sequence(:logo_path) { |n| "pic{n}.jpg"}
    sequence(:position_type) { 0 }
    sequence(:duration) { 4 }
    
    factory :fellowship do
      position_type 1
    end
    
    factory :internship do
      position_type 2
    end
    
    factory :job do
      position_type 3
    end
  end
end
