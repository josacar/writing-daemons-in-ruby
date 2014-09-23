rb_pid_t rb_fork_err(int *status, int (*chfunc)(void*, char *, size_t),
    void *charg, VALUE fds, char *errmsg, size_t errmsg_buflen) {
  rb_pid_t pid;
  int err, state = 0;

#define prefork() (define\
    rb_io_flush(rb_stdout), \
    rb_io_flush(rb_stderr)rb_stderr\
    )
  prefork();
  // STUFF
  for (; before_fork(), (pid = fork()) < 0; prefork()) {
    after_fork();
    // STUFF
  }
  if (!pid) {
    forked_child = 1;
    if (chfunc) {
      if (!(*chfunc)(charg, errmsg, errmsg_buflen)) _exit(EXIT_SUCCESS);
#if EXIT_SUCCESS == 127
      _exit(EXIT_FAILURE);
#else
      _exit(127);
#endif
    }
  }
  after_fork();
  return pid;
}

