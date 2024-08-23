Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142F1755C;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377186; cv=none; b=E/tIEKWRobg1MW7j/Umis5O2Ia7BOW/is3U6DVC83iMyb/zbJfPHbaO/OZF2j9kfpnUMMSdlnQmZyOSET25P65wVQG+qLylspusVnZS0l9QBb67T6a3fPqRoVfYBZNftANJDoubbekVzeoPmIJmmLLTpL/8amhMBU47Cg6yPl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377186; c=relaxed/simple;
	bh=v/HA6AqybZOCybS77U+9o6ictMaHC1hErdyv37BrgTs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=E6DGfzZ57qCR8/CqmS0JDIG+WieTeEzbbUPSyJMsCq+GJ/TXAWQFlEzMMymTL5hC7YZNynAplzcf8Ve4Ptg9WELq5ahUZxC7epRaukat3gUYXlBJ8GLs9eW9WR/Ave67XAY/6Hp1xmqBTCs6/w/u4Lm6sxEtYGmkJhDGQkj5BwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B4FC32782;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1shJHn-00000003Zgb-06Bz;
	Thu, 22 Aug 2024 21:40:19 -0400
Message-ID: <20240823013902.135036960@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 22 Aug 2024 21:39:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 Kees Cook <keescook@chromium.org>,
 Alexander Aring <aahringo@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>
Subject: [PATCH 0/5] tracing: Allow trace_printk() to use the persistent ring buffer
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

[ Take-two because I had an extra comma at the end of my Cc list
  for sending via quilt ]

While debugging the rtla and timerlat issue[1], I started using
trace_printk() to see what was happening as the task_struct was randomly
being corrupted. But the reproducer to this bug would cause a kernel crash.
I wanted to try the new persistent ring buffer (which has not been merged
yet), to debug this. As I was using trace_printk(), I needed the
trace_printk() to write into this buffer.

trace_printk() currently only writes into the top trace buffer, and I didn't
want to use the trace_array_printk() for this, as it seemed too clunky.
Instead, I wrote up this patch series that allows an instance created on the
kernel command line to be used as the trace_printk destination buffer.

To accomplish this, I needed a way to add an option to the trace_instance
command line. I created "flags" to modify the trace instance after it is
created. If the trace_instance has a "^<flag>" in its name, it is parsed as
a flag.

  reserve_mem=12M:4096:trace  trace_instance=boot_map^traceprintk@trace

The "^traceprintk" would tell the kernel to use the boot_map instance as the
location of the trace_printk(). Now when the kernel crashed, the boot
instance would have the trace_printk() output.

Note, when I first did this, the kernel crashed when reading the boot
buffer, as the trace_printk() would default into using the trace_bprintk()
which saves the pointer to the format string and the raw arguments in the
buffer. On reading it, it would try to read the pointer where the format
string was located at in the previous kernel and crashed. To solve this, I
added a flag to the trace_array to denote that it is a boot trace buffer,
and if it is set, then the binary trace_printks will call the version that
does the formatting before adding it to the buffer. This may be slightly
slower, but it's safer.

I also noticed that using trace_printk() in the boot buffer, it would write
to the buffer on the boot after the crash. This caused events to be listed
in the buffer to be mixed between two kernels, and it was really confusing
to read. I added another boot time flag to have the tracing instance boot
with tracing disabled.

  trace_instance=boot_map^traceoff^traceprintk@trace

With this, and enabling the printk console trace event in the boot buffer, I
got nice traces like this:

 # trace-cmd start -B boot_map -e printk
 # <run test to crash kernel>
[CRASH / REBOOT ]
 # trace-cmd show -B boot_map
