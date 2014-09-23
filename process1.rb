puts("Hello from process #{Process.pid}")
exec('uname -r')
puts("Bye from process")
