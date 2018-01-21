require_relative '../initializer'

def park_cars(n)
  parking_tickets = []
  n.times do |num| 
    parking_tickets << @parking_lot.park("KA-#{rand(10..99)}-CA-#{rand(1000..9999)}", get_color)
  end
  parking_tickets
end

def command_builder(str_cmd)
  cmd_args = str_cmd.chomp.split(' ')
  cmd = Command.new(cmd_args[0], cmd_args)
  cmd
end

def get_color
  ['White', 'Red', 'Black', 'Grey', 'Blue', 'Silver'].sample
end