[..]
          <idle>-0       [004] dNh1.    45.277163: timerlat_irq: exit timer no restart
           <...>-910     [007] ....1    45.277201: wait_next_period.isra.0: hrtimer start ffff88823c7b5b28
           <...>-907     [004] ....1    45.277206: wait_next_period.isra.0: hrtimer start ffff88823c635b28
           <...>-905     [003] ....1    45.277240: timerlat_fd_release: OSN_VAR KTHREAD [3] timerlatu/3:905 ffff88810d5f4500
           <...>-920     [003] .....    45.277316: stop_kthread: kill timerlatu/3:905 ffff88810d5f4500
           <...>-920     [003] .....    45.277348: stop_kthread: OSN_VAR KTHREAD [4] timerlatu/4:907 ffff8881104ae780
           <...>-920     [003] .....    45.277357: stop_kthread: kill timerlatu/4:907 ffff8881104ae780
           <...>-920     [003] .....    45.277358: stop_kthread: OSN_VAR KTHREAD [5] timerlatu/5:908 ffff8881104aa280
           <...>-920     [003] .....    45.277365: stop_kthread: kill timerlatu/5:908 ffff8881104aa280
           <...>-920     [003] .....    45.277367: stop_kthread: OSN_VAR KTHREAD [6] timerlatu/6:909 ffff8881104ab3c0
           <...>-920     [003] .....    45.277375: stop_kthread: kill timerlatu/6:909 ffff8881104ab3c0
           <...>-920     [003] .....    45.277377: stop_kthread: OSN_VAR KTHREAD [7] timerlatu/7:910 ffff8881104a9140
           <...>-920     [003] .....    45.277386: stop_kthread: kill timerlatu/7:910 ffff8881104a9140
           <...>-909     [006] d.h1.    45.277556: timerlat_irq: enter timer
           <...>-909     [006] d.h1.    45.277561: timerlat_irq: exit timer no restart
           <...>-908     [005] d.h1.    45.277919: timerlat_irq: enter timer
           <...>-908     [005] d.h1.    45.277923: timerlat_irq: exit timer no restart
           <...>-907     [004] d.h1.    45.278080: timerlat_irq: enter timer
           <...>-910     [007] d.h1.    45.278081: timerlat_irq: enter timer
           <...>-907     [004] d.h1.    45.278083: timerlat_irq: exit timer no restart
           <...>-910     [007] d.h1.    45.278084: timerlat_irq: exit timer no restart
           <...>-1       [002] d..1.    45.278665: console: ==================================================================
           <...>-1       [002] d..1.    45.280870: console: BUG: KASAN: slab-use-after-free in proc_pid_lookup+0xbf/0x210
           <...>-1       [002] d..1.    45.282876: console: Write of size 4 at addr ffff88810d5f4528 by task systemd/1
           <...>-1       [002] d..1.    45.284781: console: 
           <...>-1       [002] d..1.    45.285295: console: CPU: 2 UID: 0 PID: 1 Comm: systemd Not tainted 6.11.0-rc3-test-00027-g014f473a3416-dirty #124 e44bf2780799707baf299f82ac321c3be7495d33
           <...>-1       [002] d..1.    45.289265: console: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
           <...>-1       [002] d..1.    45.292001: console: Call Trace:
           <...>-1       [002] d..1.    45.292764: console:  <TASK>
           <...>-1       [002] d..1.    45.293441: console:  dump_stack_lvl+0x53/0x70
           <...>-1       [002] d..1.    45.294575: console:  print_report+0xc6/0x640
           <...>-1       [002] d..1.    45.295672: console:  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
           <...>-1       [002] d..1.    45.297182: console:  ? proc_pid_lookup+0xbf/0x210
           <...>-1       [002] d..1.    45.298407: console:  kasan_report+0xc6/0x100
           <...>-1       [002] d..1.    45.299496: console:  ? proc_pid_lookup+0xbf/0x210
           <...>-1       [002] d..1.    45.300707: console:  kasan_check_range+0xf4/0x1a0
           <...>-1       [002] d..1.    45.301931: console:  proc_pid_lookup+0xbf/0x210
[..]

And I was able to easily debug the situation.

Now that I have an easy way to make the trace_printk() write to any
instance, I decided to add a run time option to the instances to tell them
to be the destination to the trace_printk(). That is, you don't need to add
a kernel command line to make the trace_printk() write to an instance. All
you need to do is set the trace_printk_dest option in the instance (note,
the trace_printk option was already taken at the top level that can be used
to disable trace_printk). Only one instance is allowed to be the
trace_printk destination, so setting this flag in one instance will clear it
in another. Also, an instance must always be the destination of the
trace_printk() function, so clearing the flag in any instance will
automatically cause the top level instance to be set. Trying to clear the
flag of the top level instance will return -EINVAL.

  echo 1 > /sys/kernel/tracing/instances/boot_map/options/trace_printk_dest

With all these fun new ways to debug the kernel, I figured it's about time
to start adding it to the Documentation directory. I created a debugging.rst
file in Documentation/trace, that is the start of adding techniques in using
tracing to debug your kernel.

[1] https://lore.kernel.org/all/20240821160316.02c03c44@gandalf.local.home/

These patches are based on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
     for-next


Steven Rostedt (5):
      tracing: Add "traceoff" flag to boot time tracing instances
      tracing: Allow trace_printk() to go to other instance buffers
      tracing: Have trace_printk not use binary prints if boot buffer
      tracing: Add option to set an instance to be the trace_printk destination
      tracing/Documentation: Start a document on how to debug with tracing

----
 Documentation/admin-guide/kernel-parameters.txt |  23 ++++
 Documentation/trace/debugging.rst               | 159 ++++++++++++++++++++++++
 Documentation/trace/ftrace.rst                  |  12 ++
 kernel/trace/trace.c                            | 127 ++++++++++++++++---
 kernel/trace/trace.h                            |   4 +-
 kernel/trace/trace_output.c                     |   5 +-
 6 files changed, 313 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/trace/debugging.rst
