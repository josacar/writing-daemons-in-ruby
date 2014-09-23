configuration.trap("HUP") {
  DaemonKit::Application.reopen_logs
}

module DaemonKit
  class Application
    def reopen_logs
      nr = 0
      append_flags = File::WRONLY | File::APPEND
      DaemonKit.logger.info "Rotating logs" if DaemonKit.logger

      ObjectSpace.each_object(File) do |fp|
        next if fp.closed?
        next unless (fp.sync && fp.path[0..0] == "/")
        next unless (fp.fcntl(Fcntl::F_GETFL) & append_flags) == append_flags

        begin
          a, b = fp.stat, File.stat(fp.path)
          next if a.ino == b.ino && a.dev == b.dev
        rescue Errno::ENOENT
        end

        open_arg = 'a'
        if fp.respond_to?(:external_encoding) && enc = fp.external_encoding
          open_arg << ":#{enc.to_s}"
          enc = fp.internal_encoding and open_arg << ":#{enc.to_s}"
        end
        DaemonKit.logger.info "Rotating path: #{fp.path}" if DaemonKit.logger
        fp.reopen(fp.path, open_arg)
        fp.sync = true
        nr += 1
      end # each_object
      nr
    end
  end
end
