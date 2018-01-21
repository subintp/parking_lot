require_relative '../lib/search/parking_lot'

require_relative '../models/car'
require_relative '../models/parking_slot'
require_relative '../models/ticket'
require_relative '../models/parking_lot'

def park_cars(n)
  parking_tickets = []
  n.times do |num| 
    parking_tickets << @parking_lot.park("KA-#{rand(10..99)}-CA-#{rand(1000..9999)}", get_color)
  end
  parking_tickets
end

def get_color
  ['White', 'Red', 'Black', 'Grey', 'Blue', 'Silver'].sample
end
