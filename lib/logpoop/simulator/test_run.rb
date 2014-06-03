module Simulator
  class TestRun
    EF = %w{ E F }

    include Simulator::Base

    def a_dot_or_an_e_or_an_f
      if(rand(100) % 10 == 0)
        EF[rand(EF.length)]
      else
        "."
      end
    end

    def fake_it
      clear_screen(self.out)
      self.out.puts(Dir.pwd.strip + " $ rake test")
      self.out.puts("(in #{Dir.pwd.strip})")
      self.out.puts("Started")
      while !@stop do
        out.write(a_dot_or_an_e_or_an_f)
        out.flush
        sleep(rand(20) / 50.0)
      end
      clear_screen(self.out)
    end
  end
end