logpoop
=======

Logpoop has three poopy modes: test, tail eff, and poop. 

In the case of anything that fills up your terminal with garbage logs, logpoop will chose the largest logfiles from either `/var/log` or the directory you specify (using the `-d` flag).

## test

    logpoop -t test [-d LOG_DIR]

Test mode "runs some unit tests" in one terminal and "tails some log file" in another terminal.  Realistic! You are so busy running your tests!  

![Test Mode](http://unclebilly.github.com/logpoop/images/test.png)

## tail eff
  
    logpoop [-d DIR]

Tail eff mode grabs a bunch of log files (either from a folder you specify or
from /var/log) and simulates "tail -f" in all of your open terminals, while
varying the speed and intensity.  Whoa, don't bother me - I'm busy!  Move away, plebes.

![Tail Eff Mode](http://unclebilly.github.com/logpoop/images/tail_eff.png)

## poop

    logpoop -t poop

Prints a random ASCII poop in your terminal. OK, so this isn't so useful - but then, neither are you (right now).

![Poop Mode](http://unclebilly.github.com/logpoop/images/poop.png)

# Installation
    
    [sudo] gem install logpoop
 
# Help
    
    logpoop --help
  
# Copyright
Copyright (c) 2011 Billy Reisinger. See LICENSE.txt for
further details. LOL

