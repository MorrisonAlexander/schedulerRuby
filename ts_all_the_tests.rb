require 'rubygems'
gem 'minitest'
require 'minitest/autorun'
require_relative 'unitType'
class TestUnitType < Minitest::Test
  def setup
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
    for time in 0..(@times.length - 1)
      assert_equal @timesEncoded[time], encode(@times[time])
    end
  end

  def test_decode
    #test decode of every possible permutation of time within 24 hour block
    for time in 0..(@times.length - 1)
      assert_equal @times[time], decode(@timesEncoded[time]), @times[time].to_s + " and " + decode(@timesEncoded[time]).to_s + " - " + @timesEncoded[time].to_s + "\n"
    end
  end

  def test_Subtraction
    #There are !600 possible subtractions, too much for a brute test algorithm
    for time in @timesEncoded
      time = Unit.new time
      assert_equal 0, time-time
    end
    #case study intended to maximize chance of failure
    timeA = Unit.new "9:16"
    timeB = Unit.new "4:37"
    assert_equal timeB - timeA, 14.21 #33.7 - 18.16
  end
end
