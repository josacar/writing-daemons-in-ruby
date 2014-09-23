Process.daemon
socket = TCPServer.open('0.0.0.0', 8080)
wpids = []

logger = Logger.new('/tmp/logger.log')
logger.level = Logger::INFO

5.times do
  wpids << fork do
    run = true
    [:INT, :QUIT].each do |signal|
      Signal.trap(signal, lambda { run = false })
    end
    while run
      connection = socket.accept
      connection.puts("Hello from #{Process.pid}")
      logger.info("Connection in #{Process.pid}")
      sleep 10
      connection.puts("Goodbye from #{Process.pid}")
      connection.close
    end
  end
end

[:INT, :QUIT].each do |signal|
  Signal.trap(signal) do
    wpids.each { |wpid| Process.kill(signal, wpid) }
  end
end
Process.waitall
logger.close
