class Ticket

  @@ticket_number = 1

  attr_accessor :number, :slot, :car, :valid

  def initialize(car, slot)
    @number = @@ticket_number
    @car = car
    @slot = slot
    @valid = true

    @@ticket_number += 1
  end

  def mark_as_expired!
    @valid = false
  end
end