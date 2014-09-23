static VALUE proc_setpgrp(void) {
  rb_secure(2);
  /* check for posix setpgid() first; this matches the posix */
  /* getpgrp() above.  It appears that configure will set SETPGRP_VOID */
  /* even though setpgrp(0,0) would be preferred. The posix call avoids */
  /* this confusion. */
#ifdef HAVE_SETPGID
  if (setpgid(0,0) < 0) rb_sys_fail(0);
#elif defined(HAVE_SETPGRP) && defined(SETPGRP_VOID)
  if (setpgrp() < 0) rb_sys_fail(0);
#endif
  return INT2FIX(0);
}
#endif
