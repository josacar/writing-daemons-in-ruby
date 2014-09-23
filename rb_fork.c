rb_pid_t rb_fork(int *status, int (*chfunc)(void*), void *charg, VALUE fds) {
  if (chfunc) {
    struct chfunc_wrapper_t warg;
    warg.chfunc = chfunc;
    warg.arg = charg;
    return rb_fork_err(status, chfunc_wrapper, &warg, fds, NULL, 0);
  } else {
    return rb_fork_err(status, NULL, NULL, fds, NULL, 0);
  }
}
