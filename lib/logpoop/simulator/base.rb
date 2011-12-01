module Simulator
  module Base
  	# takes an IO instance
    def clear_screen(tty)
      tty.write "\e[2J\e[f" 
    end

    def stop
      @stop = true
    end

    def simulate
      fake_it
      clear_screen(out)
    end

    def self.included(base)
      base.class_eval do
        attr_accessor :out
      end
    end
  end
end