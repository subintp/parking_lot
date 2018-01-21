describe Ticket do
  before do
    @car = Car.new('KA-99-HH-1111', 'Red')
    @slot = ParkingSlot.new(1)
    @slot.park(@car)
  end

  it "should initialize ticket" do
    ticket = Ticket.new(@car, @slot)
    expect(ticket.car).to eql(@car)
    expect(ticket.slot).to eql(@slot)
    expect(ticket.valid).to be_truthy
  end

  it "should have incremental ticket number" do
    ticket_1 = Ticket.new(@car, @slot)
    ticket_2 = Ticket.new(@car, @slot)

    expect(ticket_2.number).to be > ticket_1.number
  end

  it "should expire ticket" do
    ticket = Ticket.new(@car, @slot)

    expect(ticket.valid).to be_truthy
    
    ticket.mark_as_expired!
    expect(ticket.valid).to be_falsey
  end
end