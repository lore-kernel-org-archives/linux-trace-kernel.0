Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323923BF9E;
	Tue, 30 Sep 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220395; cv=none; b=qFh3JY4IXPyuqmIP1inu10Q+7MGWCzJqGOZwU0sHWGIyMXAIXWWWUeCiv0SB2lqkdJB4zDvlaoemreK6Yu01D7SB0PuG7nWfYr6WwvFsZVgzfiwYHWxIRnbZl02dXmKttHrdp1yh5i3CD7P22d7w/aOYyCGBjrc+IU3aL9GLPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220395; c=relaxed/simple;
	bh=AveBoPeCQXV32YAl+mI+vpT/h0p2ee4rPM0ZMDaIq9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lf0apfw1LebtJbTCGZ0teM+rAB5O+a21oX5kQ5fkHFWKh8Vy1uFkAGcuAsZHOnJdPNG4KpPemiL56CLnNdmSSxkLlsEKhAO3A0oiXoRx+stxmkblvaGGW5nNwb5CUyixfO5hgdhsPZGGhZ0mHQcZ+ne49JPnn42K/x+C/wcJrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XpcPNZ2X; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XpcPNZ2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=48VZrtj5TS9S03BHiRfBNP7TTsWHh6rjB/NRgnK1MUg=;
	b=XpcPNZ2XvYshacdfg3W26lWS0J8AMoRfW6TPOekUb46jzPAvXuRkjaEgoFolwX
	usIfLndDGtQrBzjtYgMjWcum1f5dSAu+B+8bZp2EeXQpS4bTdpvGa582kKaFwm9M
	crZtalINrYpKvUoUJFDq2ZViZkKwdNeQlVZyU357CCTik=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA37t9pkttooAdtBA--.5066S2;
	Tue, 30 Sep 2025 16:18:51 +0800 (CST)
From: chenyuan_fl@163.com
To: john.ogness@linutronix.de,
	rostedt@goodmis.org,
	peterz@infradead.org
Cc: bigeasy@linutronix.de,
	chenyuan@kylinos.cn,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org
Subject: [PATH v3] tracing: Fix race condition in kprobe initialization causing NULL pointer dereference
Date: Tue, 30 Sep 2025 09:18:48 +0100
Message-Id: <20250930081848.433648-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <84seg5d2p3.fsf@jogness.linutronix.de>
References: <84seg5d2p3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA37t9pkttooAdtBA--.5066S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw48AF13XFy8XF1ftr4UCFg_yoW7Xw1fpa
	nrKws8Kw4kJFyjvrWrtr1Ut3WxtFyfAFWDJryUGw45ZF4UKr1jyF1xXFWUAF13JFWqvFyf
	t3Waqr10vry7JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn5r7UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiJwLYvWjbkIEzQAAAsR

From: Yuan Chen <chenyuan@kylinos.cn>

There is a critical race condition in kprobe initialization that can lead to
NULL pointer dereference and kernel crash.

[1135630.084782] Unable to handle kernel paging request at virtual address 0000710a04630000
...
[1135630.260314] pstate: 404003c9 (nZcv DAIF +PAN -UAO)
[1135630.269239] pc : kprobe_perf_func+0x30/0x260
[1135630.277643] lr : kprobe_dispatcher+0x44/0x60
[1135630.286041] sp : ffffaeff4977fa40
[1135630.293441] x29: ffffaeff4977fa40 x28: ffffaf015340e400
[1135630.302837] x27: 0000000000000000 x26: 0000000000000000
[1135630.312257] x25: ffffaf029ed108a8 x24: ffffaf015340e528
[1135630.321705] x23: ffffaeff4977fc50 x22: ffffaeff4977fc50
[1135630.331154] x21: 0000000000000000 x20: ffffaeff4977fc50
[1135630.340586] x19: ffffaf015340e400 x18: 0000000000000000
[1135630.349985] x17: 0000000000000000 x16: 0000000000000000
[1135630.359285] x15: 0000000000000000 x14: 0000000000000000
[1135630.368445] x13: 0000000000000000 x12: 0000000000000000
[1135630.377473] x11: 0000000000000000 x10: 0000000000000000
[1135630.386411] x9 : 0000000000000000 x8 : 0000000000000000
[1135630.395252] x7 : 0000000000000000 x6 : 0000000000000000
[1135630.403963] x5 : 0000000000000000 x4 : 0000000000000000
[1135630.412545] x3 : 0000710a04630000 x2 : 0000000000000006
[1135630.421021] x1 : ffffaeff4977fc50 x0 : 0000710a04630000
[1135630.429410] Call trace:
[1135630.434828]  kprobe_perf_func+0x30/0x260
[1135630.441661]  kprobe_dispatcher+0x44/0x60
[1135630.448396]  aggr_pre_handler+0x70/0xc8
[1135630.454959]  kprobe_breakpoint_handler+0x140/0x1e0
[1135630.462435]  brk_handler+0xbc/0xd8
[1135630.468437]  do_debug_exception+0x84/0x138
[1135630.475074]  el1_dbg+0x18/0x8c
[1135630.480582]  security_file_permission+0x0/0xd0
[1135630.487426]  vfs_write+0x70/0x1c0
[1135630.493059]  ksys_write+0x5c/0xc8
[1135630.498638]  __arm64_sys_write+0x24/0x30
[1135630.504821]  el0_svc_common+0x78/0x130
[1135630.510838]  el0_svc_handler+0x38/0x78
[1135630.516834]  el0_svc+0x8/0x1b0

