module PositionsHelper
  def logo_for(position, options = { width: 200 })
    image_tag("#{position.logo_path}", alt: '', class: "round", width: options[:width]) unless (position.logo_path.nil? or position.logo_path.blank?)
  end
  
  def country_name_for(position)
    ""
  end
  
  def province_name_for(position)
    ""
  end
  
  def city_name_for(position)
    ""
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
    ""    
  end
  
  def locale_name_short(locale)
    ret = ""
    
    ret << locale.city unless locale.city.nil?
    
    if locale.country == 'US'
      if (!locale.city.nil? and !locale.city.blank?)
        ret << ", #{locale.province}" unless locale.city.nil?
      else
        ret << "#{Carmen.state_name(locale.province)}" unless locale.city.nil?
      end
    else
      if (!locale.city.nil? and !locale.city.blank?)
        ret << ", #{Carmen.country_name(locale.country)}"
      else
        ret << "#{Carmen.state_name(locale.province, locale.country)}, " unless locale.province.nil?
        ret << "#{Carmen.country_name(locale.country)}"
      end
    end
    ret
  end
end
