require 'rubygems'
gem 'minitest'
require 'minitest/autorun'
require_relative 'unitType'

class TestUnitType < Minitest::Test
  def setup
    #times[] and timesEncoded[] are symmetric -> 24*60 = 48*30
    #10*60 = 20*30
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
    for time in 0..(@times.length-1)
      puts @timesEncoded[time], @times[time]
    end
  end
  def test_encode
    #test encode of every possible permutation of time within 24 hour block
    for time in 0..(@times.length-1)
      assert_equal(@timesEncoded[time], encode(@times[time]))
    end
  end
  def test_decode
    #test decode of every possible permutation of time within 24 hour block
    for time in 0..(@times.length-1)
      assert_equal(@times[time], decode(@timesEncoded[time]))
    end
  end

end