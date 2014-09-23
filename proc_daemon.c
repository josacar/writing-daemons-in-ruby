static VALUE proc_daemon(int argc, VALUE argv) {
  VALUE nochdir, noclose;
  int n;

  rb_secure(2);
  rb_scan_args(argc, argv, "02", &nochdir, &noclose);

  prefork();
  before_fork();
  n = daemon(RTEST(nochdir), RTEST(noclose));
  after_fork();
  if (n < 0) rb_sys_fail("daemon");
  return INT2FIX(n);
}

#define daemon(nochdir, noclose) rb_daemon(nochdir, noclose)
#endif
