Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D38282F5;
	Fri, 24 Jan 2025 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737682913; cv=none; b=e96nAxXXJmJPzxI6FCR9L7EaqldVpskWBJ2uy8JnTtaTD4fVqrwcVqhhOHXJeoWjh225Fkz74XHBIuzvqIGYv9kKwANpCVQQLqpDWFYfu1OyXjXRe5Y5OzRYrGYEzXtW/TvgK6n4yzH2glKwnukhHYUgmWvs0Lg/ObrZmer6tfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737682913; c=relaxed/simple;
	bh=vvVHDhTPndi+odOKz+iiK7RYxc7yd+2jWYE0EP/Xz/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=feeijyXWbcIPpqY30J8RJrzFjN2jt3+9WJYwE8nHn2zzgVuBFxzbad9WDglYWDMlNdARRgUxIoIKEC828M12Ln2zM8h+E40tkjKDpG/qEUiNHhpPr7Cjlt4J+8QEc+RG+rR1M//Y3P3dntUCh2jpYm7o8SpTCBk/QZtP0ricYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E97FC4CED3;
	Fri, 24 Jan 2025 01:41:51 +0000 (UTC)
Date: Thu, 23 Jan 2025 20:41:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tomas Glozar <tglozar@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [PATCH] tracing/osnoise: Fix resetting of tracepoints
Message-ID: <20250123204159.4450c88e@gandalf.local.home>
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

If a timerlat tracer is started with the osnoise option OSNOISE_WORKLOAD
disabled, but then that option is enabled and timerlat is removed, the
tracepoints that were enabled on timerlat registration do not get
disabled. If the option is disabled again and timelat is started, then it
triggers a warning in the tracepoint code due to registering the
tracepoint again without ever disabling it.

Do not use the same user space defined options to know to disable the
tracepoints when timerlat is removed. Instead, set a global flag when it
is enabled and use that flag to know to disable the events.

 ~# echo NO_OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
 ~# echo timerlat > /sys/kernel/tracing/current_tracer
 ~# echo OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
 ~# echo nop > /sys/kernel/tracing/current_tracer
 ~# echo NO_OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
 ~# echo timerlat > /sys/kernel/tracing/current_tracer

Triggers:

 ------------[ cut here ]------------
 WARNING: CPU: 6 PID: 1337 at kernel/tracepoint.c:294 tracepoint_add_func+0x3b6/0x3f0
 Modules linked in:
 CPU: 6 UID: 0 PID: 1337 Comm: rtla Not tainted 6.13.0-rc4-test-00018-ga867c441128e-dirty #73
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:tracepoint_add_func+0x3b6/0x3f0
 Code: 48 8b 53 28 48 8b 73 20 4c 89 04 24 e8 23 59 11 00 4c 8b 04 24 e9 36 fe ff ff 0f 0b b8 ea ff ff ff 45 84 e4 0f 84 68 fe ff ff <0f> 0b e9 61 fe ff ff 48 8b 7b 18 48 85 ff 0f 84 4f ff ff ff 49 8b
 RSP: 0018:ffffb9b003a87ca0 EFLAGS: 00010202
 RAX: 00000000ffffffef RBX: ffffffff92f30860 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff9bf59e91ccd0 RDI: ffffffff913b6410
 RBP: 000000000000000a R08: 00000000000005c7 R09: 0000000000000002
 R10: ffffb9b003a87ce0 R11: 0000000000000002 R12: 0000000000000001
 R13: ffffb9b003a87ce0 R14: ffffffffffffffef R15: 0000000000000008
 FS:  00007fce81209240(0000) GS:ffff9bf6fdd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055e99b728000 CR3: 00000001277c0002 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  ? __warn.cold+0xb7/0x14d
  ? tracepoint_add_func+0x3b6/0x3f0
  ? report_bug+0xea/0x170
  ? handle_bug+0x58/0x90
  ? exc_invalid_op+0x17/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? __pfx_trace_sched_migrate_callback+0x10/0x10
  ? tracepoint_add_func+0x3b6/0x3f0
  ? __pfx_trace_sched_migrate_callback+0x10/0x10
  ? __pfx_trace_sched_migrate_callback+0x10/0x10
  tracepoint_probe_register+0x78/0xb0
  ? __pfx_trace_sched_migrate_callback+0x10/0x10
  osnoise_workload_start+0x2b5/0x370
  timerlat_tracer_init+0x76/0x1b0
  tracing_set_tracer+0x244/0x400
  tracing_set_trace_write+0xa0/0xe0
  vfs_write+0xfc/0x570
  ? do_sys_openat2+0x9c/0xe0
  ksys_write+0x72/0xf0
  do_syscall_64+0x79/0x1c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Cc: stable@vger.kernel.org
Fixes: e88ed227f639e ("tracing/timerlat: Add user-space interface")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index b9f96c77527d..23cbc24ed292 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1229,6 +1229,8 @@ static void trace_sched_migrate_callback(void *data, struct task_struct *p, int
 	}
 }
 
+static bool monitor_enabled;
+
 static int register_migration_monitor(void)
 {
 	int ret = 0;
@@ -1237,16 +1239,25 @@ static int register_migration_monitor(void)
 	 * Timerlat thread migration check is only required when running timerlat in user-space.
 	 * Thus, enable callback only if timerlat is set with no workload.
 	 */
-	if (timerlat_enabled() && !test_bit(OSN_WORKLOAD, &osnoise_options))
+	if (timerlat_enabled() && !test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		if (WARN_ON_ONCE(monitor_enabled))
+			return 0;
+
 		ret = register_trace_sched_migrate_task(trace_sched_migrate_callback, NULL);
+		if (!ret)
+			monitor_enabled = true;
+	}
 
 	return ret;
 }
 
 static void unregister_migration_monitor(void)
 {
-	if (timerlat_enabled() && !test_bit(OSN_WORKLOAD, &osnoise_options))
-		unregister_trace_sched_migrate_task(trace_sched_migrate_callback, NULL);
+	if (!monitor_enabled)
+		return;
+
+	unregister_trace_sched_migrate_task(trace_sched_migrate_callback, NULL);
+	monitor_enabled = false;
 }
 #else
 static int register_migration_monitor(void)
-- 
2.45.2

