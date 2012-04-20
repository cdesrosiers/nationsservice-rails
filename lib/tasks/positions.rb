def random_user
                User.first(offset: rand(User.count))
end

def random_institution
                Institution.first(offset: rand(Institution.count))
end

def random_campus(institution)
                ins = nil
                ins = institution.campuses.first(offset: rand(institution.campuses.count)) unless institution.campuses.empty?
end

def random_locale
                Locale.first(offset: rand(Locale.count))
end

def rand_small_int
                (1..5).to_a.sample
end

def samp(lo,hi)
                (lo..hi).to_a.sample
end

positions = [
                {name: 'Arden Professional Apprentice (APA) Program', description: 'Apprenticeship in Non-Profit Regional Theatre',
                                     deadline: '2012-04-13', logo_path: 'arden.gif', position_type: 1, duration: 4},
                {name: 'Artist Corps - New Orleans', description: 'Placements in Music Education',
                                     deadline: '2012-04-01', logo_path: 'Artist-Corps-Final-Logo_Color.jpg', position_type: 1, duration: 4},
                {name: 'Autry Fellowship', description: 'Economic Opportunity Staff Position',
                                     deadline: '2012-01-16', logo_path: 'mdc.jpg', position_type: 1, duration: 4},
                {name: 'Amate House Volunteer Program', description: 'Community Building Placements with Living Stipend',
                                     deadline: '2012-04-01', logo_path: 'amate.gif', position_type: 1, duration: 4},
                {name: 'Berkeley Repertory Theatre - Professional Fellowships', description: 'Artistic, Administrative, and Production Theatre Fellowships',
                                     deadline: '2012-04-01', logo_path: 'berkeleyrep_logo.jpg', position_type: 1, duration: 4},
                {name: 'Boston Philharmonic - Zander Fellowship', description: 'Apprenticeship for Aspiring Conductor',
                                     deadline: '', logo_path: 'bostonphilharmonic.gif', position_type: 1, duration: 4},
                {name: 'AFL-CIO Media Outreach Fellow', description: 'Labor Movement Media Outreach',
                                     deadline: '2012-03-30', logo_path: 'afl-cio.gif', position_type: 1, duration: 4}
]

def create_new_position(position_hash)
                if (!position_hash[:overview].present?)
                                position_hash[:overview] = Faker::Lorem.paragraph(20)
                end
                new_position = random_user.posted_positions.create!(position_hash)
                
                num_locales = rand_small_int
                
                num_locales.times do |n|
                                locale = random_locale
                                new_position.place_in!(locale) unless new_position.placed_in?(locale)
                end
                
                if([true,false].sample)
                                ins = random_institution
                                new_position.update_attributes(institution: ins, campus: random_campus(ins))             
                end
end

for position in positions do
                create_new_position(position)
end

99.times do |n|
  name  = Faker::Company.name
  description = Faker::Company.bs
  deadline = "#{samp(2012,2013)}-#{samp(1,12)}-#{samp(1,29)}"
  position_type = samp(0,3)
  duration = samp(0,6)
  overview = Faker::Lorem.paragraph(20)
  
  position_hash = {name: name,
               description: description,
               deadline: deadline,
               position_type: position_type,
               duration: duration,
               overview: overview}
  
  create_new_position(position_hash)
end
