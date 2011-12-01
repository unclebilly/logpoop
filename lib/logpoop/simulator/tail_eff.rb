#
# Simulate tail -f in a output stream by spewing chunks of lines 
# from a given log file into it at semi-random speed. 
# 
module Simulator
  class TailEff
    include Simulator::Base

    attr_accessor :logfile, :speed, :burst_size

    # The maximum speed of the tailer.  The speed will be sampled 
    # randomly in a range from 1/2 second to 1/speed seconds. 
    # higher = faster
    def speed
      @speed ||= 500
    end

    # The number of groups of lines that will be logged at a given 
    # speed before a new speed is calculated
    def burst_size
      @burst_size ||= 5
    end

    def initialize(out, logfile, speed=nil, burst_size=nil)
      self.out = out
      self.logfile = logfile
      self.speed = speed
      self.burst_size = burst_size
    end

    def fake_it
      while !@stop do
        print_lines
      end
      clear_screen(self.out)
    end

    private
    def print_lines
      bubble_speed, bubble_size = rand_speed, rand_burst
      while(bubble_size > 0)
        num_lines = rand(4) + 1
        rand_pos = rand(loglines.length - 1)
        range = (rand_pos..(rand_pos + num_lines))
        line = loglines[range].map{|li| li.gsub(/'/, "\"")}.join("\n")
        self.out.write(line)
        sleep(1.0 / bubble_speed)
        bubble_size -= 1
      end
    end

    def loglines
      @loglines ||= File.read(logfile).split(/\n/)
    end

    def rand_burst
      rand(burst_size) + 1
    end

    def rand_speed
      rand(speed) + 1
    end
  end
end