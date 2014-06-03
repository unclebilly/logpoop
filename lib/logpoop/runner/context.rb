module Runner
  class Context
    # Get an array of open IO objects attached to existing terminal sessions. The current terminal 
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
      [this_tty].concat(other_ttys).map{|f| IO.sysopen(f, 'w')}.map{|n| IO.new(n, 'w')}
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
      runner(@@options[:type]).new.run
    end

    def self.stop 
      simulators.each(&:stop)
    end

    def self.runner(opt)
      {
        :tail => MultiTail,
        :test => TestRun,
        :poop => Poop,
        :make => Make
      }[opt.to_sym]
    end
  end
end