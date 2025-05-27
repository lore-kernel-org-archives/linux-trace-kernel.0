Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4227602B;
	Tue, 27 May 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357844; cv=none; b=fD7Je6ix2JjTN6rTOtj83/mS758KU33UZmH4I9pQOqBaAg/HEar7huS4G0Bm0yrML7oaTDIB6D31my4fcOjsHBh0Z0D5EK0C61RDa9b42L2z/8ZHWvQDceowJ2iclixfRXMNeKlCuPkNqYpSKh4vTLxhrGtug5WxjRfuL2xa6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357844; c=relaxed/simple;
	bh=pL9Fegy02fmCCz6cEn5sWFto9TtfYVeB589+kYHMg78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CyuV+PYVmQnE8mOgGBxoN0KUwYmO9M+MmhO0iT3PrFhpVhmgUIwmieJB4urc9ROhbFNqpnyJ1yFmOCIo4dJM3/A1VELHEWtPb8iEYzPNGRyPFrm1e0vmEuMdBgV33QDmalwweJ31GTIfCvbgSUF3Fb6VQMDII6JQzE1DTqA+0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A2EC4CEE9;
	Tue, 27 May 2025 14:57:23 +0000 (UTC)
Date: Tue, 27 May 2025 10:58:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Move cpus_read_lock() outside of buffer->mutex
Message-ID: <20250527105820.0f45d045@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Running a modified trace-cmd record --nosplice where it does a mmap of the
ring buffer when '--nosplice' is set, caused the following lockdep splat:

 ======================================================
 WARNING: possible circular locking dependency detected
 6.15.0-rc7-test-00002-gfb7d03d8a82f #551 Not tainted
 ------------------------------------------------------
 trace-cmd/1113 is trying to acquire lock:
 ffff888100062888 (&buffer->mutex){+.+.}-{4:4}, at: ring_buffer_map+0x11c/0xe70

 but task is already holding lock:
 ffff888100a5f9f8 (&cpu_buffer->mapping_lock){+.+.}-{4:4}, at: ring_buffer_map+0xcf/0xe70

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #5 (&cpu_buffer->mapping_lock){+.+.}-{4:4}:
        __mutex_lock+0x192/0x18c0
        ring_buffer_map+0xcf/0xe70
        tracing_buffers_mmap+0x1c4/0x3b0
        __mmap_region+0xd8d/0x1f70
        do_mmap+0x9d7/0x1010
        vm_mmap_pgoff+0x20b/0x390
        ksys_mmap_pgoff+0x2e9/0x440
        do_syscall_64+0x79/0x1c0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #4 (&mm->mmap_lock){++++}-{4:4}:
        __might_fault+0xa5/0x110
        _copy_to_user+0x22/0x80
        _perf_ioctl+0x61b/0x1b70
        perf_ioctl+0x62/0x90
        __x64_sys_ioctl+0x134/0x190
        do_syscall_64+0x79/0x1c0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #3 (&cpuctx_mutex){+.+.}-{4:4}:
        __mutex_lock+0x192/0x18c0
        perf_event_init_cpu+0x325/0x7c0
        perf_event_init+0x52a/0x5b0
        start_kernel+0x263/0x3e0
        x86_64_start_reservations+0x24/0x30
        x86_64_start_kernel+0x95/0xa0
        common_startup_64+0x13e/0x141

 -> #2 (pmus_lock){+.+.}-{4:4}:
        __mutex_lock+0x192/0x18c0
        perf_event_init_cpu+0xb7/0x7c0
        cpuhp_invoke_callback+0x2c0/0x1030
        __cpuhp_invoke_callback_range+0xbf/0x1f0
        _cpu_up+0x2e7/0x690
        cpu_up+0x117/0x170
        cpuhp_bringup_mask+0xd5/0x120
        bringup_nonboot_cpus+0x13d/0x170
        smp_init+0x2b/0xf0
        kernel_init_freeable+0x441/0x6d0
        kernel_init+0x1e/0x160
        ret_from_fork+0x34/0x70
        ret_from_fork_asm+0x1a/0x30

 -> #1 (cpu_hotplug_lock){++++}-{0:0}:
        cpus_read_lock+0x2a/0xd0
        ring_buffer_resize+0x610/0x14e0
        __tracing_resize_ring_buffer.part.0+0x42/0x120
        tracing_set_tracer+0x7bd/0xa80
        tracing_set_trace_write+0x132/0x1e0
        vfs_write+0x21c/0xe80
        ksys_write+0xf9/0x1c0
        do_syscall_64+0x79/0x1c0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #0 (&buffer->mutex){+.+.}-{4:4}:
        __lock_acquire+0x1405/0x2210
        lock_acquire+0x174/0x310
        __mutex_lock+0x192/0x18c0
        ring_buffer_map+0x11c/0xe70
        tracing_buffers_mmap+0x1c4/0x3b0
        __mmap_region+0xd8d/0x1f70
        do_mmap+0x9d7/0x1010
        vm_mmap_pgoff+0x20b/0x390
        ksys_mmap_pgoff+0x2e9/0x440
        do_syscall_64+0x79/0x1c0
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 other info that might help us debug this:

 Chain exists of:
   &buffer->mutex --> &mm->mmap_lock --> &cpu_buffer->mapping_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&cpu_buffer->mapping_lock);
                                lock(&mm->mmap_lock);
                                lock(&cpu_buffer->mapping_lock);
   lock(&buffer->mutex);

  *** DEADLOCK ***

 2 locks held by trace-cmd/1113:
  #0: ffff888106b847e0 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x192/0x390
  #1: ffff888100a5f9f8 (&cpu_buffer->mapping_lock){+.+.}-{4:4}, at: ring_buffer_map+0xcf/0xe70

 stack backtrace:
 CPU: 5 UID: 0 PID: 1113 Comm: trace-cmd Not tainted 6.15.0-rc7-test-00002-gfb7d03d8a82f #551 PREEMPT
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6e/0xa0
  print_circular_bug.cold+0x178/0x1be
  check_noncircular+0x146/0x160
  __lock_acquire+0x1405/0x2210
  lock_acquire+0x174/0x310
  ? ring_buffer_map+0x11c/0xe70
  ? ring_buffer_map+0x11c/0xe70
  ? __mutex_lock+0x169/0x18c0
  __mutex_lock+0x192/0x18c0
  ? ring_buffer_map+0x11c/0xe70
  ? ring_buffer_map+0x11c/0xe70
  ? function_trace_call+0x296/0x370
  ? __pfx___mutex_lock+0x10/0x10
  ? __pfx_function_trace_call+0x10/0x10
  ? __pfx___mutex_lock+0x10/0x10
  ? _raw_spin_unlock+0x2d/0x50
  ? ring_buffer_map+0x11c/0xe70
  ? ring_buffer_map+0x11c/0xe70
  ? __mutex_lock+0x5/0x18c0
  ring_buffer_map+0x11c/0xe70
  ? do_raw_spin_lock+0x12d/0x270
  ? find_held_lock+0x2b/0x80
  ? _raw_spin_unlock+0x2d/0x50
  ? rcu_is_watching+0x15/0xb0
  ? _raw_spin_unlock+0x2d/0x50
  ? trace_preempt_on+0xd0/0x110
  tracing_buffers_mmap+0x1c4/0x3b0
  __mmap_region+0xd8d/0x1f70
  ? ring_buffer_lock_reserve+0x99/0xff0
  ? __pfx___mmap_region+0x10/0x10
  ? ring_buffer_lock_reserve+0x99/0xff0
  ? __pfx_ring_buffer_lock_reserve+0x10/0x10
  ? __pfx_ring_buffer_lock_reserve+0x10/0x10
  ? bpf_lsm_mmap_addr+0x4/0x10
  ? security_mmap_addr+0x46/0xd0
  ? lock_is_held_type+0xd9/0x130
  do_mmap+0x9d7/0x1010
  ? 0xffffffffc0370095
  ? __pfx_do_mmap+0x10/0x10
  vm_mmap_pgoff+0x20b/0x390
  ? __pfx_vm_mmap_pgoff+0x10/0x10
  ? 0xffffffffc0370095
  ksys_mmap_pgoff+0x2e9/0x440
  do_syscall_64+0x79/0x1c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7fb0963a7de2
 Code: 00 00 00 0f 1f 44 00 00 41 f7 c1 ff 0f 00 00 75 27 55 89 cd 53 48 89 fb 48 85 ff 74 3b 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 5b 5d c3 0f 1f 00 48 8b 05 e1 9f 0d 00 64
 RSP: 002b:00007ffdcc8fb878 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb0963a7de2
 RDX: 0000000000000001 RSI: 0000000000001000 RDI: 0000000000000000
 RBP: 0000000000000001 R08: 0000000000000006 R09: 0000000000000000
 R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007ffdcc8fbe68 R14: 00007fb096628000 R15: 00005633e01a5c90
  </TASK>

