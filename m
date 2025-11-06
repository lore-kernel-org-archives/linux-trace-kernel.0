Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31B137932;
	Thu,  6 Nov 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447930; cv=none; b=Hz7kWHBgvr8Ma6hEWhn0fTyyA9cfT5WFi1+slzq/EnTGDOACQDNqOgSJPexz5nMzktrYtc6Gmd9Edsz/I4zA7NiEA697wMljtrA/OGy+Ovt+FySnxJtFsQHB+o2ZPvMKBfQKbKwPZX5HQ9u8A8qr+mwu8P8JwRnmELLWuwoYpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447930; c=relaxed/simple;
	bh=oN3GXkIarMfXtltrEnr18z/wQu882uSM+visD53ptdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ctz1gYr3mC+ZhgLKELpbcUoXIz9T7F4cVdecV/ivDEDAzb+MCzXHLVb5LAeooFKcz7YUucyF/nt84M4xhDq4AIwKiqYovH6lunScFA6Fx1jqRAoQLzl8q8miAX2befAEJSYTViujJGYz03aIgjZuPI14IiwBmnVj2gXONvTVupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrgWgGW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrgWgGW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE43C4CEF7;
	Thu,  6 Nov 2025 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762447929;
	bh=oN3GXkIarMfXtltrEnr18z/wQu882uSM+visD53ptdI=;
	h=From:To:Cc:Subject:Date:From;
	b=PrgWgGW1fAZBBSn7TU15fO93nXWJSPOGIZdCd34rodOjYwIxcBGhdafh/DB7+lpIe
	 eNU+lIHrUeBq0Bx8nx3f0RPtavjnQoFaxYKf6IX6UE6IHyaNlI5CNo0keA0qvC5F55
	 8OcuW2fIEN0gOMWthL2yXHcmMBO1UAsVF/3d/clViYo08wuWVoF0zt+LQK+hG+BYIQ
	 5c0J+fj95Jf9BDjnKFXfFzeWxWRdCnNv8hEfEMG7C01D4QTo6kIWD5NSODZKv7EQTb
	 B7rBWhMYQeqh+uRSjOxH5Z1TKVJPxhbcYgD8xLMC9/eNHF19CM2ECLkr/dHWSlS3HM
	 nEc/+WvXK4GRQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Beau Belgrave <beaub@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: tprobe-events: Fixes for tprobe events
Date: Fri,  7 Nov 2025 01:52:05 +0900
Message-ID: <176244792552.155515.3285089581362758469.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Beau reported tprobe example in the document does not work on 6.17
kernel.

---
echo "t sched_switch preempt prev_pid=prev->pid next_pid=next->pid" > /sys/kernel/tracing/dynamic_events
echo 1 > /sys/kernel/tracing/events/tracepoints/sched_switch/enable
cat /sys/kernel/tracing/trace_pipe
---

It seems that the tracepoint callback is not correctly set. So I tried
to trace the actual function calls and the local variables.
(I need to enable CONFIG_KPROBE_EVENTS_ON_NOTRACE for tracing ftrace
code itself.)

With the below commands, I got some probe definitions for debug:

 $ perf probe -k vmlinux -D "tracepoint_user_find_get name:string"
 $ perf probe -k vmlinux -D '__regsiter_tracepoint_fprobe:13 tuser tuser->tpoint'
 $ perf probe -k vmlinux -D 'register_fprobe_ips addrs[1]'
 $ perf probe -k vmlinux -D 'register_fprobe_ips%return ret=$retval'
 $ perf probe -k vmlinux -D '__regsiter_tracepoint_fprobe tf->tprobe'
 $ perf probe -k vmlinux -D 'tracepoint_probe_register_prio_may_exist tp'
 $ perf probe -k vmlinux -D 'tracepoint_probe_register_prio_may_exist%return ret=$retval'
 $ perf probe -k vmlinux -D '__tracepoint_user_init name:string'

And run below commands on the machine:

-----
 $ cat > /sys/kernel/tracing/dynamic_events << EOF
