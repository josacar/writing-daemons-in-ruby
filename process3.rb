puts("I am process #{Process.pid}")
pid = fork do
  puts("I am process #{Process.pid}, my parent is #{Process.ppid}")
end

puts("I am process #{Process.pid}, I am waiting for process #{pid}")
Process.wait(pid)
