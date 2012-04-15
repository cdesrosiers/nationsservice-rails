locale_list = [
  { country: 'US', province: 'GA',  city: 'Atlanta' },
  { country: 'US', province: 'MA',  city: 'Boston' },
  { country: 'AU', province: 'NSW', city: 'Sydney' },
  { country: 'US', province: 'NY',  city: 'New York City' },
  { country: 'BR', province: 'SP',  city: 'Sao Paolo' },
  { country: 'IN', province: 'MH',  city: 'Mumbai' },
  { country: 'AU', province: 'VIC', city: 'Melbourne' },
  { country: 'US', province: 'CA',  city: 'San Francisco' },
  { country: 'US', province: 'WA',  city: 'Seattle' },
  { country: 'FR'                ,  city: 'Paris' },
  { country: 'GB'                ,  city: 'London' },
  { country: 'JP'                ,  city: 'Tokyo' },
  { country: 'AT'                ,  city: 'Vienna' },
  { country: 'IT', province: 'RM',  city: 'Rome' },
  { country: 'CN'                ,  city: 'Nanjing' },
  { country: 'MX'                                  },
  { country: 'ES'                                  },
  { country: 'AR'                                  },
  { country: 'BS'                                  },
  { country: 'VG'                                  },
  { country: 'CA', province: 'ON'                },
  { country: 'IN', province: 'MH'                },
  { country: 'AU', province: 'VIC'                },
  { country: 'ES', province: 'PV'                },
  { country: 'ES', province: 'RMU'                },
  { country: 'UA', province: 'ZK'                }  
]

for locale in locale_list
  Locale.create!(locale)
end
