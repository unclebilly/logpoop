class LogPoop
  attr_accessor :go
  
  def self.usage
    <<-STR
Description:
  Print random lines from log files pulled from somewhere, at randomly varying speeds, to some or all 
  open terminals.
  
Usage: #{$0} [log_dir] [tty_num]
  log_dir    directory to pull log files from, defaults to /var/log
  tty_num    tty number to use (e.g. 1).  If blank, all open terminals will get pooped on.
STR
  end
  def self.instance
    @@instance
  end
  
  # takes an IO instance
  def clear_screen(tty)
    tty.write "\e[2J\e[f" 
  end

  def loop_some_log_crap(mytty, log)
    iter = 0
    speed = rand(20)
    while @go do
      iter += 1
      num_lines = rand(4) + 1
      rand_pos = rand(log.length - 1)
      range = (rand_pos..(rand_pos + num_lines))
      line = log[range].map{|li| li.gsub(/'/, "\"")}.join("\n")
      mytty.write(line)
      sleep(speed / 50.0)
      speed = rand(20) if iter % 7 == 0
    end
  end

  def initialize(log_dir, num)
    @@instance = self
    @ttys = get_tty_list(num).map{|f| IO.sysopen(f, 'w')}.map{|n| IO.new(n, 'w')}
    logs = get_logs(@ttys.length, log_dir || "/var/log")
    f = logs.map{|log| File.read(log).split(/\n/)}
    @go = true
    threads = []
    @ttys.each_with_index do |tty, index|
      threads << Thread.new(tty, f[index]) do |mytty, mylog|
        loop_some_log_crap(mytty, mylog)
      end
    end  
    threads.each {|t| t.join}
  end
  
  def get_tty_list(num=nil)
    if(num.nil?)
      Dir.glob("/dev/ttys00*")
    else
      if(File.exists?("/dev/ttys00#{num}"))
        ["/dev/ttys00#{num}"]
      else
        raise "/dev/ttys00#{num} does not exist"
      end
    end
  end
  
  def get_logs(how_many, dir)
    `ls -S #{dir}/*.log`.split(/\n/)[1..how_many]
  end
  
  def stop
    @go = false
    @ttys.each {|t| clear_screen(t)}
  end
end

Signal.trap("INT") do
  LogPoop.instance.stop
end

Signal.trap("TERM") do
  LogPoop.instance.stop
end