describe ParkingService do

  it "should read commands from file and execute if argv is present" do
    allow(ARGV).to receive(:first).and_return('./spec/seed/sample_commands.txt')
    message = "Created a parking lot with 6 slots\nAllocated slot number: 1\nAllocated slot number: 2\n"
    expect { ParkingService.perform }.to output(message).to_stdout
  end

  it "should throw error if invalid file is given" do
    allow(ARGV).to receive(:first).and_return('./invalid_file.msp')
    expect { ParkingService.perform }.to raise_error(/No such file or directory/)
  end

  it "should be in interactive mode if no argv" do
    allow(ARGV).to receive(:first).and_return(nil)
    allow(STDIN).to receive(:gets) { 'create_parking_lot 6' }
    allow(STDIN).to receive(:gets) { 'exit' }
    expect { ParkingService.perform }.to output("\nInput:\n\nOutput:\n").to_stdout

    expect(ParkingService.get_parking_lot.slots.count).to eql(6)
  end

  it "should build and execute a command" do
    ParkingService.build_and_execute_command('create_parking_lot 6')
    expect(ParkingService.get_parking_lot.slots.count).to eql(6)

    ParkingService.build_and_execute_command('park KA-01-HH-1234 White')
    expect(ParkingService.get_parking_lot.cars.count).to eql(1)
    expect(ParkingService.get_parking_lot.cars.first.registration_number).to eql('KA-01-HH-1234')

    expect(ParkingService.build_and_execute_command('invalid command')).to be_falsey
  end

  it "should create a parking lot" do
    ParkingService.create_parking_lot('', '6')
    expect(ParkingService.get_parking_lot.slots.count).to eql(6)
  end

  it "should perform other commands on parking lot" do
    # creating parking lot
    ParkingService.create_parking_lot('', '6')

    # execute other commands
    expect { ParkingService.execute_on_parking_lot(:park, 'KA-01-HH-1234', 'White') }.to output("Allocated slot number: 1\n").to_stdout
    expect { ParkingService.execute_on_parking_lot(:leave, 1) }.to output("Slot number 1 is free\n").to_stdout
  end

end