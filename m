Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B01D555;
	Thu, 23 Jul 2026 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767934; cv=none; b=q01YjElnMqHliS6nWOWCrAc8/SEIX7dKnoNeArZRgtzIqenP4srYkQYs6TYz7VWAB9jNjaiHmsiIeIi5SDsi7YxIOzKMRdBDWpfnAwU2BBu7f+iOxAyf0tHGd8nocmZ4LCX4dQDOX+vZ2Xg06kQHvUsSAfy36DZJIPKCml2GfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767934; c=relaxed/simple;
	bh=F0IJkLSxOGl/i3KqYbanD8J6MBguv18YLYGFP07vZKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXWrEdDjxZ86nBrsMS0teOGiefPLvskdeymTrQjIK00Mk7v5fFbKLjdB13NsTKESr1QAKVlXG/mFZJOL4YISh4B9KtKYiDVzPF7nDTj6tS35T8DWk5b9Nr0rJKU6dfJqzPukTrnT1PTzllbCk0UmWpMmh4MOLlxD0xn1w9dC/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 67522A0365;
	Thu, 23 Jul 2026 00:52:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 9A2292F;
	Thu, 23 Jul 2026 00:52:08 +0000 (UTC)
Date: Wed, 22 Jul 2026 20:52:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Add mutex to trace_parser to fix concurrent
 write races
Message-ID: <20260722205207.58a6009b@robin>
In-Reply-To: <20260715081937.1469757-1-wutengda@huaweicloud.com>
References: <20260715081937.1469757-1-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A2292F
X-Stat-Signature: 7hjd1ee5zp3iuscz94riymoxd5u7awwc
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jSjtEwh2lQgA/chfB+ObKSLDvBuFrpiY=
X-HE-Tag: 1784767928-445884
X-HE-Meta: U2FsdGVkX18CMZ1ZfpQRtwHJNHXwDSCDzSQ8OwLIWE6I936Ya/i+r7L7sSpUy4D1T8QQZmWJXZHCDZg19cAiNjwuytAyjD4XexX0Jr++z2RQd76Rn2Xoo9XX4Nec8CjuVPvvvcyedwWyhaKSG/1Im9D3XFBRPQWHBEwg1kUOYPXiX+PD3etPC6dvyYdFv2u27E2Mga1gIkuDSqkTsaWPcsKWkdxUxMY/hQId81w3ff91efw5Gtj7GNF6MfLiz9BK7ABjqzBaFebLRnuia142Y3uVQOt4rtsnvNjnKGyETcITZW4aOBu/dlYJuK0ugHe9UmKHbOI4bB0t8mYZShGRGNBTpyT+qXc2lZRRGG01NQvKVrsCvnscow==

On Wed, 15 Jul 2026 08:19:37 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:

> The trace_parser structure is allocated and initialized when a trace
> file is opened, and is subsequently used in the write handler to parse
> user input. If userspace opens a trace file descriptor and shares it
> across multiple threads, concurrent write calls will race on the
> parser's internal state, specifically the idx, cont, and buffer fields,
> leading to corrupted input or undefined behavior.
> 
> Fix this by embedding a mutex directly in struct trace_parser. The mutex
> is initialized in trace_parser_get_init() and destroyed in
> trace_parser_put(). All write-side users that access parser state
> (trace_get_user() followed by checking trace_parser_loaded() /
> trace_parser_cont() against the buffer) now hold the mutex across the
> full critical section, avoiding any TOCTOU gap between the parse and the
> subsequent consumption of parser->buffer.
> 
> Fixes: e704eff3ff51 ("ftrace: Have set_graph_function handle multiple functions in one write")
> Fixes: 689fd8b65d66 ("tracing: trace parser support for function and graph")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
> v2: Add proper lockdep assertions to enforce that the parser lock is
>     held by all callers (Steven).
> v1: https://lore.kernel.org/all/20260713134640.708323-1-wutengda@huaweicloud.com/

This triggered a lockdep splat:

