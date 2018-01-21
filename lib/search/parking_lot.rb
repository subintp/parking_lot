module Search
  module ParkingLot
    STATUS_HEADERS = ['Slot No.', 'Registration No', 'Colour']

    def status
      puts STATUS_HEADERS.join("\t")
      occupied_slots.each do |slot|
        puts [slot.number, slot.car.registration_number, slot.car.color].join("\t")
      end
    end

    def registration_numbers_for_cars_with_colour(color)
      matching_cars = @cars.select { |car| car.color == color }
      puts matching_cars.map(&:registration_number).join(", ")
    end

    def slot_numbers_for_cars_with_colour(color)
      matching_slots = occupied_slots.select { |slot| slot.car.color == color }
      puts matching_slots.map(&:number).join(", ")
    end

    def slot_number_for_registration_number(car_number)
      slot = occupied_slots.find { |slot| slot.car.registration_number == car_number }

      if slot
        puts slot.number
      else
        puts "Not found"
      end
    end
  end
end