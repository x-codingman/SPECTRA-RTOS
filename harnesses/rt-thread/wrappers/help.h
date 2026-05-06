typedef unsigned long time_t;


typedef struct file_struct
{
    int fs_fd;
    int fs_counts;
    unsigned char *fs_bufstart;
    unsigned char *fs_bufend;
    unsigned char *fs_bufpos;
} FILE;

typedef struct sigevent
  {
    __sigval_t sigev_value;
    int sigev_signo;
    int sigev_notify;

    union
      {
	int _pad[__SIGEV_PAD_SIZE];

	/* When SIGEV_SIGNAL and SIGEV_THREAD_ID set, LWP ID of the
	   thread to receive the signal.  */
	__pid_t _tid;

	struct
	  {
	    void (*_function) (__sigval_t);	/* Function to start.  */
	    pthread_attr_t *_attribute;		/* Thread attributes.  */
	  } _sigev_thread;
      } _sigev_un;
  } sigevent_t;

struct siginfo
{
    uint16_t si_signo;
    uint16_t si_code;
    union sigval si_value;
};
union sigval
{
  int sival_int;
  void *sival_ptr;
};
typedef struct siginfo siginfo_t;
struct timespec
{
    time_t  tv_sec;     /* seconds */
    long    tv_nsec;    /* and nanoseconds */
};
struct timeval
{
  __time_t tv_sec;		/* Seconds.  */
  __suseconds_t tv_usec;	/* Microseconds.  */
};

struct itimerspec
  {
    struct timespec it_interval;
    struct timespec it_value;
  };