Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69EB1DD0C7;
	Tue, 17 Dec 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471718; cv=none; b=K6VosYFofQ0NcCW0YBwhnwQ6X8bak4bS1njCwcbGQjh6uxtRdznU2Qz2T07m9fWiwCEbLTQS96fgC6YjO7JpavZYCwnZa7YMJKwrEuv5BrftiXqSjiuCOlNs4idSrIsN42+VATmNuEWYONmyuC90w+lfvWM1OrdkgLT2zc3RcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471718; c=relaxed/simple;
	bh=O6WVpcSGkrgqp2qaC/iu79nbXYz9oeSd5DO22EMH0bc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/Hy/1P3ZCvNq5eudl8k+hSV+5USwJcwuweO5ya4sniffWLYGOJ7V0CE2WuW7hAd1Q99iq46v9L+vK++E6/6dB/arUWEqgBQYZufTGSxhC9vVgo2GInm/5+TQ0eVqYMUnFgzB1VRCctNVZhCkRpHR5JlXjnLXqGa/inbhAlUaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1ACC4CED3;
	Tue, 17 Dec 2024 21:41:57 +0000 (UTC)
Date: Tue, 17 Dec 2024 16:42:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracepoint_probe_unregister (3)
Message-ID: <20241217164233.6295b104@gandalf.local.home>
In-Reply-To: <6761e9b5.050a0220.29fcd0.007b.GAE@google.com>
References: <6761e9b5.050a0220.29fcd0.007b.GAE@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 13:14:29 -0800
syzbot <syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    243f750a2df0 Merge tag 'gpio-fixes-for-v6.13-rc3' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1310a4f8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
> dashboard link: https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Of course you can't as it requires a fault injection. Just before this
error, we have:

[  203.551558][ T7580] FAULT_INJECTION: forcing a failure.
[  203.551558][ T7580] name failslab, interval 1, probability 0, space 0, times 0
[  203.645990][ T7580] CPU: 1 UID: 0 PID: 7580 Comm: syz.0.521 Not tainted 6.13.0-rc2-syzkaller-00192-g243f750a2df0 #0
[  203.656699][ T7580] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
[  203.666904][ T7580] Call Trace:
[  203.670332][ T7580]  <TASK>
[  203.673324][ T7580]  dump_stack_lvl+0x16c/0x1f0
[  203.678087][ T7580]  should_fail_ex+0x497/0x5b0
[  203.682838][ T7580]  ? fs_reclaim_acquire+0xae/0x150
[  203.688021][ T7580]  should_failslab+0xc2/0x120
[  203.692783][ T7580]  __kmalloc_noprof+0xce/0x4f0
[  203.697631][ T7580]  ? tracepoint_add_func+0x2a9/0xeb0

This forces the tracepoint_add_func to fail the allocation, which would
only ever happen under really extreme memory issues.

[  203.702994][ T7580]  ? __pfx_probe_sched_wakeup+0x10/0x10
[  203.708631][ T7580]  tracepoint_add_func+0x2a9/0xeb0
[  203.713905][ T7580]  ? __pfx_probe_sched_wakeup+0x10/0x10
[  203.719554][ T7580]  ? __pfx_probe_sched_wakeup+0x10/0x10
[  203.725193][ T7580]  tracepoint_probe_register+0xc0/0x110
[  203.730820][ T7580]  ? __pfx_tracepoint_probe_register+0x10/0x10
[  203.737052][ T7580]  ? __pfx_probe_sched_wakeup+0x10/0x10
[  203.742708][ T7580]  ? ftrace_set_clr_event+0x13a/0x270
[  203.748177][ T7580]  tracing_start_sched_switch+0xdc/0x1e0

Here's where it forces an allocation failure for the sched_switch
tracepoint in the code that adds hooks to keep track of the comms.

[  203.753906][ T7580]  __ftrace_event_enable_disable+0x64d/0x850
[  203.759964][ T7580]  __ftrace_set_clr_event_nolock+0x29e/0x3a0
[  203.766026][ T7580]  ftrace_set_clr_event+0x150/0x270
[  203.771299][ T7580]  ? __pfx_ftrace_set_clr_event+0x10/0x10
[  203.777104][ T7580]  ftrace_event_write+0x245/0x290
[  203.782206][ T7580]  ? __pfx_ftrace_event_write+0x10/0x10
[  203.787823][ T7580]  ? ksys_write+0x12b/0x250
[  203.792405][ T7580]  ? __pfx_ftrace_event_write+0x10/0x10
[  203.798041][ T7580]  vfs_write+0x24c/0x1150
[  203.802442][ T7580]  ? __fget_files+0x1fc/0x3a0
[  203.807213][ T7580]  ? __pfx___mutex_lock+0x10/0x10
[  203.812316][ T7580]  ? __pfx_vfs_write+0x10/0x10
[  203.817176][ T7580]  ? __fget_files+0x206/0x3a0
[  203.821970][ T7580]  ksys_write+0x12b/0x250
[  203.826373][ T7580]  ? __pfx_ksys_write+0x10/0x10
[  203.831299][ T7580]  do_syscall_64+0xcd/0x250
[  203.835874][ T7580]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  203.841863][ T7580] RIP: 0033:0x7fe095985d19
[  203.846346][ T7580] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
[  203.866125][ T7580] RSP: 002b:00007fe09670e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  203.874587][ T7580] RAX: ffffffffffffffda RBX: 00007fe095b75fa0 RCX: 00007fe095985d19
[  203.882595][ T7580] RDX: 0000000000000004 RSI: 0000000020000040 RDI: 0000000000000003
[  203.890595][ T7580] RBP: 00007fe09670e090 R08: 0000000000000000 R09: 0000000000000000
[  203.898593][ T7580] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  203.906596][ T7580] R13: 0000000000000000 R14: 00007fe095b75fa0 R15: 00007ffd371ab4f8
[  203.914623][ T7580]  </TASK>
[  203.983131][ T7580] wakeup trace: Couldn't activate tracepoint probe to kernel_sched_wakeup_new

It reports the error that it couldn't activate the probe.

I also notice that this doesn't percolate up enough to know that this
failed. In tracing_start_sched_switch() we have:

	if (sched_register && (sched_cmdline_ref || sched_tgid_ref))
		tracing_sched_register();

Where it ignores the return value of tracing_sched_register(). When it goes
to disable sched switch tracing, it passes in NULL to the unregister which
triggers your warning.

Yeah, we probably should have this fixed, but as this will only happen
under extreme memory pressure where there's a lot of other things that will
likely fail, it is something I'll take a patch for, but it is way too low
on my priority list to worry about it.

-- Steve
