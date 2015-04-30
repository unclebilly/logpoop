module Runner
  class TestRun
    def run(opts={})
      stdout, logout = Context.ttys.values[0..1]
      log = Context.logs[0]
      threads=[]
      threads << Thread.new(stdout) do |myout|
        sim = Simulator::TestRun.new(myout)
        Context.simulators << sim
        sim.fake_it
      end
      if(logout)
        threads << Thread.new(logout, log) do |myout, mylog|
          sim = Simulator::TailEff.new(myout, mylog)
          Context.simulators << sim
          sim.fake_it
        end
      end
      threads.map(&:join)
    end
  end
end
