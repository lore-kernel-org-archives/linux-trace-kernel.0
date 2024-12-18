Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0BE1A2387;
	Wed, 18 Dec 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538507; cv=none; b=VWN4qMe6bcYW9gfDqdomxrfUgTSyaecd3rUDWA6H/JV4lqCzxGehlxtYHah4M8lO9xY5rjlZxNa/NdOkHdXONMaPgbzjI4nWG6jX0tDG2FBi5bxkGetZ92E/OZS1KkzYhRsDVhs6g7yTi9KisrYkRcuSUrQ1PIlGEpTRUxH4gAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538507; c=relaxed/simple;
	bh=g0fOQUUIbndCm9J06Y/2BKrBaHwMEMu3jJD89HXmYAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNg92XGZrBo5AxaTONn3QB0X/jfROrSwkGq0WWzhPXSbsF0GPVERqVxJIIrh0KdrE9u8Ktowsd8Rs7lATOrhb/YUz+GwF3/gpCIAwhlmyCxBDmUvB+5+aPh50WaD99o17ing38DedvDnT5ePO86UWUmjdpvEU5SWPpHqhOsHI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB5CC4CECD;
	Wed, 18 Dec 2024 16:15:05 +0000 (UTC)
Date: Wed, 18 Dec 2024 11:15:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracepoint_probe_unregister (3)
Message-ID: <20241218111543.5e0ef7b0@gandalf.local.home>
In-Reply-To: <67629485.050a0220.29fcd0.008b.GAE@google.com>
References: <6761e9b5.050a0220.29fcd0.007b.GAE@google.com>
	<67629485.050a0220.29fcd0.008b.GAE@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 01:23:17 -0800
syzbot <syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:

It only found a reproducer when it introduces faults.

Again, this needs to report that faults were injected, because I can
guarantee that this would never reproduce any bug if you do not inject
faults. The fault is a requirement for the warning to happen.

Come back to me when you can reproduce it without fault injection.

-- Steve


> 
> HEAD commit:    aef25be35d23 hexagon: Disable constant extender optimizati..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b2cb44580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
> dashboard link: https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175342df980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17140cf8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/aa655a321f64/disk-aef25be3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/222a3010db12/vmlinux-aef25be3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7eab659ce042/bzImage-aef25be3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5829 at kernel/tracepoint.c:358 tracepoint_remove_func kernel/tracepoint.c:358 [inline]
> WARNING: CPU: 1 PID: 5829 at kernel/tracepoint.c:358 tracepoint_probe_unregister+0x894/0xd70 kernel/tracepoint.c:504
> Modules linked in:
> CPU: 1 UID: 0 PID: 5829 Comm: syz-executor241 Not tainted 6.13.0-rc3-syzkaller-00044-gaef25be35d23 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
> RIP: 0010:tracepoint_remove_func kernel/tracepoint.c:358 [inline]
> RIP: 0010:tracepoint_probe_unregister+0x894/0xd70 kernel/tracepoint.c:504
> Code: 41 5e 41 5f c3 cc cc cc cc e8 68 27 fe ff 48 c7 c6 60 16 9b 81 48 89 df e8 49 52 e5 ff eb 9f bb fe ff ff ff e8 4d 27 fe ff 90 <0f> 0b 90 eb 91 e8 42 27 fe ff 48 89 da 48 b8 00 00 00 00 00 fc ff
> RSP: 0018:ffffc90003e0f898 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 00000000fffffffe RCX: ffffffff819b24ff
> RDX: ffff88802f9c1e00 RSI: ffffffff819b27a3 RDI: 0000000000000005
> RBP: ffffffff8ecbca40 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000003 R12: ffffffff81a0eb30
> R13: 0000000000000402 R14: 0000000000000002 R15: ffffffff8de3fcd8
> FS:  000055556e1df380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000100 CR3: 00000000763aa000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  unregister_trace_sched_switch include/trace/events/sched.h:222 [inline]
>  tracing_sched_unregister kernel/trace/trace_sched_switch.c:87 [inline]
>  tracing_stop_sched_switch kernel/trace/trace_sched_switch.c:129 [inline]
>  tracing_stop_cmdline_record+0x66/0xa0 kernel/trace/trace_sched_switch.c:140
>  __ftrace_event_enable_disable+0x73f/0x850 kernel/trace/trace_events.c:645
>  ftrace_event_enable_disable kernel/trace/trace_events.c:730 [inline]
>  ftrace_clear_events kernel/trace/trace_events.c:739 [inline]
>  ftrace_event_set_open+0x238/0x2d0 kernel/trace/trace_events.c:2270
>  do_dentry_open+0xf59/0x1ea0 fs/open.c:945
>  vfs_open+0x82/0x3f0 fs/open.c:1075
>  do_open fs/namei.c:3828 [inline]
>  path_openat+0x1e6a/0x2d60 fs/namei.c:3987
>  do_filp_open+0x20c/0x470 fs/namei.c:4014
>  do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
>  do_sys_open fs/open.c:1417 [inline]
>  __do_sys_openat fs/open.c:1433 [inline]
>  __se_sys_openat fs/open.c:1428 [inline]
>  __x64_sys_openat+0x175/0x210 fs/open.c:1428
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7efe2dcdd6e9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd6660cd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efe2dcdd6e9
> RDX: 0000000000020201 RSI: 0000000020000100 RDI: ffffffffffffff9c
> RBP: 0000000000010bb4 R08: 0000000000000000 R09: 00000000000000a0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6660cd2c
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

