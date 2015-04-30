require 'optparse'
require 'logpoop/runner/context'
require 'logpoop/runner/make'
require 'logpoop/runner/multi_print'
require 'logpoop/runner/multi_tail'
require 'logpoop/runner/poop'
require 'logpoop/runner/test_run'
require 'logpoop/simulator/base'
require 'logpoop/simulator/make'
require 'logpoop/simulator/print'
require 'logpoop/simulator/tail_eff'
require 'logpoop/simulator/test_run'

class LogPoop  
  def self.banner
    <<-STR
Description:
  Look busy! Tail some stuff in your open terminals, or even simulate running some tests. 
STR
  end

  POOP_TYPES=[
    "make - simulate compiling something for a long, long, looooong time ",
    "poop - take a dump in your terminal",
    "print - print the given text over and over in every terminal",
    "tail - simulate 'tail -f' in all your open terminals",
    "test - simulate a console test run (needs two terminals open)",
  ]
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
      opt.on("-t", "--type TYPE", "Poop type. Available types: \t\n#{POOP_TYPES.join("\t\n")}") do |t|
        options[:type] = t
      end
      opt.on("-p", "--print TEXT", "Text to print (only valid with poop type 'print')") do |t|
        options[:text] = t
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
