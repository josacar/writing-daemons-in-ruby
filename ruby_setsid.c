static rb_pid_t ruby_setsid(void) {
  rb_pid_t pid;
  int ret;

  pid = getpid();
#if defined(SETPGRP_VOID)
  ret = setpgrp();
  /* If `pid_t setpgrp(void)' is equivalent to setsid(),
   * `ret' will be the same value as `pid', and following open() will fail.
   * In Linux, `int setpgrp(void)' is equivalent to setpgid(0, 0). */
#else
  ret = setpgrp(0, pid);
#endif
  if (ret == -1) return -1;

  if ((fd = open("/dev/tty", O_RDWR)) >= 0) {
    ioctl(fd, TIOCNOTTY, NULL);
    close(fd);
  }
  return pid;
}
#endif
