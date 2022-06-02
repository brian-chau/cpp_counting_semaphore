# cpp_counting_semaphore

Personal Notes:

Mutexes:

1. A device to protect a shared resource from simultaeneous accesses of a shared resource across multiple threads or processes
2. Must be acquired by the thread before use of the shared resource, and released by the same thread after use of the shared resource

Binary Semaphore:

1. A signaling device across multiple threads/processes
2. Used for synchronization
3. Example: Task A in thread 1 needs to happen before Task B in thread 2

| Time        | Thread 1    | Thread 2         |
| ----------- | ----------- | ---------------- |
| 0           | Task A      | waiting for sync |
| 1           | signal sync | -                |
| 2           | -           | Task B           |