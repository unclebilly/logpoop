# Encoding: utf-8

module Runner
  class Poop
    def run
      puts poop
    end
  

    private
    def poop
      files = Dir[File.expand_path("../../poops/*poop", __FILE__)]
      File.read(files[rand(files.length)])
    end
  end
end