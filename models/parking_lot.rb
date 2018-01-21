class ParkingLot
  include ::Search::ParkingLot

  attr_accessor :number_of_slots, :slots, :cars, :tickets

  def initialize(number_of_slots)
    @number_of_slots = number_of_slots

    @slots = []
    @cars = []
    @tickets = []

    configure_slots
  end

  def park(car_number, car_color)
    free_slot = available_slot

    unless free_slot
      puts 'Sorry, parking lot is full'
      return false
    end

    ticket = build_ticket(car_number, car_color, free_slot)

    puts "Allocated slot number: #{free_slot.number}"

    ticket
  end

  def leave(slot_number)
    ticket = ticket_assigned_to(slot_number.to_i)

    return false if ticket.nil?

    ticket.mark_as_expired!
    ticket.slot.leave
    remove_car(ticket.car)

    puts "Slot number #{ticket.slot.number} is free"

    ticket
  end

  private

    def configure_slots
      @number_of_slots.times { |id| @slots << ParkingSlot.new(id + 1) }
    end

    def available_slot
      return false if @cars.size == @number_of_slots

      @slots.each do |slot|
        return slot if slot.free?
      end
    end

    def ticket_assigned_to(slot_number)
      @tickets.find { |t| t.slot.number == slot_number }
    end

    def remove_car(car)
      @cars.delete_if { |c| c == car }
    end

    def occupied_slots
      @slots.select(&:occupied?)
    end

    def build_ticket(car_number, car_color, slot)
      car = Car.new(car_number, car_color)
      @cars << car

      slot.park(car)

      ticket = Ticket.new(car, slot)
      @tickets << ticket
      ticket
    end
end