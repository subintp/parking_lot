describe Car do

  it "should initialize car" do
    registration_number = 'KA-01-HH-1234' 
    car_color = 'White'
    car = Car.new(registration_number, car_color)

    expect(car.registration_number).to eql(registration_number)
    expect(car.color).to eql(car_color)
  end
end