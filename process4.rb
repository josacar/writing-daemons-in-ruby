pipe_me_in, pipe_child_out = IO.pipe
pipe_child_in, _ = IO.pipe

fork do
  STDIN.reopen(pipe_child_in)
  STDOUT.reopen(pipe_child_out)
  exec("echo valencia.rb")
end

pipe_child_out.close
puts(pipe_me_in.read)
