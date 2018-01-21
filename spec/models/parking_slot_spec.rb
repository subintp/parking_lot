describe ParkingSlot do

  it "should initialize a slot" do
    slot = ParkingSlot.new(1)

    expect(slot.number).to eql(1)
    expect(slot.free?).to be_truthy
    expect(slot.occupied?).to be_falsey
  end

  it "should park a car" do
    slot = ParkingSlot.new(1)
    car = Car.new('KA-77-HH-1111', 'Blue')

    slot.park(car)
    expect(slot.car).to eql(car)
    expect(slot.free?).to be_falsey
    expect(slot.occupied?).to be_truthy
  end

  it "should make slot free" do
    slot = ParkingSlot.new(1)
    car = Car.new('KA-77-HH-1111', 'Blue')
    slot.park(car)

    slot.leave
    expect(slot.car).to be_nil
    expect(slot.free?).to be_truthy
    expect(slot.occupied?).to be_falsey
  end

  it "should not park in preoccupied slot" do
    slot = ParkingSlot.new(1)
    car_1 = Car.new('KA-77-HH-1111', 'Blue')
    slot.park(car_1)
    expect(slot.car).to eql(car_1)

    car_2 = Car.new('MH-45-AB-3433', 'White')
    slot.park(car_2)

    expect(slot.car).not_to eql(car_2)
    expect(slot.car).to eql(car_1)
  end
end