module PositionsHelper
  def logo_for(position, options = { width: 200 })
    image_tag("#{position.logo_path}", alt: '', class: "round", width: options[:width])
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
  
  def position_duration(position)
    case position.duration
    when 0
      'Other'
    when 1
      'Summer/Seasonal'
    when 2
      '6-month'
    when 3
      '9-month'
    when 4
      'Year-long'
    when 5
      '2-year'
    when 6
      '> 2-year'
    else
      ''
    end
  end
  
  def city_for(position)
    has_city = !position.location_city.nil? && !position.location_city.blank?
    has_state = !position.location_state.nil? && !position.location_state.blank?
    
    location = (has_city ? position.location_city : "") + ((has_city && has_state) ? ", " : "") + (has_state ? position.location_state : "")
  end
end