The issue is that cpus_read_lock() is taken within buffer->mutex. The
memory mapped pages are taken with the mmap_lock held. The buffer->mutex
is taken within the cpu_buffer->mapping_lock. There's quite a chain with
all these locks, where the deadlock can be fixed by moving the
cpus_read_lock() outside the taking of the buffer->mutex.

Cc: stable@vger.kernel.org
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8134ae64d7f8..241acb470c42 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2849,6 +2849,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	if (nr_pages < 2)
 		nr_pages = 2;
 
+	/*
+	 * Keep CPUs from coming online while resizing to synchronize
+	 * with new per CPU buffers being created.
+	 */
+	guard(cpus_read_lock)();
+
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
 	atomic_inc(&buffer->resizing);
@@ -2893,7 +2899,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			cond_resched();
 		}
 
-		cpus_read_lock();
 		/*
 		 * Fire off all the required work handlers
 		 * We can't schedule on offline CPUs, but it's not necessary
@@ -2933,7 +2938,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			cpu_buffer->nr_pages_to_update = 0;
 		}
 
-		cpus_read_unlock();
 	} else {
 		cpu_buffer = buffer->buffers[cpu_id];
 
@@ -2961,8 +2965,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			goto out_err;
 		}
 
-		cpus_read_lock();
-
 		/* Can't run something on an offline CPU. */
 		if (!cpu_online(cpu_id))
 			rb_update_pages(cpu_buffer);
@@ -2981,7 +2983,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		}
 
 		cpu_buffer->nr_pages_to_update = 0;
-		cpus_read_unlock();
 	}
 
  out:
-- 
2.47.2

