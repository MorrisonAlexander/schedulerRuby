require_relative "unitType"
require_relative "appointments"
class Test_UnitType
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
    for hour in ((8..12).to_a + (1..5).to_a)
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
    for time in 0..(@times.length - 1)
      #assert_equal(@timesEncoded[time], encode(@times[time]))
      if @timesEncoded[time] != encode(@times[time])
          raise "encode test failure"
      end
    end
  end
  def test_decode
    #test decode of every possible permutation of time within 24 hour block
    for time in 0..(@times.length - 1)
      if @times[time] != decode(@timesEncoded[time])
        raise @times[time].to_s + " and " + decode(@timesEncoded[time]).to_s + " - " + @timesEncoded[time].to_s +  "\n"
      end
    end
  end
end
def runTest
  tests = Test_UnitType.new
  tests.test_encode
  tests.test_decode
end
runTest