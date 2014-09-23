def print_process_info
  puts("PID: #{Process.pid} PPID: #{Process.ppid} SID: #{Process.getsid} PGRP: #{Process.getpgrp}")
end

print_process_info
exit if fork
print_process_info
Process.getsid
print_process_info
exit if fork
print_process_info