[  214.921782] ======================================================
[  214.924654] WARNING: possible circular locking dependency detected
[  214.927502] 7.2.0-rc4-test-00009-gdf004e09835f-dirty #25 Not tainted
[  214.930417] ------------------------------------------------------
[  214.933274] ftrace-test-mco/3440 is trying to acquire lock:
[  214.935879] ffffffff9c3f3a00 (ftrace_lock){+.+.}-{4:4}, at: register_ftrace_function_probe+0x46/0x580
[  214.939970] 
[  214.939970] but task is already holding lock:
[  214.942531] ffffffff9c3f3440 (ftrace_cmd_mutex){+.+.}-{4:4}, at: ftrace_process_regex.isra.0+0x68/0x120
[  214.946327] 
[  214.946327] which lock already depends on the new lock.
[  214.946327] 
[  214.949491] 
[  214.949491] the existing dependency chain (in reverse order) is:
[  214.952351] 
[  214.952351] -> #2 (ftrace_cmd_mutex){+.+.}-{4:4}:
[  214.954682]        __mutex_lock+0xdb/0x10a0
[  214.956466]        ftrace_process_regex.isra.0+0x68/0x120
[  214.958555]        ftrace_regex_write.part.0.isra.0+0xc5/0x150
[  214.960767]        vfs_write+0xd0/0x5a0
[  214.962311]        ksys_write+0x79/0xf0
[  214.963871]        do_syscall_64+0x7e/0x7d0
[  214.965444]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  214.967425] 
[  214.967425] -> #1 (&parser->lock){+.+.}-{4:4}:
[  214.969537]        __mutex_lock+0xdb/0x10a0
[  214.971054]        trace_pid_write+0x105/0x2d0
[  214.972666]        pid_write.isra.0+0xc0/0x360
[  214.974263]        vfs_write+0xd0/0x5a0
[  214.975699]        ksys_write+0x79/0xf0
[  214.977119]        do_syscall_64+0x7e/0x7d0
[  214.978633]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  214.980544] 
[  214.980544] -> #0 (ftrace_lock){+.+.}-{4:4}:
[  214.982584]        __lock_acquire+0x1496/0x23b0
[  214.984211]        lock_acquire+0xdb/0x310
[  214.985702]        __mutex_lock+0xdb/0x10a0
[  214.987220]        register_ftrace_function_probe+0x46/0x580
[  214.989169]        ftrace_trace_probe_callback.isra.0+0x76/0xe0
[  214.991168]        ftrace_process_regex.isra.0+0xb2/0x120
[  214.993036]        ftrace_regex_write.part.0.isra.0+0xc5/0x150
[  214.995018]        vfs_write+0xd0/0x5a0
[  214.996448]        ksys_write+0x79/0xf0
[  214.997873]        do_syscall_64+0x7e/0x7d0
[  214.999399]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  215.001301] 
[  215.001301] other info that might help us debug this:
[  215.001301] 
[  215.004055] Chain exists of:
[  215.004055]   ftrace_lock --> &parser->lock --> ftrace_cmd_mutex
[  215.004055] 
[  215.007461]  Possible unsafe locking scenario:
[  215.007461] 
[  215.009549]        CPU0                    CPU1
[  215.011160]        ----                    ----
[  215.012790]   lock(ftrace_cmd_mutex);
[  215.014161]                                lock(&parser->lock);
[  215.016174]                                lock(ftrace_cmd_mutex);
[  215.018247]   lock(ftrace_lock);
[  215.019513] 
[  215.019513]  *** DEADLOCK ***
[  215.019513] 
[  215.021679] 3 locks held by ftrace-test-mco/3440:
[  215.023342]  #0: ffff8bf9c16d5450 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x79/0xf0
[  215.026030]  #1: ffff8bf9c44108b0 (&parser->lock){+.+.}-{4:4}, at: ftrace_regex_write.part.0.isra.0+0x47/0x150
[  215.029259]  #2: ffffffff9c3f3440 (ftrace_cmd_mutex){+.+.}-{4:4}, at: ftrace_process_regex.isra.0+0x68/0x120
[  215.032448] 
[  215.032448] stack backtrace:
[  215.034100] CPU: 1 UID: 0 PID: 3440 Comm: ftrace-test-mco Not tainted 7.2.0-rc4-test-00009-gdf004e09835f-dirty #25 PREEMPT(lazy) 
[  215.034104] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  215.034105] Call Trace:
[  215.034107]  <TASK>
[  215.034109]  dump_stack_lvl+0x6e/0xa0
[  215.034118]  print_circular_bug.cold+0x185/0x1d0
[  215.034125]  check_noncircular+0x148/0x170
[  215.034130]  __lock_acquire+0x1496/0x23b0
[  215.034133]  ? save_trace+0x53/0x360
[  215.034140]  lock_acquire+0xdb/0x310
[  215.034142]  ? register_ftrace_function_probe+0x46/0x580
[  215.034149]  __mutex_lock+0xdb/0x10a0
[  215.034153]  ? register_ftrace_function_probe+0x46/0x580
[  215.034156]  ? ftrace_process_regex.isra.0+0x68/0x120
[  215.034159]  ? register_ftrace_function_probe+0x46/0x580
[  215.034162]  ? lock_acquire+0xeb/0x310
[  215.034167]  ? register_ftrace_function_probe+0x46/0x580
[  215.034170]  register_ftrace_function_probe+0x46/0x580
[  215.034174]  ? ftrace_process_regex.isra.0+0x68/0x120
[  215.034176]  ? __might_fault+0x44/0xa0
[  215.034182]  ftrace_trace_probe_callback.isra.0+0x76/0xe0
[  215.034187]  ftrace_process_regex.isra.0+0xb2/0x120
[  215.034191]  ftrace_regex_write.part.0.isra.0+0xc5/0x150
[  215.034195]  vfs_write+0xd0/0x5a0
[  215.034200]  ? rcu_is_watching+0x11/0x50
[  215.034206]  ? fput_close_sync+0x79/0xe0
[  215.034211]  ksys_write+0x79/0xf0
[  215.034214]  do_syscall_64+0x7e/0x7d0
[  215.034218]  ? trace_hardirqs_off+0xd/0x30
[  215.034222]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  215.034224] RIP: 0033:0x7feefb1a17d2
[  215.034228] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
[  215.034230] RSP: 002b:00007ffe0dae2bc0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  215.034233] RAX: ffffffffffffffda RBX: 00007feefb2f95c0 RCX: 00007feefb1a17d2
[  215.034235] RDX: 0000000000000014 RSI: 000055d4f7f6d5d0 RDI: 0000000000000001
[  215.034237] RBP: 0000000000000014 R08: 0000000000000000 R09: 0000000000000000
[  215.034238] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000014
[  215.034240] R13: 000055d4f7f6d5d0 R14: 000055d4f7f6f3f0 R15: 0000000000000008
[  215.034245]  </TASK>

Your original patch doesn't have this issue. But I still hate the fact
that the lock is part of the parser. I would say let's make a global
mutex for the parsing in the ftrace code (parser_lock) and replace all
the mutex_lock(&parser->lock) with mutex_lock(&parser_lock).

Also add a comment to explain what the lock is protecting by the
declaration of the lock.

Thanks,

-- Steve
