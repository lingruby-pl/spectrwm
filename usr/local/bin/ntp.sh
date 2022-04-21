#!/bin/sh
  (
  /usr/bin/ntpdate vega.cbk.poznan.pl \
                   zegar.umk.pl \
                   ntp.nask.pl \
                   time.atman.pl \
                   ntp.task.gda.pl \
  
  
  /usr/bin/hwclock --systohc
  ) >/dev/null
