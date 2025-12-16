Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36B33AD8B;
	Tue, 16 Dec 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927397; cv=none; b=mYkCzb+v/ozgwkfGT3Q/2LHxCurdXPXzFmhXOe9pOzQBdZMikxgqeKBcX8vJ78y7/9ntr5Nn6YBm16YrjPQu9ItOspphQW2v3naFsztS0kFMobmX1vAcBNZy6dCGtnxMxeEz3tMdvcMOFLLSJsf96y5VOFrfBCr3GUdvrd21txE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927397; c=relaxed/simple;
	bh=pvQQhgZhYKxO9O4tU1ezi7R2tbfU60xbOK3YL54nBds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GOoExjh0h5AkQbpWgcbuG7nzwrT3Lb2S14+ZpmUgtVbcLEfXv/I9vAN61P1+fo3k37+scsCF8IYrvEHOh+An67xFcduu261Rajc28ajrIs2wS/9vmn8S3XFC6A2TROa4rDXaidc5kmmrHi+12ANUMZuw2i3Rdbqwrek2R/nJiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0BC8C60833;
	Tue, 16 Dec 2025 23:23:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 055152001F;
	Tue, 16 Dec 2025 23:23:05 +0000 (UTC)
Date: Tue, 16 Dec 2025 18:24:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ian Rogers <irogers@google.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>
Subject: [PATCH] tracing: Do not register unsupported perf events
Message-ID: <20251216182440.147e4453@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 055152001F
X-Stat-Signature: dg4hffjb51epnkepp4amewcf34k1rtgj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Ap32m7i8u8MbwgEPyRZ7oscMtpQNpyw4=
X-HE-Tag: 1765927385-372291
X-HE-Meta: U2FsdGVkX1/dr7fBTe7jP+jtqR+fNhizLXMadqw5x7cNcBBxsRXBavLxuwCPgb1EdNbFGmguP7N3v+tqrFBDyHKRIh6ViZughzkxTnfrgNFSjNoAnkdqhColRVg2WuLldNT7aYo31zrZg8Z38oBluTJpo5HFkB7pNEcCVPHWLpvyg9Ajr9DO/ZqIspU+OCs/RvtVoqR/qWV7dhvvsWvedzZzQj40Z3Z/5kVQoe+VrLLbFbDd4dOMDtP911naU/LUkMqEYXM7ODqAbAqH8vjcTNCm2FDGYLf1dYMMWwX3rYMj4jYsmhPT7tkPe6mmdQMbZHAA+c6MXNTvx/5T69eXn0I8EWvXH4q9/ms8Nfum32rX+AXHvOfqeEjgxTMBnDR/tf4kQQQr/YzyzKJId0yvLQ3RRhNbn16cAhBFuIb+oRM=

From: Steven Rostedt <rostedt@goodmis.org>

Synthetic events currently do not have a function to register perf events.
This leads to calling the tracepoint register functions with a NULL
function pointer which triggers:

 ------------[ cut here ]------------
 WARNING: kernel/tracepoint.c:175 at tracepoint_add_func+0x357/0x370, CPU#2: perf/2272
 Modules linked in: kvm_intel kvm irqbypass
 CPU: 2 UID: 0 PID: 2272 Comm: perf Not tainted 6.18.0-ftest-11964-ge022764176fc-dirty #323 PREEMPTLAZY
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
 RIP: 0010:tracepoint_add_func+0x357/0x370
 Code: 28 9c e8 4c 0b f5 ff eb 0f 4c 89 f7 48 c7 c6 80 4d 28 9c e8 ab 89 f4 ff 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc <0f> 0b 49 c7 c6 ea ff ff ff e9 ee fe ff ff 0f 0b e9 f9 fe ff ff 0f
 RSP: 0018:ffffabc0c44d3c40 EFLAGS: 00010246
 RAX: 0000000000000001 RBX: ffff9380aa9e4060 RCX: 0000000000000000
 RDX: 000000000000000a RSI: ffffffff9e1d4a98 RDI: ffff937fcf5fd6c8
 RBP: 0000000000000001 R08: 0000000000000007 R09: ffff937fcf5fc780
 R10: 0000000000000003 R11: ffffffff9c193910 R12: 000000000000000a
 R13: ffffffff9e1e5888 R14: 0000000000000000 R15: ffffabc0c44d3c78
 FS:  00007f6202f5f340(0000) GS:ffff93819f00f000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055d3162281a8 CR3: 0000000106a56003 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  tracepoint_probe_register+0x5d/0x90
  synth_event_reg+0x3c/0x60
  perf_trace_event_init+0x204/0x340
  perf_trace_init+0x85/0xd0
  perf_tp_event_init+0x2e/0x50
  perf_try_init_event+0x6f/0x230
  ? perf_event_alloc+0x4bb/0xdc0
  perf_event_alloc+0x65a/0xdc0
  __se_sys_perf_event_open+0x290/0x9f0
  do_syscall_64+0x93/0x7b0
  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ? trace_hardirqs_off+0x53/0xc0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Instead, have the code return -ENODEV, which doesn't warn and has perf
error out with:

 # perf record -e synthetic:futex_wait
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (synthetic:futex_wait).
"dmesg | grep -i perf" may provide additional information.

Ideally perf should support synthetic events, but for now just fix the
warning. The support can come later.

Cc: stable@vger.kernel.org
Fixes: 4b147936fa509 ("tracing: Add support for 'synthetic' events")
Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a5a93d243047..754b14ca87a7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -710,6 +710,8 @@ int trace_event_reg(struct trace_event_call *call,
 
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
+		if (!call->class->perf_probe)
+			return -ENODEV;
 		return tracepoint_probe_register(call->tp,
 						 call->class->perf_probe,
 						 call);
-- 
2.51.0

