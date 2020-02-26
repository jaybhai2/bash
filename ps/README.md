# shell-scripts

### sort by start_time asc
####  ps -aux --sort=start_time | tail -n10

### sort by memory usage 
#### ps aux --sort -rss    // desc
#### ps aux --sort rss     // remove '-' to sort asc

### ps aux --sort -pid
### ps -eo pid,user,%cpu,%mem,time,ruid,etime,bsdstart --sort -%mem | head -n10

### check free memory
## free -m
## cat /proc/meminfo
## top
https://alvinalexander.com/linux/unix-linux-process-memory-sort-ps-command-cpu
```
STANDARD FORMAT SPECIFIERS

Here are the different keywords that may be used to control the output format (e.g. with option -o) or to sort the
selected processes with the GNU-style --sort option.

For example:  ps -eo pid,user,args --sort user

This version of ps tries to recognize most of the keywords used in other implementations of ps.

The following user-defined format specifiers may contain spaces: args, cmd, comm, command, fname, ucmd, ucomm, lstart,
bsdstart, start.

Some keywords may not be available for sorting.

CODE       HEADER   DESCRIPTION

%cpu       %CPU     cpu utilization of the process in "##.#" format. Currently, it is the CPU time used divided by the
                    time the process has been running (cputime/realtime ratio), expressed as a percentage. It will not
                    add up to 100% unless you are lucky. (alias pcpu).

%mem       %MEM     ratio of the process’s resident set size  to the physical memory on the machine, expressed as a
                    percentage. (alias pmem).

bsdstart   START    time the command started. If the process was started less than 24 hours ago, the output format is
                    " HH:MM", else it is "mmm dd" (where mmm is the three letters of the month).

bsdtime    TIME     accumulated cpu time, user + system. The display format is usually "MMM:SS", but can be shifted to
                    the right if the process used more than 999 minutes of cpu time.

c          C        processor utilization. Currently, this is the integer value of the percent usage over the lifetime
                    of the process. (see %cpu).

comm       COMMAND  command name (only the executable name). Modifications to the command name will not be shown.
                    A process marked <defunct> is partly dead, waiting to be fully destroyed by its parent. The output
                    in this column may contain spaces. (alias ucmd, ucomm). See also the args format keyword, the -f
                    option, and the c option.
                    When specified last, this column will extend to the edge of the display. If ps can not determine
                    display width, as when output is redirected (piped) into a file or another command, the output
                    width is undefined. (it may be 80, unlimited, determined by the TERM variable, and so on) The
                    COLUMNS environment variable or --cols option may be used to exactly determine the width in this
                    case. The w or -w option may be also be used to adjust width.

command    COMMAND  see args. (alias args, cmd).

cp         CP       per-mill (tenths of a percent) CPU usage. (see %cpu).

cputime    TIME     cumulative CPU time, "[dd-]hh:mm:ss" format. (alias time).

egroup     EGROUP   effective group ID of the process. This will be the textual group ID, if it can be obtained and
                    the field width permits, or a decimal representation otherwise. (alias group).

etime      ELAPSED  elapsed time since the process was started, in the form [[dd-]hh:]mm:ss.

euid       EUID     effective user ID. (alias uid).

euser      EUSER    effective user name. This will be the textual user ID, if it can be obtained and the field width
                    permits, or a decimal representation otherwise. The n option can be used to force the decimal
                    representation. (alias uname, user).

gid        GID      see egid. (alias egid).

lstart     STARTED  time the command started.

ni         NI       nice value. This ranges from 19 (nicest) to -20 (not nice to others), see nice(1). (alias nice).

pcpu       %CPU     see %cpu. (alias %cpu).

pgid       PGID     process group ID or, equivalently, the process ID of the process group leader. (alias pgrp).

pid        PID      process ID number of the process.

pmem       %MEM     see %mem. (alias %mem).

ppid       PPID     parent process ID.

rss        RSS      resident set size, the non-swapped physical memory that a task has used (in kiloBytes).
                    (alias rssize, rsz).

ruid       RUID     real user ID.

size       SZ       approximate amount of swap space that would be required if the process were to dirty all writable
                    pages and then be swapped out. This number is very rough!

start      STARTED  time the command started. If the process was started less than 24 hours ago, the output format is
                    "HH:MM:SS", else it is "  mmm dd" (where mmm is a three-letter month name).

sz         SZ       size in physical pages of the core image of the process. This includes text, data, and stack
                    space. Device mappings are currently excluded; this is subject to change. See vsz and rss.

time       TIME     cumulative CPU time, "[dd-]hh:mm:ss" format. (alias cputime).

tname      TTY      controlling tty (terminal). (alias tt, tty).

vsz        VSZ      virtual memory size of the process in KiB (1024-byte units). Device mappings are currently
                    excluded; this is subject to change. (alias vsize).
```
