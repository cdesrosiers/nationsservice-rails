require 'nokogiri'

namespace :db do
  desc "Fill database with insitution data"
  
  task institutions: :environment do
    doc = Nokogiri::HTML(open('lib/tasks/us-colleges.html'))
  
    doc.xpath('/html/body/div/table/tbody/tr/td/h2').each do |h2|
      state = h2.content
      h2.next_sibling.next_sibling.xpath('ul/li/a[@class="institution"]').each do |institution|
        institution.content
      
        ins = Institution.create!(name: institution.content, state: state)
      
        # collect campuses for this institution if there are any
        if (!institution.next_sibling.nil? && !institution.next_sibling.next_sibling.nil?)
          institution.next_sibling.next_sibling.xpath('li/a[@class="institution"]').each do |campus|
            ins.campuses.create!(name: campus.content)
          end
        end
      end
    end
    
    # a couple need to be added manually
    ins1 = Institution.create!(name: 'University of Michigan System', state: 'Michigan')
    ins1.campuses.create!(name: 'Ann Arbor')
    ins1.campuses.create!(name: 'Dearborn')
    ins1.campuses.create!(name: 'Flint')
    
    ins2 = Institution.create!(name: 'Massachusetts State University System', state: 'Massachusetts')
    ins2.campuses.create!(name: 'Bridgewater State University')
    ins2.campuses.create!(name: 'Fitchburg State University')
    ins2.campuses.create!(name: 'Framingham State University')
    ins2.campuses.create!(name: 'Massachusetts College of Art & Design')
    ins2.campuses.create!(name: 'Massachusetts College of Liberal Arts ')
    ins2.campuses.create!(name: 'Massachusetts Maritime Academy')
    ins2.campuses.create!(name: 'Salem State University')
    ins2.campuses.create!(name: 'Westfield State University')
    ins2.campuses.create!(name: 'Worcester State University')
    
  end
  
  task positions: :environment do
    
    doc = Nokogiri::HTML(open('lib/tasks/sample-positions.html'))
    
    skip = 0
  
    doc.xpath('//*[@id="wiki-tab-0-0"]').each do |div|
      
      next if !div.element?
      
      div.xpath('div/table/tbody/tr').each do |tr|
        
        next if !div.element?
        
        puts 'tr'
        tr.xpath('td').each do |td|
          puts td.content
        end
      end
      
      #if skip < 1
       # skip+=1
      #end
      
      #next if !row.element?
      
      #puts row.element?
    end
  end
  
  task sample_positions: :environment do
    Position.create!(name: 'AFL-CIO Media Outreach Fellow', description: 'Labor Movement Media Outreach',
                     location_city: 'Washington D.C.', location_country: 'USA', deadline: '2012-03-30',
                     logo_path: 'afl-cio.gif', position_type: 1)
    Position.create!(name: 'Amate House Volunteer Program', description: 'Community Building Placements with Living Stipend',
                     location_city: 'Chicago', location_state: 'Illinois', location_country: 'USA', deadline: '2012-04-01',
                     logo_path: 'amate.gif', position_type: 1)
    Position.create!(name: 'Arden Professional Apprentice (APA) Program', description: 'Apprenticeship in Non-Profit Regional Theatre',
                     location_city: 'Philadelphia', location_state: 'Pennsylvania', location_country: 'USA', deadline: '2012-04-13',
                     logo_path: 'arden.gif', position_type: 1)
    Position.create!(name: 'Artist Corps - New Orleans', description: 'Placements in Music Education',
                     location_city: 'New Orleans', location_state: 'Louisiana', location_country: 'USA', deadline: '2012-04-01',
                     logo_path: 'Artist-Corps-Final-Logo_Color.jpg', position_type: 1)
    
    Position.create!(name: 'Autry Fellowship', description: 'Economic Opportunity Staff Position',
                     location_city: 'Durham', location_state: 'North Carolina', location_country: 'USA', deadline: '2012-01-16',
                     logo_path: 'mdc.jpg', position_type: 1)
    
    Position.create!(name: 'Berkeley Repertory Theatre - Professional Fellowships', description: 'Artistic, Administrative, and Production Theatre Fellowships',
                     location_city: 'Berkeley', location_state: 'California', location_country: 'USA', deadline: '2012-04-01',
                     logo_path: 'berkeleyrep_logo.jpg', position_type: 1)
    
    Position.create!(name: 'Boston Philharmonic - Zander Fellowship', description: 'Apprenticeship for Aspiring Conductor',
                     location_city: 'Boston', location_state: 'Massachusetts', location_country: 'USA', deadline: '',
                     logo_path: 'bostonphilharmonic.gif', position_type: 1)
  end
    
end