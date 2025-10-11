Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B0E552;
	Sat, 11 Oct 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760196040; cv=none; b=pjk8iY1XDo+kixkVOoBt5Quo0lP7Sir0tMZrHl0lKXedl5OA/Ky7IsT2StiGKqspRVJXbENimqj+Sns3+3+B+YAJl+9hbYFauMALRAn7A2YeuKxrk3gQZGEEWYc2BXtt8C5uz0+HSoqdQOpJGgmxo9z9SvApMVhe1nDMBkrLrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760196040; c=relaxed/simple;
	bh=5PriYxFX+yBCXTjN+jChzG8WLjLXrcWxSAvefhCEC3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kR1DS7ZEc+UcHQW5ArygB1gqowqmIO2wpIE39l6D+BXIsVuD3cv82fk9IzYDszV9YjuKBFzwm9Qe+EP9dPoy+KvvKhr4eaH0n+72kbvvO47CCUNwseIbEuwOLBAm5YonFyZdEU9ie1iKdyNJDjg+esUM9KLUCYUfoIiIOkbfEE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 8C23ABA931;
	Sat, 11 Oct 2025 15:20:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id E858F20015;
	Sat, 11 Oct 2025 15:20:27 +0000 (UTC)
Date: Sat, 11 Oct 2025 11:20:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] tracing: Stop fortify-string from warning in
 tracing_mark_raw_write()
Message-ID: <20251011112032.77be18e4@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ajerpg3f736634utod5henpoe7o7hwbd
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E858F20015
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+jiqBA02cpO877lQO/z80Yy0ZdbsrQUS4=
X-HE-Tag: 1760196027-905124
X-HE-Meta: U2FsdGVkX18/fjRhsyPRiVBv4SvWGkdM+FqJAUIenMdgPEsdCQeKL/3BRYcENCEQ6dcQfrK52PhZcmvieqPrilJclwKvelOi72S5a3Nu4x62HLZ1/wBpGysR12hs/DABZEURQiNlM16UBAI8MF+ErApuxtLdKjAwG8oNIwo+g7WY6s1CDTS+UOssT9qJSrG2Lr+9qfnMhabGfv9DmbYAV0FUqCa24W3Mwe2SLez/q7FVwjmyMZv3ptzDMWc9RVWPO/niatqAkpsyKvR5+tqu+gEZXlBQllXu+K2D+CQoI4VKM8A36RTcvoxlV9k/jidie90cn0/4HiuPIZadW5gcu9ihhGx+2p4lzrrmPjOiHFngIuUrpc1kq83gLwjeaT1t2FbmtZ+Vym+5bW2x2OM0yULvaVwDObVTCQJY5oI6wBtSDJewSnkavayLjZES/Sf9Gj1K7dM13lKWWx+vIiMJwi0WbkfPXPiFIDzaBv6PS0k=

From: Steven Rostedt <rostedt@goodmis.org>

The way tracing_mark_raw_write() records its data is that it has the
following structure:

  struct {
	struct trace_entry;
	int id;
	char buf[];
  };

But memcpy(&entry->id, buf, size) triggers the following warning when the
size is greater than the id:

 ------------[ cut here ]------------
 memcpy: detected field-spanning write (size 6) of single field "&entry->id" at kernel/trace/trace.c:7458 (size 4)
 WARNING: CPU: 7 PID: 995 at kernel/trace/trace.c:7458 write_raw_marker_to_buffer.isra.0+0x1f9/0x2e0
 Modules linked in:
 CPU: 7 UID: 0 PID: 995 Comm: bash Not tainted 6.17.0-test-00007-g60b82183e78a-dirty #211 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
 RIP: 0010:write_raw_marker_to_buffer.isra.0+0x1f9/0x2e0
 Code: 04 00 75 a7 b9 04 00 00 00 48 89 de 48 89 04 24 48 c7 c2 e0 b1 d1 b2 48 c7 c7 40 b2 d1 b2 c6 05 2d 88 6a 04 01 e8 f7 e8 bd ff <0f> 0b 48 8b 04 24 e9 76 ff ff ff 49 8d 7c 24 04 49 8d 5c 24 08 48
 RSP: 0018:ffff888104c3fc78 EFLAGS: 00010292
 RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 1ffffffff6b363b4 RDI: 0000000000000001
 RBP: ffff888100058a00 R08: ffffffffb041d459 R09: ffffed1020987f40
 R10: 0000000000000007 R11: 0000000000000001 R12: ffff888100bb9010
 R13: 0000000000000000 R14: 00000000000003e3 R15: ffff888134800000
 FS:  00007fa61d286740(0000) GS:ffff888286cad000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000560d28d509f1 CR3: 00000001047a4006 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  tracing_mark_raw_write+0x1fe/0x290
  ? __pfx_tracing_mark_raw_write+0x10/0x10
  ? security_file_permission+0x50/0xf0
  ? rw_verify_area+0x6f/0x4b0
  vfs_write+0x1d8/0xdd0
  ? __pfx_vfs_write+0x10/0x10
  ? __pfx_css_rstat_updated+0x10/0x10
  ? count_memcg_events+0xd9/0x410
  ? fdget_pos+0x53/0x5e0
  ksys_write+0x182/0x200
  ? __pfx_ksys_write+0x10/0x10
  ? do_user_addr_fault+0x4af/0xa30
  do_syscall_64+0x63/0x350
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7fa61d318687
 Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
 RSP: 002b:00007ffd87fe0120 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 00007fa61d286740 RCX: 00007fa61d318687
 RDX: 0000000000000006 RSI: 0000560d28d509f0 RDI: 0000000000000001
 RBP: 0000560d28d509f0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000006
 R13: 00007fa61d4715c0 R14: 00007fa61d46ee80 R15: 0000000000000000
  </TASK>
 ---[ end trace 0000000000000000 ]---

This is because fortify string sees that the size of entry->id is only 4
bytes, but it is writing more than that. But this is OK as the
dynamic_array is allocated to handle that copy.

The size allocated on the ring buffer was actually a bit too big:

  size = sizeof(*entry) + cnt;

But cnt includes the 'id' and the buffer data, so adding cnt to the size
of *entry actually allocates too much on the ring buffer.

Change the allocation to:

  size = struct_size(entry, buf, cnt - sizeof(entry->id));

and the memcpy() to unsafe_memcpy() with an added justification.

Cc: stable@vger.kernel.org
Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
Reported-by: syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68e973f5.050a0220.1186a4.0010.GAE@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20251011035243.552866788@kernel.org

- Instead of playing pointer tricks to get around fortify-string,
  use the unsafe_memcpy.

- Also allocate only what is needed on the ring buffer and not 4 bytes
  more.

 kernel/trace/trace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bbb89206a891..eb256378e65b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7441,7 +7441,8 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 	ssize_t written;
 	size_t size;
 
-	size = sizeof(*entry) + cnt;
+	/* cnt includes both the entry->id and the data behind it. */
+	size = struct_size(entry, buf, cnt - sizeof(entry->id));
 
 	buffer = tr->array_buffer.buffer;
 
@@ -7455,7 +7456,10 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 		return -EBADF;
 
 	entry = ring_buffer_event_data(event);
-	memcpy(&entry->id, buf, cnt);
+	unsafe_memcpy(&entry->id, buf, cnt,
+		      "id and content already reserved on ring buffer"
+		      "'buf' includes the 'id' and the data."
+		      "'entry' was allocated with cnt from 'id'.");
 	written = cnt;
 
 	__buffer_unlock_commit(buffer, event);
-- 
2.51.0

