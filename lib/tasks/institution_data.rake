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
end