Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54027EC9C;
	Tue, 27 May 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362243; cv=none; b=ecTjMDngI5ODF919f2DAxqOmvyrHz8w83L4whM5llfaZdJ8bQ1u3QBOZnvEaABlPsXltJlIQyRmJnNVHXdoLhQsBsITL+FHF8ssqDLRY83ZTMgrfCv+zqByQPr20FDJAv/HMshL8kyUOnO+cIjrOsN0pa6j/mTcwOAxdVHJ1aF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362243; c=relaxed/simple;
	bh=XSFL++ESIEqvfRkKiEhhrY3YfIYdGSwa4dT8wqHzbXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SE3l9Cx0CH5R1jChrWKqUnpfWWZZizPHErz3cPNkRLkyhST56BYyDo5WA+h6l2bcHw8TLTIAwfWEX0JUvrsAsBdEIBwGLzXpRJfUg01wGahKoVtX4EaHi0htlNKHMaeccv3ztiirWP2X67BACq1OKIgwNU62PEA67y9pWIDPzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246A9C4CEEB;
	Tue, 27 May 2025 16:10:43 +0000 (UTC)
Date: Tue, 27 May 2025 12:11:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Do not trigger WARN_ON() due to a
 commit_overrun
Message-ID: <20250527121140.0e7f0565@gandalf.local.home>
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

When reading a memory mapped buffer the reader page is just swapped out
with the last page written in the write buffer. If the reader page is the
same as the commit buffer (the buffer that is currently being written to)
it was assumed that it should never have missed events. If it does, it
triggers a WARN_ON_ONCE().

But there just happens to be one scenario where this can legitimately
happen. That is on a commit_overrun. A commit overrun is when an interrupt
preempts an event being written to the buffer and then the interrupt adds
so many new events that it fills and wraps the buffer back to the commit.
Any new events would then be dropped and be reported as "missed_events".

In this case, the next page to read is the commit buffer and after the
swap of the reader page, the reader page will be the commit buffer, but
this time there will be missed events and this triggers the following
warning:

 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 1127 at kernel/trace/ring_buffer.c:7357 ring_buffer_map_get_reader+0x49a/0x780
 Modules linked in: kvm_intel kvm irqbypass
 CPU: 2 UID: 0 PID: 1127 Comm: trace-cmd Not tainted 6.15.0-rc7-test-00004-g478bc2824b45-dirty #564 PREEMPT
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:ring_buffer_map_get_reader+0x49a/0x780
 Code: 00 00 00 48 89 fe 48 c1 ee 03 80 3c 2e 00 0f 85 ec 01 00 00 4d 3b a6 a8 00 00 00 0f 85 8a fd ff ff 48 85 c0 0f 84 55 fe ff ff <0f> 0b e9 4e fe ff ff be 08 00 00 00 4c 89 54 24 58 48 89 54 24 50
 RSP: 0018:ffff888121787dc0 EFLAGS: 00010002
 RAX: 00000000000006a2 RBX: ffff888100062800 RCX: ffffffff8190cb49
 RDX: ffff888126934c00 RSI: 1ffff11020200a15 RDI: ffff8881010050a8
 RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffed1024d26982
 R10: ffff888126934c17 R11: ffff8881010050a8 R12: ffff888126934c00
 R13: ffff8881010050b8 R14: ffff888101005000 R15: ffff888126930008
 FS:  00007f95c8cd7540(0000) GS:ffff8882b576e000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f95c8de4dc0 CR3: 0000000128452002 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  ? __pfx_ring_buffer_map_get_reader+0x10/0x10
  tracing_buffers_ioctl+0x283/0x370
  __x64_sys_ioctl+0x134/0x190
  do_syscall_64+0x79/0x1c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f95c8de48db
 Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
 RSP: 002b:00007ffe037ba110 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007ffe037bb2b0 RCX: 00007f95c8de48db
 RDX: 0000000000000000 RSI: 0000000000005220 RDI: 0000000000000006
 RBP: 00007ffe037ba180 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007ffe037bb6f8 R14: 00007f95c9065000 R15: 00005575c7492c90
  </TASK>
 irq event stamp: 5080
 hardirqs last  enabled at (5079): [<ffffffff83e0adb0>] _raw_spin_unlock_irqrestore+0x50/0x70
 hardirqs last disabled at (5080): [<ffffffff83e0aa83>] _raw_spin_lock_irqsave+0x63/0x70
 softirqs last  enabled at (4182): [<ffffffff81516122>] handle_softirqs+0x552/0x710
 softirqs last disabled at (4159): [<ffffffff815163f7>] __irq_exit_rcu+0x107/0x210
 ---[ end trace 0000000000000000 ]---

The way to differentiate this case from the normal case of there only
being one page written to where the swap of the reader page received that
one page (which is the commit page), check if the tail page is on the
reader page. The difference between the commit page and the tail page is
that the tail page is where new writes go to, and the commit page holds
the first write that hasn't been committed yet. In the case of an
interrupt preempting the write of an event and filling the buffer, it
would move the tail page but not the commit page.

Have the warning only trigger if the tail page is also on the reader page,
and also print out the number of events dropped by a commit overrun as
that can not yet be safely added to the page so that the reader can see
there were events dropped.

Cc: stable@vger.kernel.org
Fixes: fe832be05a8ee ("ring-buffer: Have mmapped ring buffer keep track of missed events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 241acb470c42..508826886a87 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7351,10 +7351,25 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 		}
 	} else {
 		/*
-		 * There really shouldn't be any missed events if the commit
+		 * There really shouldn't be any missed events if the tail_page
 		 * is on the reader page.
 		 */
-		WARN_ON_ONCE(missed_events);
+		if (missed_events) {
+			if (!WARN_ONCE(cpu_buffer->reader_page == cpu_buffer->tail_page,
+				       "Reader on commit with %ld missed events",
+				       missed_events)) {
+				/*
+				 * If the tail page is not on the reader page but
+				 * the commit_page is, that would mean that there's
+				 * a commit_overrun (an interrupt preempted an
+				 * addition of an event and then filled the buffer
+				 * with new events). In this case it's not an
+				 * error, but it should still be reported.
+				 */
+				pr_info("Ring buffer commit overrun lost %ld events at timestamp:%lld\n",
+					missed_events, cpu_buffer->reader_page->page->time_stamp);
+			}
+		}
 	}
 
 	cpu_buffer->lost_events = 0;
-- 
2.47.2

