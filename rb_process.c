static int rb_daemon(int nochdir, int noclose) {
  int n, err = 0;

  switch (rb_fork(0, 0, 0, Qnil)) {
    case -1:
      rb_sys_fail("daemon");
    case 0:
      break;
    default:
      _exit(EXIT_SUCCESS);
  }

  proc_setsid();

  switch (rb_fork(0, 0, 0, Qnil)) {
    case -1:
      return -1;
    case 0:
      break;
    default:
      _exit(EXIT_SUCCESS);
  }

  if (!nochdir) err = chdir("/");

  if (!noclose && (n = open("/dev/null", O_RDWR, 0)) != -1) {
    (void)dup2(n, 0);
    (void)dup2(n, 1);
    (void)dup2(n, 2);
    if (n > 2) (void)close (n);
  }
  return err;
}
