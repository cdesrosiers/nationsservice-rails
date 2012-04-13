def random_user
                User.first(offset: rand(User.count))
end

def random_institution
                Institution.first(offset: rand(Institution.count))
end

def random_campus(insitution)
                institution.campuses.first(offset: rand(institution.campuses.count))
end

random_user.posted_positions.create!(name: 'Amate House Volunteer Program', description: 'Community Building Placements with Living Stipend',
                location_city: 'Chicago', location_state: 'IL', location_country: 'US', deadline: '2012-04-01',
                logo_path: 'amate.gif', position_type: 1, duration: 4)
random_user.posted_positions.create!(name: 'Arden Professional Apprentice (APA) Program', description: 'Apprenticeship in Non-Profit Regional Theatre',
                location_city: 'Philadelphia', location_state: 'PA', location_country: 'US', deadline: '2012-04-13',
                logo_path: 'arden.gif', position_type: 1, duration: 4)
random_user.posted_positions.create!(name: 'Artist Corps - New Orleans', description: 'Placements in Music Education',
                location_city: 'New Orleans', location_state: 'LA', location_country: 'US', deadline: '2012-04-01',
                logo_path: 'Artist-Corps-Final-Logo_Color.jpg', position_type: 1, duration: 4)

random_user.posted_positions.create!(name: 'Autry Fellowship', description: 'Economic Opportunity Staff Position',
                location_city: 'Durham', location_state: 'NC', location_country: 'US', deadline: '2012-01-16',
                logo_path: 'mdc.jpg', position_type: 1, duration: 4)

random_user.posted_positions.create!(name: 'Berkeley Repertory Theatre - Professional Fellowships', description: 'Artistic, Administrative, and Production Theatre Fellowships',
                location_city: 'Berkeley', location_state: 'CA', location_country: 'US', deadline: '2012-04-01',
                logo_path: 'berkeleyrep_logo.jpg', position_type: 1, duration: 4)

random_user.posted_positions.create!(name: 'Boston Philharmonic - Zander Fellowship', description: 'Apprenticeship for Aspiring Conductor',
                location_city: 'Boston', location_state: 'MA', location_country: 'US', deadline: '',
                logo_path: 'bostonphilharmonic.gif', position_type: 1, duration: 4)

random_user.posted_positions.create!(name: 'AFL-CIO Media Outreach Fellow', description: 'Labor Movement Media Outreach',
                location_state: 'DC', location_country: 'US', deadline: '2012-03-30',
                logo_path: 'afl-cio.gif', position_type: 1, duration: 4)
