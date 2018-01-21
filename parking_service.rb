class ParkingService
  class << self

    def perform
      file_name = ARGV.first
      if file_name.nil?
        ParkingService.interactive_mode
      else
        read_commands_from_file(file_name)
      end
    end

    def interactive_mode
      str_cmd = ''
      until str_cmd == 'exit'
        puts "\nInput:"
        str_cmd = STDIN.gets.chomp
        puts "\nOutput:"
        build_and_execute_command(str_cmd)
      end
    end

    def read_commands_from_file(file_name)
      File.readlines(file_name).each do |line|
        build_and_execute_command(line)
      end
    end

    def build_and_execute_command(str_cmd)
      cmd_args = str_cmd.chomp.split(' ')
      cmd = Command.new(cmd_args[0], cmd_args)
      cmd.execute
    end

    def create_parking_lot(*args)
      @@parking_lot = ParkingLot.new(args[1].to_i)
      puts "Created a parking lot with #{args[1]} slots"
    end

    def execute_on_parking_lot(*args)
      @@parking_lot.send(args[0], *(args[1..-1] || []))
    end

    def get_parking_lot
      @@parking_lot
    end
  end
end