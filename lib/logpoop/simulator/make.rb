module Simulator
  class Make
    include Simulator::Base

    HEADERS = Dir["/usr/local/include/*.h"]

    def fake_it
      while !@stop do
        string, wait = next_iteration
        self.out.puts string
        sleep wait
      end
    end

    private
    def next_iteration
      @progress ||= 1
      if (@progress += 1) < 1000
        [configure, rand(0.001..0.2)]
      else
        [make, rand(0.001..1.5)]
      end
    end

    def configure
      check(random_header)
    end

    def make
      out = "compiling #{random_source}"
      out += random_message if rand(100) % 12 == 0
      out
    end

    def random_source
      random_header.gsub(/\.h$/,'.c')
    end

    def random_header
      HEADERS[rand(HEADERS.length)].split("/").last
    end

    def check(header)
      something = ['yes','yes','yes','yes','no'][rand(5)]
      "checking for #{header}... #{something}"
    end

    def random_library
      random_header.gsub(/\.h$/,'')
    end

    def random_message
      @messages ||= [
        "installing default #{random_library} libraries",
        "make[2]: Nothing to be done for `all'.",
        "linking shared-object",
        "3859: warning: implicit conversion shortens 64-bit value into a 32-bit value"
      ]
      @messages[rand(@messages.length)]
    end
  end
end