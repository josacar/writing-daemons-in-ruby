def handle_signal(signal)
  puts("Received #{signal}")
end

self_read, self_write = IO.pipe

%w(INT TERM).each do |sig|
  trap(sig) { self_write.puts(sig) }
end

while readable_io = IO.select([self_read])
  signal = readable_io.first[0].gets.strip
  handle_signal(signal)
end
