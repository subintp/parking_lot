describe ParkingLot do

  context "initialization tests" do
    it "should create a parking lot with slots initialized" do
      expect(ParkingLot.new(6).slots.count).to eql(6)
    end

    it "should create a parking lot with all slots free/un-occupied" do
      expect(ParkingLot.new(6).slots.map(&:free?).all?).to eql(true)
    end

    it "should create a parking lot with no cars" do
      expect(ParkingLot.new(6).cars.count).to eql(0)
    end

    it "should create a parking lot with zero tickets" do
      expect(ParkingLot.new(6).tickets.count).to eql(0)
    end


    it "should have all slots numbers in order" do
      slots_count = rand(50..100)
      pl = ParkingLot.new(slots_count)
      expect(pl.slots.map(&:number)).to eql((1..slots_count).to_a)
    end
  end

  context "parking and leaving" do
    
    before(:each) do
      slots_count = rand(50..100)
      @parking_lot = ParkingLot.new(slots_count)
    end

    it "should park and give a ticket" do
      ticket = @parking_lot.park('KL-56-kk-8979', 'White')
      expect(ticket).to be_an_instance_of(Ticket)
      expect(ticket.car).not_to be_nil
      expect(ticket.slot).not_to be_nil
    end

    it "should unpark a car" do
      car_number = 'KL-56-MM-8979'
      ticket = @parking_lot.park(car_number, 'White')

      @parking_lot.leave(ticket.slot.number)

      expect(ticket.slot.car).to be_nil
      expect(ticket.valid).to be_falsey
      expect(@parking_lot.cars.map(&:number)).not_to include(car_number)
    end

    it "should give the nearest free slot" do
      parking_tickets = park_cars(25)

      free_slots = []
      10.times { free_slots << rand(1..25) }
      free_slots.uniq!
      free_slots.each { |id| @parking_lot.leave(id) }

      ticket = @parking_lot.park('KL-56-MM-0000', 'White')
      expect(ticket.slot.number).to eql(free_slots.sort.first)
    end

    it "should not park another car when parking lot is full" do
      @parking_lot = ParkingLot.new(10)
      parking_tickets = park_cars(10)

      ticket = @parking_lot.park('KL-56-MM-0000', 'White')
      expect(ticket).to be_falsey
    end

  end

  context "search" do

    before(:each) do
      slots_count = rand(50..100)
      @parking_lot = ParkingLot.new(slots_count)
      @parking_tickets = park_cars(rand(0..50))
    end

    it "should show registration numbers for cars with color" do
      color = @parking_lot.cars.first.color
      msg_out = @parking_lot.cars.select { |c| c.color == color }.map(&:registration_number).join(', ')
      expect { @parking_lot.registration_numbers_for_cars_with_colour(color) }.to output("#{msg_out}\n").to_stdout
    end

    it "should show slot numbers for cars with color" do  
      color = @parking_lot.cars.first.color
      msg_out = @parking_lot.slots.select { |s| s.occupied? && s.car.color == color }.map(&:number).join(', ')
      expect { @parking_lot.slot_numbers_for_cars_with_colour(color) }.to output("#{msg_out}\n").to_stdout
    end

    it "should show slot number for registration number" do
      car = @parking_lot.cars.sample
      msg_out = @parking_lot.slots.select(&:occupied?).find { |s| s.car == car }.number
      if car.nil?
        msg_out = 'Not found'
      end
      expect { @parking_lot.slot_number_for_registration_number(car.registration_number) }.to output("#{msg_out}\n").to_stdout
    end

    it "should show not found in case no matching cars found for given registration number" do
      number = '00000000'
      msg_out = 'Not found'
      expect { @parking_lot.slot_number_for_registration_number(number) }.to output("#{msg_out}\n").to_stdout
    end

    it "should show status" do
      msg_out = ['Slot No.', 'Registration No', 'Colour'].join("\t")
      @parking_lot.slots.select(&:occupied?).each do |slot|
        msg_out += "\n" + [slot.number, slot.car.registration_number, slot.car.color].join("\t")
      end
      expect { @parking_lot.status }.to output("#{msg_out}\n").to_stdout
    end

  end

end