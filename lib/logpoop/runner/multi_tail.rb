module Runner
  class MultiTail
    def run
      ttys = Context.ttys
      logs = Context.logs[0..ttys.length-1]
      run_all(ttys,logs)
    end

    private
    def run_all(ttys,logs)
      threads = []
      ttys.zip(logs).each do |pair|
        threads << Thread.new(pair[0], pair[1]) do |mytty, myfile|
          simulator = Simulator::TailEff.new(mytty, myfile)
          Context.simulators << simulator
          simulator.fake_it
        end
      end
      threads.map(&:join)
    end
  end
end