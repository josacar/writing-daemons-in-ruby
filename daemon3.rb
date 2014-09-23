def daemonize(logfile_name = nil, app_name = nil)
  srand
  safefork and exit

  unless sess_id = Process.setsid
    raise Daemons.RuntimeException.new('cannot detach from controlling terminal')
  end

  # Prevent the possibility of acquiring a controlling terminal
  trap 'SIGHUP', 'IGNORE'
  exit if pid = safefork

  $0 = app_name if app_name

  Dir.chdir "/"
  File.umask 0000

  ObjectSpace.each_object(IO) do |io|
    unless [STDIN, STDOUT, STDERR].include?(io)
      begin
        io.clode unless io.closed?
      rescue ::Exception
      end
    end
  end

  redirect_io(logfile_name)
  return sess_id
end