kernel/trace/trace_kprobe.c: 1308
0xffff3df8995039ec <kprobe_perf_func+0x2c>:     ldr     x21, [x24,#120]
include/linux/compiler.h: 294
0xffff3df8995039f0 <kprobe_perf_func+0x30>:     ldr     x1, [x21,x0]

kernel/trace/trace_kprobe.c
1308: head = this_cpu_ptr(call->perf_events);
1309: if (hlist_empty(head))
1310: 	return 0;

crash> struct trace_event_call -o
struct trace_event_call {
  ...
  [120] struct hlist_head *perf_events;  //(call->perf_event)
  ...
}

crash> struct trace_event_call ffffaf015340e528
struct trace_event_call {
  ...
  perf_events = 0xffff0ad5fa89f088, //this value is correct, but x21 = 0
  ...
}

Race Condition Analysis:

The race occurs between kprobe activation and perf_events initialization:

  CPU0                                    CPU1
  ====                                    ====
  perf_kprobe_init
    perf_trace_event_init
      tp_event->perf_events = list;(1)
      tp_event->class->reg (2)← KPROBE ACTIVE
                                          Debug exception triggers
                                          ...
                                          kprobe_dispatcher
                                            kprobe_perf_func (tk->tp.flags & TP_FLAG_PROFILE)
                                              head = this_cpu_ptr(call->perf_events)(3)
                                              (perf_events is still NULL)

Problem:
1. CPU0 executes (1) assigning tp_event->perf_events = list
2. CPU0 executes (2) enabling kprobe functionality via class->reg()
3. CPU1 triggers and reaches kprobe_dispatcher
4. CPU1 checks TP_FLAG_PROFILE - condition passes (step 2 completed)
5. CPU1 calls kprobe_perf_func() and crashes at (3) because
   call->perf_events is still NULL

CPU1 sees that kprobe functionality is enabled but does not see that
perf_events has been assigned.

Add pairing read and write memory barriers to guarantee that if CPU1
sees that kprobe functionality is enabled, it must also see that
perf_events has been assigned.

v1->v2: Fix race analysis (per Masami) - kprobe arms in class->reg().
v2->v3: Adopt RELEASE/ACQUIRE semantics per Peter/John's suggestions,
        aligning with Steven's clarification on barrier purposes.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/trace/trace_probe.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 842383fbc03b..98b838591edc 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -274,19 +274,19 @@ struct event_file_link {
 static inline bool trace_probe_test_flag(struct trace_probe *tp,
 					 unsigned int flag)
 {
-	return !!(tp->event->flags & flag);
+	return !!(smp_load_acquire(&tp->event->flags) & flag);
 }
 
 static inline void trace_probe_set_flag(struct trace_probe *tp,
 					unsigned int flag)
 {
-	tp->event->flags |= flag;
+	smp_store_release(&tp->event->flags, tp->event->flags | flag);
 }
 
 static inline void trace_probe_clear_flag(struct trace_probe *tp,
 					  unsigned int flag)
 {
-	tp->event->flags &= ~flag;
+	smp_store_release(&tp->event->flags, tp->event->flags & ~flag);
 }
 
 static inline bool trace_probe_is_enabled(struct trace_probe *tp)
-- 
2.39.5

