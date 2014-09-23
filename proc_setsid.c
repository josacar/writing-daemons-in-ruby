static VALUE proc_setsid(void) {
  rb_pid_t pid;

  rb_secure(2);
  pid = setsid();
  if (pid < 0) rb_sys_fail(0);
  return PIDT2NUM(pid);
}

#define setsid() ruby_setsid()
