Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22151ADFFE;
	Fri, 31 Jan 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738364354; cv=none; b=K6aqJ6NRtwYguW6hC+RB71JiPIlx1IcOIZBbFB3edym9qqbYR+Bjo3d649gdj7G3+Zpp5kHn/BzJjfA76KfwZKi+VuATCVfVJnTTPaDt95uqJzRFYgGBDqlpcYbWtIw7wH/3i0Auet3/b1l/uFhcHZ/F156nSoTp0k1Es1eVW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738364354; c=relaxed/simple;
	bh=MAd2X0j647GPX4qmnxZWdWj9YoocWbOj/T2dx5j6F/k=;
	h=Message-ID:Date:From:To:Cc:Subject; b=FRCXBFAMjUewusF1SMHvRNsf00zuxFBxS/EkykTd4dPT4LuXFEibnJltmj2j69MWMyFCWlHVfMuYwIv/HAX4qqwlQfoVoNQxG13jXZQehpcV5S60XbXIG6m6WoVfzlyaJL+FnhJInJAEgcTMjJ3Ujq+qHfd7xuA9eZaubk8U71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A77C4CED1;
	Fri, 31 Jan 2025 22:59:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tdzzC-00000003vSQ-1PMb;
	Fri, 31 Jan 2025 17:59:42 -0500
Message-ID: <20250131225837.972218232@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 31 Jan 2025 17:58:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-mm@kvack.org,
 x86@kernel.org,
 akpm@linux-foundation.org,
 luto@kernel.org,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 hpa@zytor.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 willy@infradead.org,
 mgorman@suse.de,
 jon.grimm@amd.com,
 bharata@amd.com,
 raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com,
 jgross@suse.com,
 andrew.cooper3@citrix.com,
 Joel Fernandes <joel@joelfernandes.org>,
 Vineeth Pillai <vineethrp@google.com>,
 Suleiman Souhlal <suleiman@google.com>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>,
 bigeasy@linutronix.de,
 daniel.wagner@suse.com,
 joseph.salisbury@oracle.com,
 broonie@gmail.com
Subject: [RFC][PATCH 0/2] sched: Extended Scheduler Time Slice revisited
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Extended scheduler time slice

Wow, it's been over a year since I posted my original POC of this patch
series[1]. But that was when the PREEMPT_LAZY (NEED_RESCHED_LAZY) was
just being proposed and this patch set depended on that. Now that
NEED_RESCHED_LAZY is part of mainline, it's time to revisit this proposal.

Quick recap:

PREEMPT_LAZY can be used to dynamically set the preemption model of the
kernel. To emulate the old server model, if the timer tick goes off
and wants to schedule out the currently running SCHED_OTHER task,
it  will set NEED_RESCHED_LAZY. Instead of immediately scheduling,
it will only schedule when the current task is exiting to user space.
If the task runs in the kernel for over a tick, then NEED_RESCHED is
set which will force the task to schedule as soon as it is out of any
kernel critical section.

I wanted to give this feature to user space as well. This is a way for
user space to inform the kernel that it too is in a critical section
(perhaps implementing user space spin locks), and if it happens to lose
its quota and the scheduler wants to schedule it out for another SCHED_OTHER
task, it can get a little more time to release its locks.

The patches use rseq to map a new "cr_counter" field to pass this
information to the kernel. Bit 0 is reserved for the kernel, and the other
31 bits tells the kernel that the task is in a critical section. If any of
those 31 bits is set, the kernel will try to extend the tasks time slice if
it deems fit to do so (not guaranteed of course).

The 31 bits allows the task to implement a counter. Note that this rseq
memory is per thread so it does not need to worry about racing with other
threads. But it does need to worry about racing with the kernel, so the
incrementing or decrementing of this value should be done local atomically.
(Like with a simple addl or subl in x86, not a read/modify/write).

The counter lets user space add 2 to the cr_counter (skipping over bit 0)
when it enters a critical section and subtract 2 when it leaves. If the
counter is 1, then it knows that the kernel extended its time slice and it
should immediately schedule by doing a system call (yield() but any system
call will work too). If it does not, the kernel will force a schedule on the
next scheduler tick.

The first patch implements this and gives the task 1 more tick just like
the kernel does before it forces a schedule. But this means user space can
ask for a full millisecond up to 10 milliseconds depending on CONFIG_HZ.

The second patch is based off of Peter Zijlstra's patch[2], that injects
a 50us scheduler tick when it extends the task's slice. This way the most
a task will get is 50us extra, which hopefully would not bother other
task's latency. Note, that the way EEVDF works, the task will get penalized
by losing out on eligibility, and even if it does get a little more time,
it may be scheduled less often.


I removed POC as I no longer believe this is simply a proof-of-concept.
But it is still RFC, and the patches contain trace_printk() in them
to see if it is indeed working, as well as to analyze the results of
my tests. Those trace_printk()s will be removed if this gets accepted.


