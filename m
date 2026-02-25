Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B283B8BA2;
	Wed, 25 Feb 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026287; cv=none; b=fsNsm3x1h4XU/ysbG2+15xbLw3ayK39hji3d9f9XJQYfm7nT8y508s4GxaiPIyySV3OgQCuJnkg4mBfdss2NHsCFidc9xR6gVPcpcJJrvdiLvrCqpJ2/3ReQxEEVvhWcOBSTvkGo9REyYlYqiGLelK0NtgYxhBf6ZbUl/DhGsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026287; c=relaxed/simple;
	bh=n+5waH2NbY49uwCLFp9XAa65V3bbTHraBIUAeUheOk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4PxNIhulbDHdwqs7dF66MNXJn6JLXwyToFu31MtKh42PB5wYzQbTvxJ78HkeGIpy6Ju3d87PvGWLgKdgSqtIGc178Y1voBs84KmhRxuO/dnwboyGkKz5r8C/BsSdM6Knn+I5u2xnrTI3Gh15aWma2uG1YTF99OuwUgUHwLobHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfh4NRrk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfh4NRrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114A8C116D0;
	Wed, 25 Feb 2026 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772026286;
	bh=n+5waH2NbY49uwCLFp9XAa65V3bbTHraBIUAeUheOk0=;
	h=From:To:Cc:Subject:Date:From;
	b=Tfh4NRrkHiP3rCMOGnxqshEIDItQhV+e4VJX+gEcdB0t536BJGEmIjB1RSQT0UQV4
	 c+N6+LkUG5PqCw81eb1lUBd6c6rnAc0VtKog9Csk0jQMjt0VsTDzaxk1iZCXDpYX17
	 3n+wxEvSdYT9FtremgNI1olkepwgOqdB21OwqYnBQG1NUneY3mwx+unUtOIcoZb+z7
	 lCCXeXIHACmE6+CdVuhhF5U7uDuchAdfvArUZx3rcyK6VolbklxQqseolJMHasAnN5
	 Dnwopbt9tA2wd8Raf45EIydF7h7EHzE4nk7uMNGbqvw2L8uPDVfjqVqv0c4GRGCsxu
	 1fkl47uyR77SQ==
From: Sasha Levin <sashal@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tracing: Fix use-after-free race in copy_trace_marker on instance removal
Date: Wed, 25 Feb 2026 08:31:22 -0500
Message-ID: <20260225133122.237275-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a trace instance with copy_trace_marker enabled is removed,
__remove_instance() first iterates ZEROED_TRACE_FLAGS (which includes
COPY_MARKER), calling set_tracer_flag() -> update_marker_trace(tr, 0).
This removes the instance from the marker_copies RCU list via
list_del_init() and returns immediately.

The subsequent explicit update_marker_trace(tr, 0) call then finds
list_empty(&tr->marker_list) is true and returns false, causing
synchronize_rcu() to be skipped. The ring buffer and trace_array are
then freed while a concurrent writer in tracing_mark_write() may still
hold an RCU-protected reference, leading to use-after-free.

  BUG: KASAN: slab-use-after-free in write_marker_to_buffer+0x1e7/0x610 kernel/trace/trace.c:6527
  Write of size 4054 at addr ffff888103af7058 by task syz.0.277/5019

  CPU: 3 UID: 0 PID: 5019 Comm: syz.0.277 Tainted: G                 N  7.0.0-rc1-00001-gc5447a46efed #51 PREEMPT(full)
  Tainted: [N]=TEST
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:94 [inline]
   dump_stack_lvl+0xba/0x110 lib/dump_stack.c:120
   print_address_description mm/kasan/report.c:378 [inline]
   print_report+0x156/0x4d9 mm/kasan/report.c:482
   kasan_report+0xf6/0x1f0 mm/kasan/report.c:595
   check_region_inline mm/kasan/generic.c:186 [inline]
   kasan_check_range+0x125/0x200 mm/kasan/generic.c:200
   __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
   write_marker_to_buffer+0x1e7/0x610 kernel/trace/trace.c:6527
   tracing_mark_write+0x218/0x3f0 kernel/trace/trace.c:6875
   vfs_write+0x2b7/0x1070 fs/read_write.c:686
   ksys_write+0x1f8/0x250 fs/read_write.c:740
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xf3/0x700 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fdb7eb9df29
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48
   c7 c1 e8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007fdb7fa81008 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 00007fdb7ee15fa0 RCX: 00007fdb7eb9df29
  RDX: 0000000000001000 RSI: 0000200000000300 RDI: 0000000000000003
  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007ffec21bfd06 R14: 00007fdb7fa81ce4 R15: 00007fdb7fa61000
   </TASK>

  The buggy address belongs to the physical page:
  page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffffffffffffff pfn:0x103af7
  flags: 0x200000000000000(node=0|zone=2)
  raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
  raw: ffffffffffffffff 0000000000000000 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff888103af7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff888103af7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff888103af8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                     ^
   ffff888103af8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
   ffff888103af8100: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb

Fix this by:

1. Removing TRACE_ITER(COPY_MARKER) from ZEROED_TRACE_FLAGS so the flag
   loop doesn't pre-clear it. The explicit update_marker_trace(tr, 0) +
   synchronize_rcu() then correctly waits for RCU readers to finish
   before freeing.

2. Replacing list_del_init() with list_del_rcu() in update_marker_trace()
   for proper RCU list removal semantics. list_del_init() overwrites
   entry->next to point to itself, which can cause concurrent RCU readers
   to loop infinitely. list_del_rcu() preserves entry->next so readers
   can safely finish their traversal. The duplicate-operation guards are
   changed from list_empty() to trace_flags bit checks accordingly, since
   list_del_rcu() does not reinitialize the list head.

Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23de3719f4952..fa413214da764 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -523,8 +523,7 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
-	(TRACE_ITER(EVENT_FORK) | TRACE_ITER(FUNC_FORK) | TRACE_ITER(TRACE_PRINTK) | \
-	 TRACE_ITER(COPY_MARKER))
+	(TRACE_ITER(EVENT_FORK) | TRACE_ITER(FUNC_FORK) | TRACE_ITER(TRACE_PRINTK))
 
 /*
  * The global_trace is the descriptor that holds the top-level tracing
@@ -555,7 +554,7 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 	lockdep_assert_held(&event_mutex);
 
 	if (enabled) {
-		if (!list_empty(&tr->marker_list))
+		if (tr->trace_flags & TRACE_ITER(COPY_MARKER))
 			return false;
 
 		list_add_rcu(&tr->marker_list, &marker_copies);
@@ -563,10 +562,10 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 		return true;
 	}
 
-	if (list_empty(&tr->marker_list))
+	if (!(tr->trace_flags & TRACE_ITER(COPY_MARKER)))
 		return false;
 
-	list_del_init(&tr->marker_list);
+	list_del_rcu(&tr->marker_list);
 	tr->trace_flags &= ~TRACE_ITER(COPY_MARKER);
 	return true;
 }
-- 
2.51.0

