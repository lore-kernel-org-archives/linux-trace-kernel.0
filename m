Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6779CF;
	Tue,  2 Dec 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708090; cv=none; b=BmNh0RWg+lWdGHPRTA8idXvRy9U6scniU3zxqW6lHXUUn/MTqJUdusHC95Guu/p41Yw7+vtYYkuwtidN/EQRZXsyRnHZAkEHM+VvnCVPrcHzNi5micbxbzbD2pSHG+dz0k6lXNnzzJmtrktmgKU8DUyO3/qOgzkUnv9J9ZdFxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708090; c=relaxed/simple;
	bh=Owza9lzC4pLkf2/UU9OGf4F95B1ptUcrWOMyYRMPEf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxIk3pfdZqAZZq19Wb0u5SNkTStpxwS0DQkszoV7dl2JTZbIakZTznwoHvMDnYXzEA4rlL1jNrOy4Yv/9zuA0xJ+7D5oNqXxKtJsO35loc5sD8l0m/TLSdWMcJe9s1v4Aqn27nIpG3yNDIZXmyacVRAfzC81lwzsu8ed7pPYPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 4ABDA132866;
	Tue,  2 Dec 2025 20:41:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 7B92E17;
	Tue,  2 Dec 2025 20:41:18 +0000 (UTC)
Date: Tue, 2 Dec 2025 15:42:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+ccdec3bfe0beec58a38d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracing_start_tr
Message-ID: <20251202154218.52901ae2@gandalf.local.home>
In-Reply-To: <692f44a5.a70a0220.2ea503.00c8.GAE@google.com>
References: <680049ca.050a0220.5cdb3.000a.GAE@google.com>
	<692f44a5.a70a0220.2ea503.00c8.GAE@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7B92E17
X-Stat-Signature: ykkwiy7tfmxhe6uw8auiau7arehqx8z8
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX181C7hx1LpLf6ZfvcuC/XdGM+aqyS35myM=
X-HE-Tag: 1764708078-114360
X-HE-Meta: U2FsdGVkX19l+jNySP0qzzGrjj70EWGL13vaRjZJSFco373XwEms6A53E8QtmRdhN89JfO3Jr81gKXChxtawHo23bFY5AGNDk1Y69b2D3Hpw8E9re1yx+FMB53roFCMSf8PO6M1Yo2U41Mh4OuU/JJ9szUy9pwDwwBabOotwjS7xCNnwo2tWYU18L1b6CRd6XnkE85LBXuh9IX2zfm+Y/1aG+scOFEQMxhNF3Jl1zZJpUqQ+biOR0Z0eqBBbGt/G8Mc/vkacFrhfgXsWN5C7HcRXKnZ3E9s8gFcpg9wT83aLBrKvlEy+dp/w/YDWXcwkxV6X7sod8CONZM4g0NkDorLCdsiN0DU/vwWn7/061u7nW0H1jn6NCgvfYOyizlmcf53yITJ+5JP8kkhhSEjl3Q1vGrJEoD3F

On Tue, 02 Dec 2025 11:57:26 -0800
syzbot <syzbot+ccdec3bfe0beec58a38d@syzkaller.appspotmail.com> wrote:

> ------------[ cut here ]------------
> WARNING: kernel/trace/trace.c:2497 at tracing_start_tr+0x21d/0x2b0 kernel/trace/trace.c:2497, CPU#0: syz.3.186/6257
> Modules linked in:
> CPU: 0 UID: 0 PID: 6257 Comm: syz.3.186 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:tracing_start_tr+0x21d/0x2b0 kernel/trace/trace.c:2497
> Code: 48 85 db 74 0d e8 73 1c fb ff 48 89 df e8 fb 42 fd ff e8 66 1c fb ff 4c 89 ef e8 be c5 ff ff e9 1e ff ff ff e8 54 1c fb ff 90 <0f> 0b 90 c7 83 94 00 00 00 00 00 00 00 e9 01 ff ff ff e8 3c 1c fb
> RSP: 0018:ffffc90003777bd8 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffffff8e250de0 RCX: ffffffff81c203e7
> RDX: ffff888027699e80 RSI: ffffffff81c204dc RDI: 0000000000000005
> RBP: 1ffff920006eef7c R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000ffffffff R11: 000000003ca71f67 R12: 00000000ffffffff
> R13: dffffc0000000000 R14: 0000000000000293 R15: ffffffff8e250ec0
> FS:  0000555561d28500(0000) GS:ffff888124ba8000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000075090000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  buffer_subbuf_size_write+0x1ca/0x260 kernel/trace/trace.c:9702
>  vfs_write+0x2a0/0x11d0 fs/read_write.c:684
>  ksys_write+0x12a/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2c50f8f7c9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe8ab04cc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f2c511e5fa0 RCX: 00007f2c50f8f7c9
> RDX: 0000000000000040 RSI: 0000200000000280 RDI: 0000000000000004
> RBP: 00007f2c51013f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f2c511e5fa0 R14: 00007f2c511e5fa0 R15: 0000000000000003
>  </TASK>

Thanks, this is a real bug and should be fixed with the following patch:

(not compiled yet)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 04307a19cde3..3690221ba3d8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -138,6 +138,7 @@ enum trace_iter_flags {
 	TRACE_FILE_LAT_FMT	= 1,
 	TRACE_FILE_ANNOTATE	= 2,
 	TRACE_FILE_TIME_IN_NS	= 4,
+	TRACE_FILE_PAUSE	= 8,
 };
 
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d1e527cf2aae..62daff9a10dc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4682,8 +4682,10 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	 * If pause-on-trace is enabled, then stop the trace while
 	 * dumping, unless this is the "snapshot" file
 	 */
-	if (!iter->snapshot && (tr->trace_flags & TRACE_ITER_PAUSE_ON_TRACE))
+	if (!iter->snapshot && (tr->trace_flags & TRACE_ITER_PAUSE_ON_TRACE)) {
+		iter->iter_flags |= TRACE_FILE_PAUSE;
 		tracing_stop_tr(tr);
+	}
 
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
@@ -4815,7 +4817,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 	if (iter->trace && iter->trace->close)
 		iter->trace->close(iter);
 
-	if (!iter->snapshot && tr->stop_count)
+	if (iter->iter_flags & TRACE_FILE_PAUSE)
 		/* reenable tracing if it was previously enabled */
 		tracing_start_tr(tr);
 

Basically the old code was depending on the state of tr->stop_count to know
if it should re-enable it or not. But that's because the stop_count was
only incremented by a single user when it was created. Now it's incremented
by more than one user. This means if the open didn't increment it, but
something else did, then the close is going to decrement it when it shouldn't.

This fix adds a flag to the trace_iterator (unique per open) that holds the
state if it incremented the stop_count or not. Then the close can check if
its open was what did the increment, and decrement it if it had.

-- Steve