I wrote a program[3] to micro-benchmark this. What the program does
is to create one thread per CPU that will grab a user space spin lock,
run in a loop for around 30us and release the spin lock. Then it will
go to sleep for "100 + cpu * 27" microseconds before it wakes up and
tries again. This is to try to stagger the different threads. Each
of these threads are pinned to their corresponding CPU.

5 more threads are created on each CPU that does the following:

        while (!data->done) {
                for (i = 0; i < 100; i++)
                        wmb();
                do_sleep(10); 
                rmb();
        }

Where do_sleep(10) will sleep for 10us. This causes a lot of scheduling
on SCHED_OTHER tasks.

This program keeps track of:

 - Total number of loops iterated by the threads that are taking the lock
 - The total time it waited to get a lock (and the average time)
 - The number of times the lock was contented.
 - The max time it waited to get a lock
 - The max time it held the lock (and the average time it held a lock).
 - It also keeps track of the number of times its time slice was extended

It takes two parameters:

  -d disable using rseq to tell the kernel to extend the lock
  -w Keep it "extended" even while waiting for the lock

Note -w is meaningless with -d, and is really added as an academic exercise
as waiting for a critical section isn't necessary a critical section.

It runs for 5 seconds and then stops. So all numbers are for a 5 second
duration.

Without rseq enabled, we had:

for i in `seq 10` ; do ./extend-sched -d ; done
Finish up
Ran for 105278 times
Total wait time: 7.657703  (avg: 0.000072)
Total contention: 88661
Total extended: 0
      max wait: 1410
           max: 328 (avg: 43)
Finish up
Ran for 106703 times
Total wait time: 7.371958  (avg: 0.000069)
Total contention: 89252
Total extended: 0
      max wait: 1822
           max: 410 (avg: 42)
Finish up
Ran for 106679 times
Total wait time: 7.344924  (avg: 0.000068)
Total contention: 89003
Total extended: 0
      max wait: 1499
           max: 338 (avg: 42)
Finish up
Ran for 106512 times
Total wait time: 7.398154  (avg: 0.000069)
Total contention: 89323
Total extended: 0
      max wait: 1231
           max: 334 (avg: 42)
Finish up
Ran for 106686 times
Total wait time: 7.369875  (avg: 0.000069)
Total contention: 89141
Total extended: 0
      max wait: 1606
           max: 448 (avg: 42)
Finish up
Ran for 106291 times
Total wait time: 7.464811  (avg: 0.000070)
Total contention: 89244
Total extended: 0
      max wait: 1727
           max: 373 (avg: 42)
Finish up
Ran for 106230 times
Total wait time: 7.467716  (avg: 0.000070)
Total contention: 88950
Total extended: 0
      max wait: 4084
           max: 377 (avg: 42)
Finish up
Ran for 106699 times
Total wait time: 7.369399  (avg: 0.000069)
Total contention: 89085
Total extended: 0
      max wait: 1415
           max: 348 (avg: 42)
Finish up
Ran for 106648 times
Total wait time: 7.352611  (avg: 0.000068)
Total contention: 89202
Total extended: 0
      max wait: 1177
           max: 377 (avg: 42)
Finish up
Ran for 106532 times
Total wait time: 7.363098  (avg: 0.000069)
Total contention: 89009
Total extended: 0
      max wait: 1454
           max: 429 (avg: 42)


Now with a 50us slice extension with rseq:

for i in `seq 10` ; do ./extend-sched ; done
Finish up
Ran for 121185 times
Total wait time: 3.450114  (avg: 0.000028)
Total contention: 84405
Total extended: 19879
      max wait: 652
           max: 174 (avg: 32)
Finish up
Ran for 120842 times
Total wait time: 3.474066  (avg: 0.000028)
Total contention: 84338
Total extended: 20450
      max wait: 487
           max: 181 (avg: 32)
Finish up
Ran for 120814 times
Total wait time: 3.473712  (avg: 0.000028)
Total contention: 83938
Total extended: 20418
      max wait: 631
           max: 185 (avg: 32)
Finish up
Ran for 120918 times
Total wait time: 3.442310  (avg: 0.000028)
Total contention: 83921
Total extended: 20246
      max wait: 511
           max: 172 (avg: 32)
Finish up
Ran for 120685 times
Total wait time: 3.426023  (avg: 0.000028)
Total contention: 83327
Total extended: 20504
      max wait: 488
           max: 161 (avg: 32)
Finish up
Ran for 120873 times
Total wait time: 3.477329  (avg: 0.000028)
Total contention: 84139
Total extended: 20808
      max wait: 551
           max: 172 (avg: 32)
Finish up
Ran for 120667 times
Total wait time: 3.491623  (avg: 0.000028)
Total contention: 84004
Total extended: 20585
      max wait: 554
           max: 170 (avg: 32)
Finish up
Ran for 121595 times
Total wait time: 3.446635  (avg: 0.000028)
Total contention: 84568
Total extended: 20258
      max wait: 543
           max: 166 (avg: 32)
