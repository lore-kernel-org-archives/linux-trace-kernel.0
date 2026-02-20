Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26543112C1;
	Fri, 20 Feb 2026 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576547; cv=none; b=VFz+3Hga8+iZDpG6kY7Z3osVZQQNa5fbwZTHgt4iKpjYgwVXK4g1s2HL6t4b+Zjpmc9YmZ+6AkzyRWX3vKpn74hrAl/MqbjSzAfG7byIsnw7n+6eFs7hMnz8i2Du7v8nKX5lc8hDuHK0Jr08F09GVEreZ6CfyP1CIEyv4/DB2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576547; c=relaxed/simple;
	bh=zEl1Pub19ZEEgLZLHZr68KrNJy/dx8AW6TQrZwJfB5Q=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=pBAcASxUeFEHF4r3x3ii5IR0UYr6SZwe9WbNsLRude7oDzDiqsQRPk7EwR9Srs3ySHx1NmS84oTMOc3o8LGIYVQJcA3PcBfMhx8m8vnFM2rYZsOmQmRbd8NTdwI8TWY/hkeobWTlQ2RTJe2vBZUBaEOsl/6EPg96lV/vkZgtqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnQ0wDKX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnQ0wDKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BDDC116D0;
	Fri, 20 Feb 2026 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771576547;
	bh=zEl1Pub19ZEEgLZLHZr68KrNJy/dx8AW6TQrZwJfB5Q=;
	h=Date:From:To:Cc:Subject:From;
	b=BnQ0wDKX1WkmTo6X/55vAjuyuArxMlRYmPsng+jqO0gftihqqxvyxAkPCcy1GrQZQ
	 WpSRYlgQVXkUvyDtZveC/JdcY4OynDlB8HlR8QFIopS9NvVf5icJ8WKCDkUaOE5/wz
	 exngV8EspDbOyGf+F5NBCDQVSrZyyhc6yf2FVaJ5Re5xjIHNOttKekX2pzuR5bGhUP
	 wo/iOuMtSYnQSCYD6N+InmKlldHAOS94fvmow6FmYRGzfv1tf0kWkUrf4zUPHZ2Ptq
	 Gh7+Qt/CmJQ8mdd8kObc0e/cfSjjSKMdWOO6fcylvZ4FtynPcwzJdoC7EotqT27mzr
	 vN8JCVY4JS1Eg==
Date: Fri, 20 Feb 2026 17:35:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [BUG] suspicious RCU usage in event_filter_pid_sched_process_fork()
Message-Id: <20260220173544.11d66361d0e2fa5fe1ff8816@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On the latest tracing/for-next branch, I hit the following
suspicious RCU usage in event_filter_pid_sched_process_fork().
It seems that kernel_clone() calls back this event without
holding rcu_read_lock().

[37] event tracing - restricts events based on pid notrace filtering[  156.217609] 
[  156.218272] =============================
[  156.219569] WARNING: suspicious RCU usage
[  156.220887] 6.19.0-09924-g9678e53179aa #38 Not tainted
[  156.222336] -----------------------------
[  156.223481] kernel/trace/trace_events.c:1057 suspicious rcu_dereference_check() usage!
[  156.225660] 
[  156.225660] other info that might help us debug this:
[  156.225660] 
[  156.227958] 
[  156.227958] rcu_scheduler_active = 2, debug_locks = 1
[  156.229815] no locks held by ftracetest/4360.
[  156.231103] 
[  156.231103] stack backtrace:
[  156.232415] CPU: 1 UID: 0 PID: 4360 Comm: ftracetest Not tainted 6.19.0-09924-g9678e53179aa #38 PREEMPT(lazy) 
[  156.232418] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  156.232419] Call Trace:
[  156.232422]  <TASK>
[  156.232425]  dump_stack_lvl+0x67/0x90
[  156.232430]  lockdep_rcu_suspicious+0x154/0x1a0
[  156.232436]  event_filter_pid_sched_process_fork+0x9a/0xd0
[  156.232440]  kernel_clone+0x367/0x3a0
[  156.232448]  __x64_sys_clone+0x116/0x140
[  156.232454]  do_syscall_64+0x158/0x460
[  156.232457]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  156.232459]  ? trace_irq_disable+0x1d/0xc0
[  156.232464]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  156.232466] RIP: 0033:0x4697c3
[  156.232470] Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
[  156.232472] RSP: 002b:00007ffd8a0c1d58 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  156.232474] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004697c3
[  156.232476] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  156.232477] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000026970990
[  156.232478] R10: 000000002696e690 R11: 0000000000000246 R12: 0000000000000001
[  156.232479] R13: 0000000026989103 R14: 0000000000000001 R15: 0000000000000000
[  156.232484]  </TASK>
[  156.232495] 
[  156.268667] =============================
[  156.269872] WARNING: suspicious RCU usage
[  156.271089] 6.19.0-09924-g9678e53179aa #38 Not tainted
[  156.272544] -----------------------------
[  156.273704] kernel/trace/trace_events.c:1060 suspicious rcu_dereference_check() usage!
[  156.275903] 
[  156.275903] other info that might help us debug this:
[  156.275903] 
[  156.278122] 
[  156.278122] rcu_scheduler_active = 2, debug_locks = 1
[  156.279962] no locks held by ftracetest/4360.
[  156.281216] 
[  156.281216] stack backtrace:
[  156.282551] CPU: 1 UID: 0 PID: 4360 Comm: ftracetest Not tainted 6.19.0-09924-g9678e53179aa #38 PREEMPT(lazy) 
[  156.282553] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  156.282555] Call Trace:
[  156.282558]  <TASK>
[  156.282560]  dump_stack_lvl+0x67/0x90
[  156.282566]  lockdep_rcu_suspicious+0x154/0x1a0
[  156.282572]  event_filter_pid_sched_process_fork+0xcd/0xd0
[  156.282576]  kernel_clone+0x367/0x3a0
[  156.282584]  __x64_sys_clone+0x116/0x140
[  156.282589]  do_syscall_64+0x158/0x460
[  156.282592]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  156.282594]  ? trace_irq_disable+0x1d/0xc0
[  156.282600]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  156.282602] RIP: 0033:0x4697c3
[  156.282606] Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
[  156.282608] RSP: 002b:00007ffd8a0c1d58 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  156.282610] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004697c3
[  156.282611] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  156.282612] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000026970990
[  156.282613] R10: 000000002696e690 R11: 0000000000000246 R12: 0000000000000001
[  156.282615] R13: 0000000026989103 R14: 0000000000000001 R15: 0000000000000000
[  156.282621]  </TASK>

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
