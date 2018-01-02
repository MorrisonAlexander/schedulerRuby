require_relative "unitType"
require_relative "appointments"
class Tests
  def initialize
    #times[] and timesEncoded[] are symmetric -> 24*60 = 48*30
    #10*60 = 20*30 -> test day range only due to lack of specificity from input on am pm
    @timesEncoded = []
    for halfHour in 16..35
      for minute in 0..29
        time = halfHour + minute * 10 ** -2
        @timesEncoded.push time
      end
    end
    @times = []
    for hour in (8..12).to_a.push(1..5)
      for minute in 0..59
        if minute < 10
          minute = "0" + minute.to_s
        end
        time = hour.to_s + ":" + minute.to_s
        @times.push(time)
      end
    end
  end
  def test_encode
    #test encode of every possible permutation of time within 24 hour block
    failures = []
    good = []
    for time in 0..(@times.length-1)
      #assert_equal(@timesEncoded[time], encode(@times[time]))
      if @timesEncoded[time] != encode(@times[time])
        failures.push([@timesEncoded[time], encode(@times[time])])
      else
        good.push [@timesEncoded[time], encode(@times[time])]
      end
    end
    print good
    for failure in failures
      puts failure
    end end
  def test_decode
    #test decode of every possible permutation of time within 24 hour block
    for time in 0..(@times.length-1)
      if @times[time] != decode(@timesEncoded[time])
        raise "decode test failure"
      end
      i = 3
    end
  end

end
tests = Tests.new
test.test