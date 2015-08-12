require 'helper'

class TestLogpoop < MiniTest::Unit::TestCase
  def test_test
    ARGV[0], ARGV[1] = "--type", "test"
    LogPoop.new
  end
end