Finish up
Ran for 121729 times
Total wait time: 3.437635  (avg: 0.000028)
Total contention: 84825
Total extended: 20143
      max wait: 497
           max: 165 (avg: 32)
Finish up
Ran for 121545 times
Total wait time: 3.452991  (avg: 0.000028)
Total contention: 84583
Total extended: 20186
      max wait: 578
           max: 161 (avg: 32)


The averages of the 10 runs:

No extensions:

  avg iterations: 106426
  avg total wait: 7.416025 seconds
    avg avg wait: 0.000069 seconds
      contention: 89087
        max wait: 1742 us
             max: 376.2 us
         avg max: 42 us

With rseq extension:

  avg iterations: 121085
  avg total wait: 3.457244 seconds
    avg avg wait: 0.000028 seconds
      contention: 84205
        max wait: 549 us
             max: 171 us
         avg max: 32 us
        extended: 20347

This shows that with a 50us extra time slice

It was able to run 14659 more iteration (+13.7%)
It waited a total of 3.958781 seconds less (-53.3%)
The average wait time was 41us less (-59.4%)
It had 4882 less contentions (-5.4%)
It had 1193us less max wait time (-31.5%)
It held the lock for 205.2us less (-54.5%)
And the average time it held the lock was 10us less (-23.8%)

After running the extend version, I looked at ftrace to see if
it hit the 50us max:

 # trace-cmd show | grep force
    extend-sched-29816   [000] dBH.. 76942.819849: rseq_delay_resched_tick: timeout -- force resched
    extend-sched-29865   [000] dbh.. 76944.151878: rseq_delay_resched_tick: timeout -- force resched
    extend-sched-29865   [000] dBh.. 76945.266837: rseq_delay_resched_tick: timeout -- force resched
    extend-sched-29865   [000] dBh.. 76946.182833: rseq_delay_resched_tick: timeout -- force resched

It did so 4 times.


For kicks, here's the run with '-w' where it sets the rseq extend
while it spins for waiting for a lock. I would not recommend this
even if it does help. Why extend when it is safe to preempt?



for i in `seq 10` ; do ./extend-sched -w ; done
Finish up
Ran for 120111 times
Total wait time: 3.389300  (avg: 0.000028)
Total contention: 83406
Total extended: 23539
      max wait: 438
           max: 176 (avg: 32)
Finish up
Ran for 120241 times
Total wait time: 3.377985  (avg: 0.000028)
Total contention: 83586
Total extended: 23458
      max wait: 453
           max: 246 (avg: 32)
Finish up
Ran for 120140 times
Total wait time: 3.391172  (avg: 0.000028)
Total contention: 83234
Total extended: 23571
      max wait: 446
           max: 195 (avg: 32)
Finish up
Ran for 120100 times
Total wait time: 3.366652  (avg: 0.000028)
Total contention: 83088
Total extended: 23256
      max wait: 2710
           max: 2592 (avg: 32)
Finish up
Ran for 120373 times
Total wait time: 3.372495  (avg: 0.000028)
Total contention: 83405
Total extended: 23657
      max wait: 460
           max: 164 (avg: 32)
Finish up
Ran for 120332 times
Total wait time: 3.389414  (avg: 0.000028)
Total contention: 83752
Total extended: 23487
      max wait: 498
           max: 223 (avg: 32)
Finish up
Ran for 120411 times
Total wait time: 3.357409  (avg: 0.000027)
Total contention: 83371
Total extended: 23349
      max wait: 423
           max: 175 (avg: 32)
Finish up
Ran for 120258 times
Total wait time: 3.376960  (avg: 0.000028)
Total contention: 83595
Total extended: 23454
      max wait: 385
           max: 164 (avg: 32)
Finish up
Ran for 120407 times
Total wait time: 3.366934  (avg: 0.000027)
Total contention: 83649
Total extended: 23351
      max wait: 446
           max: 164 (avg: 32)
Finish up
Ran for 120397 times
Total wait time: 3.395540  (avg: 0.000028)
Total contention: 83859
Total extended: 23513
      max wait: 469
           max: 172 (avg: 32)

Again, I would not recommend this, as after running this I looked
at the trace again to see if it hit the max 50us (I did reset the buffer
before running), and I had this:

 # trace-cmd show | grep force | wc -l
 19697


[1] https://lore.kernel.org/all/20231025054219.1acaa3dd@gandalf.local.home/
[2] https://lore.kernel.org/all/20231030132949.GA38123@noisy.programming.kicks-ass.net/
[3] https://rostedt.org/code/extend-sched.c

Steven Rostedt (2):
      sched: Shorten time that tasks can extend their time slice for
      sched: Extended scheduler time slice

----
 include/linux/entry-common.h |  2 +
 include/linux/sched.h        | 19 +++++++++
 include/uapi/linux/rseq.h    | 24 +++++++++++
 kernel/entry/common.c        | 16 +++++++-
 kernel/rseq.c                | 96 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c          | 16 ++++++++
 kernel/sched/syscalls.c      |  6 +++
 7 files changed, 177 insertions(+), 2 deletions(-)
