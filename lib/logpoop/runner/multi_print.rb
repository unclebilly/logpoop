module Runner
  class MultiPrint
    def run(opts={})
      raise "You must supply text" unless opts[:text]
      run_all(Context.ttys, opts[:text])
    end

    private
    def run_all(ttys, text)
      threads = []
      ttys.each do |name, tty|
        threads << Thread.new(name, tty, text) do |myname, mytty, mytext|
          size = `stty -f #{myname} size`.strip.split.last.to_i rescue 80
          simulator = Simulator::Print.new(tty, mytext, size)
          Context.simulators << simulator
          simulator.fake_it
        end
      end
      threads.map(&:join)
    end
  end
end
