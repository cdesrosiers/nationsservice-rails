FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
    
    factory :user_with_institution do
      institution :institution
      
      factory :user_with_institution_and_campus do
        campus :campus
      end
    end
  end
  
  factory :institution do
    sequence(:name) { |n| "City University of New York #{n}" }
    sequence(:state){ |n| "New York" }
  end
  
  factory :campus do
    name "Queens College"
    institution
  end
  
  factory :locale do
    country "US"
    province "CA"
    sequence(:city) { |n| "California City #{n}" }
  end
  
  factory :position do
    sequence(:name) { |n| "Fellowhip #{n}" }
    sequence(:description) { |n| "This is the description of fellowship number #{n}"}
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
