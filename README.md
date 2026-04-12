# Amaranth Scheduler

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue?logo=gnu&logoColor=white)](https://www.gnu.org/licenses/agpl-3.0)
[![JUnit Tests](https://github.com/jimlind/amaranth-scheduler/actions/workflows/run-junit-test.yml/badge.svg)](https://github.com/jimlind/amaranth-scheduler/actions/workflows/run-junit-test.yml)
[![PMD Static Analysis](https://github.com/jimlind/amaranth-scheduler/actions/workflows/run-static-analysis.yml/badge.svg)](https://github.com/jimlind/amaranth-scheduler/actions/workflows/run-static-analysis.yml)

An Unfading Java Scheduler

## Overview

Amaranth is a Java library for scheduling tasks. Because ScheduledExecutorService has a tendency to fail and exit
silently I created this fairly dumb wrapper that enforces timeouts, allow easy logging, can restart the task under some
circumstances.

It supports two different task types:

- **Fixed delay tasks** - execute with a delay between the each execution.
- **Fixed rate tasks** - execute at a fixed interval regardless of how long the task takes

## Installation

```xml

<dependency>
    <groupId>io.github.jimlind</groupId>
    <artifactId>amaranth</artifactId>
    <version>0.0.25</version>
</dependency>
```

## Usage

### Creating a Task

Extend `FixedDelayTask` or `FixedRateTask` and implement the `runTask()` method and optionally overriding the
exceptionConsumer if you want to log exceptions:

```java
import io.github.jimlind.amaranth.task.FixedDelayTask;

public class MyTask extends FixedDelayTask {

  public MyTask() {
    // initialDelayMs, subsequentDelayMs, timeoutMs
    super(1000, 5000, 30000);
  }

  @Override
  protected void runTask() {
    // Your task logic here
    System.out.println("Task executed!");
  }

  @Override
  protected void exceptionConsumer(TaskException exception) {
    if (exception instanceof TaskTimeoutException) {
      // Handle timeout
    } else if (exception instanceof TaskInterruptionException) {
      // Handle interruption
    } else if (exception instanceof TaskSeriousException) {
      // Handle serious errors (Errors)
    } else {
      // Handle general exceptions
    }
  }
}
```

### Starting Tasks with Scheduler

Use the `Scheduler` to add tasks so the and call `startAll` to kick off the processes:

```java
import io.github.jimlind.amaranth.Scheduler;

Scheduler scheduler = new Scheduler();
scheduler.

addTask(new MyTask());
        scheduler.

startAll();
```

## License

GNU Affero General Public License v3.0 - See [LICENSE](LICENSE)