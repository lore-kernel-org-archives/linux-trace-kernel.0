Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21262F8E87;
	Thu,  6 Aug 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052802; cv=none; b=Fnim2oE3vnD539FYsboj/fW3e3A2jWSYl9ngELt5hP7yeV6xgqRXQX117nBMj6jDncwEIDtXEfCAhypwXcrpLYSs3+GTMpjH9apWLFdsqcpdu0t+nu2aOWcmg9ssTvx4ODpaRa3hr0ysTYDkYLjNt7TMxCigtMqtTxdW5W1USRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052802; c=relaxed/simple;
	bh=PLWK9wh9jgzHFXbUhmH/Y5Z5mXLgSGoiPGF+OZFYR5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgJyLbzyj1PtgYBzJTQc6fq8NmjwVJMpsIkgWjxToZem4waJeP4Q4tn52eNfo/pJFWTtRRmlMVlhKRcaepQyeu4FPs8BpwYb4ghxmqCnZfxzvKmppNwfxj9gEqxRZWY+Qhd9qUj0xE0Icr4ALmdeZxF7LYL+piHFXwLVcJtkJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 6963E1A0318;
	Thu,  6 Aug 2026 21:46:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 8A6C16000F;
	Thu,  6 Aug 2026 21:46:37 +0000 (UTC)
Date: Thu, 6 Aug 2026 17:46:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in trace_rb_cpu_prepare
Message-ID: <20260806174638.6012fa24@gandalf.local.home>
In-Reply-To: <6a742c22.9c11d2ce.289b96.0095.GAE@google.com>
References: <6a707c4f.13bfb6d0.1ecdd5.027e.GAE@google.com>
	<6a742c22.9c11d2ce.289b96.0095.GAE@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8A6C16000F
X-Stat-Signature: 5cpcptqft6k9671twbokugux15q8jfi1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+0VdaYygvfMZw7YZB4wMkPmH/1eb+Xf+4=
X-HE-Tag: 1786052797-162721
X-HE-Meta: U2FsdGVkX1962YZzEfPX4t72PhYqpj496EMitBpmQ4mzi87yqoznJaI9oENcFs7zCK+x4u/LBhnOVCPeleOoY59Und91ycVXiR3oZJGMi0OeGZk59wrjKSVl0AD6wEtcAZZKM2U1l6IJQHj9ImfVWFEaQ9TKwKJsWSAFVUGXjmu/tgSsSkGtYxBfsgDPwKdK9eeKqpfixK72Czvh6jTzSdTm3gmSxhP8lIbvCL2x/7pQkUMAzBvgwhZqVqBebu9GgNVjDpDIUFmMtsxUZPQfrgYvkacAhE0RKCx+VLWKxBdCr6IqqePtp0gvDMqJh/zeDXRVIBD5a/Odt0zV3JJjdktZBtAB/CV/kBMZuZu4bUAj0F5mrSTPD5UxcSOePB5M

On Wed, 05 Aug 2026 23:39:30 -0700
syzbot <syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com> wrote:

> ------------[ cut here ]------------
> failed to allocate ring buffer on CPU 1
> WARNING: kernel/trace/ring_buffer.c:7976 at trace_rb_cpu_prepare+0x458/0x500 kernel/trace/ring_buffer.c:7976, CPU#1: syz.1.24/6005
> Modules linked in:
> CPU: 1 UID: 0 PID: 6005 Comm: syz.1.24 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
> RIP: 0010:trace_rb_cpu_prepare+0x45a/0x500 kernel/trace/ring_buffer.c:7976
> Code: 48 c1 ea 03 80 3c 02 00 0f 84 c7 fc ff ff 48 8b 3c 24 e8 29 0e 6c 00 e9 b9 fc ff ff e8 ff 83 fb ff 48 8d 3d b8 cc 17 0f 89 ee <67> 48 0f b9 3a bb f4 ff ff ff e9 df fd ff ff 4c 89 ef e8 ff 0d 6c
> RSP: 0018:ffffc900036bf8c0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88807a7604b8 RCX: ffff88807bafcf88
> RDX: ffff88807b2dca80 RSI: 0000000000000001 RDI: ffffffff9126ada0
> RBP: 0000000000000001 R08: ffff88807bafcf88 R09: 0000000000000000
> R10: 0000000000000001 R11: ffffffff81000130 R12: 0000000000000001
> R13: ffff88807a760410 R14: 0000000000000008 R15: 0000000000000162
> FS:  00007f7d853056c0(0000) GS:ffff888123ed8000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f118d5e5ff8 CR3: 000000006ff97000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  cpuhp_invoke_callback+0x205/0x9a0 kernel/cpu.c:204
>  cpuhp_issue_call+0x1b8/0x970 kernel/cpu.c:2354
>  __cpuhp_state_add_instance_cpuslocked+0x2d7/0x400 kernel/cpu.c:2423
>  __cpuhp_state_add_instance+0xd7/0x2d0 kernel/cpu.c:2444
>  cpuhp_state_add_instance include/linux/cpuhotplug.h:384 [inline]
>  alloc_buffer+0x76c/0x1800 kernel/trace/ring_buffer.c:2830
>  __ring_buffer_alloc+0x2d/0x40 kernel/trace/ring_buffer.c:2872
>  allocate_trace_buffer+0x150/0xa30 kernel/trace/trace.c:8412
>  allocate_trace_buffers kernel/trace/trace.c:8445 [inline]
>  trace_array_create_systems+0x582/0xc30 kernel/trace/trace.c:8623
>  trace_array_create kernel/trace/trace.c:8666 [inline]
>  instance_mkdir+0xca/0x140 kernel/trace/trace.c:8681
>  tracefs_syscall_mkdir+0x10e/0x180 fs/tracefs/inode.c:121

So you ran out of memory creating too many instances or something?

Yeah, that will trigger a warning.

-- Steve


>  vfs_mkdir+0x361/0x850 fs/namei.c:5276
>  filename_mkdirat+0x48b/0x5e0 fs/namei.c:5309
>  __do_sys_mkdirat fs/namei.c:5330 [inline]
>  __se_sys_mkdirat fs/namei.c:5327 [inline]
>  __x64_sys_mkdirat+0x89/0xc0 fs/namei.c:5327
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
