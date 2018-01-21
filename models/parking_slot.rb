class ParkingSlot
  attr_accessor :number, :status, :car

  STATE = [
    [1, :free],
    [2, :occupied]
  ]
  STATE_BY_NAME = Hash[STATE.map(&:reverse)]

  def initialize(id)
    @number = id
    mark_as_free!
  end

  STATE_BY_NAME.each do |name, key|
    define_method "#{name}?" do
      @status == key
    end

    define_method "mark_as_#{name}!" do
      @status = key
    end
  end

  def park(car)
    @car ||= car
    mark_as_occupied!
  end

  def leave
    @car = nil
    mark_as_free!
  end
end