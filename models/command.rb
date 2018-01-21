class Command
  attr_accessor :command, :args

  def initialize(command, args)
    @command = command
    @args = args
  end

  def invalid?
    COMMAND_CONFIG[@command.to_sym].nil? || (@args.size - 1) != COMMAND_CONFIG[@command.to_sym][:inputs]
  end

  def execute
    return false if invalid?

    command_setting = COMMAND_CONFIG[@command.to_sym]

    if Object.const_defined?(command_setting[:klass])
      klass = Object.const_get(command_setting[:klass])
    else
      klass = Object.const_set(command_setting[:klass], Class.new)
    end
    
    klass.send(command_setting[:method], *@args)
  end
end