p:probe/tracepoint_user_find_get enable_trace_fprobe+271 name_string=+0(%bp):string
p:probe/regsiter_tracepoint_fprobe_L13 enable_trace_fprobe+692 tuser=%r13 tpoint=+24(%r13)
p:probe/regsiter_tracepoint_fprobe_L13_1 enable_trace_fprobe+685 tuser=%r13 tpoint=+24(%r13)
p:probe/register_fprobe_ips register_fprobe_ips+0 addrs=+8(%si):u64
r:probe/register_fprobe_ips__return register_fprobe_ips+0 ret=\$retval
p:probe/regsiter_tracepoint_fprobe enable_trace_fprobe+247 tprobe=+80(-96(%r14)):u8
p:probe/tracepoint_probe_register_prio_may_exist tracepoint_probe_register_prio_may_exist+0 tp=%di
r:probe/tracepoint_probe_register_prio_may_exist__return tracepoint_probe_register_prio_may_exist+0 ret=\$retval
p:probe/tracepoint_user_init enable_trace_fprobe+440 name_string=+0(%bp):string
EOF
 $ echo 1 > /sys/kernel/tracing/events/probe/enable

 $ echo "t sched_switch preempt prev_pid=prev->pid next_pid=next->pid" >> /sys/kernel/tracing/dynamic_events
 $ echo 1 > /sys/kernel/tracing/events/tracepoints/sched_switch/enable
 $ cat /sys/kernel/tracing/trace
-----

And I got below trace data:

-----
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
              sh-107     [005] ..Zff     7.290496: regsiter_tracepoint_fprobe: (enable_trace_fprobe+0xf7/0x3a0) tprobe=0
              sh-107     [005] ..Zff     7.290547: tracepoint_user_find_get: (enable_trace_fprobe+0x10f/0x3a0) name_string="sched_switch"
              sh-107     [005] ..Zff     7.290680: tracepoint_user_init: (enable_trace_fprobe+0x1b8/0x3a0) name_string="sched_switch"
              sh-107     [005] ..Zff     7.290727: regsiter_tracepoint_fprobe_L13_1: (enable_trace_fprobe+0x2ad/0x3a0) tuser=0xffff88800538b280 tpoint=0xffffffff82a4ac10
              sh-107     [005] ..Zff     7.290730: regsiter_tracepoint_fprobe_L13: (enable_trace_fprobe+0x2b4/0x3a0) tuser=0xffff88800538b280 tpoint=0xffffffff82a4ac10
              sh-107     [005] ..Zff     7.290735: register_fprobe_ips: (register_fprobe_ips+0x4/0x310) addrs=18446612682157410880
              sh-107     [005] .....     7.311345: register_fprobe_ips__return: (enable_trace_fprobe+0x2f6/0x3a0 <- register_fprobe_ips) ret=0
-----

No tracepoint_probe_register_prio_may_exist event is recorded, but 
tracepoint_user_init and regsiter_tracepoint_fprobe_L13_1 (call-site
of tracepoint_user_init()) are recorded and `tuser` and `tpoint`
are not NULL or error.

This means when the tprobe is enabled, the register_tracepoint_fprobe()
eventually calls tracepoint_user_init() correctly. However, it does not
call tracepoint_probe_register_prio_may_exist() to register tracepoint
callback. So the bug is inside tracepoint_user_init(), not NULL return
path.

-----
static struct tracepoint_user *__tracepoint_user_init(const char *name, struct tracepoint *tpoint)
{
	struct tracepoint_user *tuser __free(tuser_free) = NULL;
	int ret;

	tuser = kzalloc(sizeof(*tuser), GFP_KERNEL);
	if (!tuser)
		return NULL;
	tuser->name = kstrdup(name, GFP_KERNEL);
	if (!tuser->name)
		return NULL;

	if (tpoint) {
		ret = tracepoint_user_register(tuser); /* forgot to set tuser->tpoint */
		if (ret)
			return ERR_PTR(ret);
	}
-----

And found it forgot to set tuser->tpoint before calling
tracepoint_user_register() which calls
tracepoint_probe_register_prio_may_exist(tuser->tpoint).
To fix that, I just moved the tuser->tpoint setting line
right before tracepoint_user_register() call [1/2].

I also found another issue when I switched enable and disable[2/2].

I hope this report will help someone to do similar debug by tracing.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing: tprobe-events: Fix to register tracepoint correctly
      tracing: tprobe-events: Fix to put tracepoint_user when disable the tprobe


 kernel/trace/trace_fprobe.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
