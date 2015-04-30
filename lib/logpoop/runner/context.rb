module Runner
  class Context
    # Get a hash of tty names / open IO objects attached to existing terminal sessions. The current terminal 
    # (the one executing this program) will always be first.
    def self.ttys(nums=[])
      this_tty=`tty`.strip
      # macos
      if(this_tty =~ /ttys[0-9]{3}/)
        other_ttys=Dir['/dev/ttys00*']

      # linux
      elsif(this_tty =~ /\/dev\/pts\/[0-9]{1}/)
        other_ttys=Dir["/dev/pts/*"].find_all{|t| t=~/[0-9]{1}$/ }
      end

      other_ttys.reject!{|t| t == this_tty}
      ios = [this_tty].concat(other_ttys).map do |f| 
        [f, IO.new(IO.sysopen(f, 'w'), 'w')]
      end
      Hash[*ios.flatten]
    end

    # A list of the currently-running simulators
    def self.simulators
      @@simulators ||= []
    end

    def self.logs
      dir = @@options[:log_dir] || "/var/log"
      `ls -S #{dir}/*.log`.split(/\n/)
    end

    def self.run(options={})
      @@options = options
      runner(@@options[:type]).new.run(@@options)
    end

    def self.stop 
      simulators.each(&:stop)
    end

    def self.runner(opt)
      {
        :tail => MultiTail,
        :test => TestRun,
        :poop => Poop,
        :make => Make,
        :print => MultiPrint
      }[opt.to_sym]
    end
  end
end
