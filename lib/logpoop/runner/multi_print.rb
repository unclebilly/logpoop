module Runner
  class MultiPrint
    def run(opts={})
      raise "You must supply text" unless opts[:text]
      run_all(Context.ttys, opts[:text])
    end

    private

    def terminal_size(tty_name)
      case RUBY_PLATFORM
      when /darwin/
        `stty -f #{tty_name} size`
      when /linux/
        `stty -F #{tty_name} size`
      else
        "80 80"
      end.strip.split.map(&:to_i)
    end

    def run_all(ttys, text)
      threads = []
      ttys.each do |name, tty|
        threads << Thread.new(name, tty, text) do |myname, mytty, mytext|
          size      = terminal_size(myname).last
          simulator = Simulator::Print.new(tty, mytext, size)
          Context.simulators << simulator
          simulator.fake_it
        end
      end
      threads.map(&:join)
    end
  end
end
