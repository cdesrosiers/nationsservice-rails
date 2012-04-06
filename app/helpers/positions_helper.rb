module PositionsHelper
  def logo_for(position, options = { width: 200 })
    image_tag("logos/#{position.logo_path}", alt: '', class: "round", width: options[:width])
  end
  
  def position_type(position)
    case position.position_type
    when 0
      'Other'
    when 1
      'Fellowship'
    when 2
      'Internship'
    when 3
      'Job'
    else
      ''
    end
  end
  
  def full_location_for(position)
    has_city = !position.location_city.nil?
    has_state = !position.location_state.nil?
    has_country = !position.location_country.nil?
    
    delimiter = case
    when (has_city ^ has_state) && has_country
     ", "
    when (has_city && has_state && has_country)
      " - "
    else
      ""
    end
    
    location = (has_city ? position.location_city : "") + (has_city && (has_state) ? ", " : "") + (has_state ? position.location_state : "") + delimiter + (has_country ? position.location_country : "")
  end
end
