def daemonize_app
  exit if fork
  Process.setsid
  exit if fork
  Dir.chdir("/")
  STDIN.reopen("/dev/null")
  STDOUT.reopen("/dev/null", "a")
  STDERR.reopen("/dev/null", "a")
end
