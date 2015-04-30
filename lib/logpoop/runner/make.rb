module Runner
  class Make
    def run(opts={})
      stdout, other_tty = Context.ttys.values[0..1]
      threads = []
      threads << Thread.new(stdout) do |myout|
        sim = Simulator::Make.new(myout)
        Context.simulators << sim
        sim.fake_it
      end
      threads.map(&:join)
    end

    
  end
end
