require 'optparse'
require 'logpoop/runner/context'
require 'logpoop/runner/make'
require 'logpoop/runner/multi_tail'
require 'logpoop/runner/poop'
require 'logpoop/runner/test_run'
require 'logpoop/simulator/base'
require 'logpoop/simulator/make'
require 'logpoop/simulator/tail_eff'
require 'logpoop/simulator/test_run'

class LogPoop  
  def self.banner
    <<-STR
Description:
  Look busy! Tail some stuff in your open terminals, or even simulate running some tests. 
STR
  end

  def self.parse_options
    options = {
      :type => :tail,
      :log_dir => "/var/log"
    }

    o = OptionParser.new do |opt|
      opt.banner = self.banner
      opt.on("-v", "--version", "Show version") do
        puts File.read(File.join(File.dirname(__FILE__), '..', 'VERSION'))
        exit
      end
      opt.on("-d", "--log_dir DIRECTORY", "Log directory") do |d|
        options[:log_dir] = d
      end
      opt.on("-t", "--type TYPE", "Poop type. Available types:\n\tpoop - take a dump in your terminal\n\ttail - simulate 'tail -f' in all your open terminals\n\ttest - simulate a console test run (needs two terminals open)\n\tmake - simulate compiling something for a long, long, looooong time") do |t|
        options[:type] = t
      end
    end
    o.parse!
    options
  end

  def self.instance
    @@instance
  end

  def initialize
    options = self.class.parse_options
    Runner::Context.run(options)    
  end

end

Signal.trap("INT") do
  Runner::Context.stop
end

Signal.trap("TERM") do
  Runner::Context.stop
end