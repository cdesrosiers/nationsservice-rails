

def main
  doc = Nokogiri::HTML(open('us-colleges.html'))
  
  univ_count = 0
  campus_count = 0
  
  doc.xpath('/html/body/div/table/tbody/tr/td/h2').each do |h2|
    puts state = h2.content + "-----------------------------------------------------------"
    h2.next_sibling.next_sibling.xpath('ul/li/a[@class="institution"]').each do |institution|
      puts institution.content
      univ_count +=1
      
      # collect campuses for this institution if there are any
      if (!institution.next_sibling.nil? && !institution.next_sibling.next_sibling.nil?)
        institution.next_sibling.next_sibling.xpath('li/a[@class="institution"]').each do |campus|
          puts "\t\t#{campus.content}"
          campus_count+=1
        end
      end
    end
  end
  
  puts univ_count
  puts campus_count
end

main
