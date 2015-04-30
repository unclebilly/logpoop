module Simulator
  class Print
    include Simulator::Base

    def fake_it
      while !@stop do
        @out.puts make_text(@text)
        sleep rand(0.01..0.1)
      end
      clear_screen(@out)
    end

    def initialize(out, text, cols)
      @out  = out  # terminal
      @text = text # text to print
      @cols = cols # width of this terminal
    end

    def make_text(t)
      width       = rand((@cols - 5)..@cols)
      times       = width / (t.length + 1) # 1 is for space
      front_space = (' ' * (@cols - width))
      words       = times.times.map{ maybe_mess_with(t) }.join(' ')
      front_space + words
    end

    def maybe_mess_with(t)
      if rand(2) == 1
        t.each_char.map do |a|
          if rand(2) == 1
            a.upcase
          else
            a.downcase
          end
        end.join('')
      else
        t
      end    
    end
  end
end
