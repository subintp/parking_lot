COMMAND_CONFIG = {
  create_parking_lot: {
    klass: 'ParkingService',
    method: 'create_parking_lot',
    inputs: 1     
  },
  park: {
    klass: 'ParkingService',
    method: 'execute_on_parking_lot',
    inputs: 2     
  },
  leave: {
    klass: 'ParkingService',
    method: 'execute_on_parking_lot',
    inputs: 1     
  },
  status: {
    klass: 'ParkingService',
    method: 'execute_on_parking_lot',
    inputs: 0     
  },
  registration_numbers_for_cars_with_colour: {
    klass: 'ParkingService',
    method: 'execute_on_parking_lot',
    inputs: 1     
  },
  slot_numbers_for_cars_with_colour: {
    klass: 'ParkingService',
    method: 'execute_on_parking_lot',
    inputs: 1     
  },
  slot_number_for_registration_number: {
    klass: 'ParkingService',
    method: 'execute_on_parking_lot',
    inputs: 1     
  },
}