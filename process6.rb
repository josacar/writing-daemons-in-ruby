trap(:KILL) do
  puts('I am not going to die!')
end
puts('Trying to kill myself')
Process.kill(:KILL, Process.pid)
puts('I should be alive')
