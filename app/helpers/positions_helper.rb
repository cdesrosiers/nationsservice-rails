module PositionsHelper
  def logo_for(position, options = { width: 200 })
    image_tag("#{position.logo_path}", alt: '', class: "round", width: options[:width]) unless (position.logo_path.nil? or position.logo_path.blank?)
  end
  
  def full_deadline(deadline)
    "Application Deadline: #{deadline.nil? ? 'N/A' : deadline.to_s(:long) }"
  end
  
  def full_description(position)
    "Description: #{position.description.nil? ? 'N/A' : position.description}"
  end
  
  def full_overview(position)
    "Overview: #{position.overview.nil? ? 'N/A' : position.overview}"
  end
  
  def full_position_type(type)

    base = "Type: "
    case type
    when 0
      base + 'Other'
    when 1
      base + 'Fellowship'
    when 2
      base + 'Internship'
    when 3
      base + 'Job'
    else
      base + 'N/A'
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
    
  def location_name_short(location)
    ret = ""
    
    ret << location.city unless location.city.nil?
    
    if location.country == 'US'
      if (!location.city.nil? and !location.city.blank?)
        ret << ", #{Carmen.state_name(location.state)}" unless location.city.nil?
      else
        ret << "#{Carmen.state_name(location.state)}" unless location.city.nil?
      end
    else
      if (!location.city.nil? and !location.city.blank?)
        ret << ", #{Carmen.country_name(location.country)}"
      else
        ret << "#{Carmen.state_name(location.state, location.country)}, " unless location.state.nil?
        ret << "#{Carmen.country_name(location.country)}"
      end
    end
    ret
  end
end
