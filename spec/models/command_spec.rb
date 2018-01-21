describe Command do

  it "should execute a valid command" do
    cmd = command_builder('create_parking_lot 6')
    expect { cmd.execute }.to output("Created a parking lot with 6 slots\n").to_stdout

    cmd = command_builder('park KA-01-HH-1234 White')
    expect { cmd.execute }.to output("Allocated slot number: 1\n").to_stdout
  end

  it "should not execute invalid command" do
    cmd = command_builder('create_parking_lot 6')

    cmd = command_builder('some_wrong command')
    expect(cmd.execute).to be_falsey
  end

  it "should not execute invalid command" do
    cmd = command_builder('create_parking_lot')
    expect(cmd.execute).to be_falsey

    cmd = command_builder('create_parking_lot 6')
    cmd = command_builder('park KA-01-HH-1234 White')

    cmd = command_builder('park 56')
    expect(cmd.execute).to be_falsey
  end
end