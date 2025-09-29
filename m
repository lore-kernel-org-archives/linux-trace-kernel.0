Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B89A92E;
	Mon, 29 Sep 2025 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759116156; cv=none; b=PkQWBB5+Y164QCPMQCck/D03L7HA1wDTDYAw5e8KVrqAU2R+BDKAWlQxNznd/cwL4YsgSaC5gubmearBuMZZwtlYT+JVz9MfMKaogzJW3beAkYmqWU0xTysaLXE8+Ed6peFRooqIKbW6SxxEM2Xm5g0kPGMYdqrmoOBJKB2Ya48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759116156; c=relaxed/simple;
	bh=7wGK0WZ6kvijpeVHQ1rvhxvAmkWtiIYurZ1MhX4UhFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=odrzsaUdYiEXh4P9W+xc6Mf/qv0TFkKNJzxAS3+UKAtE9Q2WznV2vUX2d3nr5konILE72T6vnsqU36uGmxRMrTSOeHJiHEt252Po7c+HUEjFR6b3PDDG49zksEK09fur1UCuWhO01f23jvwe65FW8TqQcjlun5ZNrkKTrj4+6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hen5GsO3; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hen5GsO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Reply-To:
	MIME-Version:Content-Type; bh=PgFboyisbuCo0/7DTrz2JvIMjhhb+s1cus
	MR4QBJg9I=; b=Hen5GsO3RWn7k+wky5ZOo7hoQDlreKT2gTUnooE+IkOEjYSQta
	/6JVAtdxQwTWIaOuy9G4N68SI8f6q+hnrYY1S0SvkYzzWGF2yjMEsnf9STDC01/y
	MHXTbUqARhALqKr/G7BqjxGuAj/J7Z8PVenV4o/nONszaXFGPrt1lO260=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3X5jc+Nlo7idkAw--.1589S2;
	Mon, 29 Sep 2025 11:11:27 +0800 (CST)
From: chenyuan_fl@163.com
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yuan CHen <chenyuan@kylinos.cn>
Subject: [PATCH] tracing: Fix race condition in kprobe initialization causing NULL pointer dereference
Date: Mon, 29 Sep 2025 04:11:22 +0100
Message-Id: <20250929031122.2825-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.39.5
Reply-To: <87ms751z28.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X5jc+Nlo7idkAw--.1589S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4fZw4fZFW8Cr17Xr17trb_yoW7JrWfpa
	nxKws8Kw4kJFyjvryrJr1UJ3WftFyrZFWDJry7Gw45ZF1jgr1UJF12q3yUAF13GFyDAFyf
	t3Waqr10qryUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOL0nUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiUQTLvWjKqZC0OgADs1

From: Yuan CHen <chenyuan@kylinos.cn>

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
1309: 	if (hlist_empty(head))
1310:		return 0;

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
      create_local_trace_kprobe
        alloc_trace_kprobe
          __register_trace_kprobe(tk);
            arm_kprobe(p);(1)← KPROBE ACTIVE
                                            Debug exception triggers
                                            ...
                                            kprobe_handler(regs)
      perf_trace_event_init                 ...
        tp_event->perf_events = list;(2)
        tp_event->class->reg (3)
                                            kprobe_dispatcher (tk->tp.flags & TP_FLAG_PROFILE)
                                              kprobe_perf_func
					        head = this_cpu_ptr(call->perf_events)(4)
                                                (perf_events is still NULL)

Critical Issue:

The race window is:
1. CPU0 calls `arm_kprobe(p)` at point (1) - kprobe becomes active
2. CPU1 triggers debug exception and reaches `kprobe_dispatcher`
3. CPU0 sets `tp_event->perf_events = list` at point (2) but this assignment
   may not be visible to CPU1 due to memory ordering
4. CPU0 calls `class->reg()` at point (3) setting `TP_FLAG_PROFILE`
5. CPU1 checks `(tk->tp.flags & TP_FLAG_PROFILE)` - condition passes
6. CPU1 calls `kprobe_perf_func()` and crashes at point (4)

The kprobe becomes active immediately at point (1), allowing concurrent CPUs
to enter kprobe handlers. However, `perf_events` assignment at point (2) happens
at a different time and may not be visible to other CPUs due to missing memory
barriers before point (3) sets `TP_FLAG_PROFILE`.

Signed-off-by: Yuan CHen <chenyuan@kylinos.cn>
---
 kernel/trace/trace_event_perf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a6bb7577e8c5..6eff8c9d6bae 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -113,6 +113,11 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
 
 	tp_event->perf_events = list;
 
+	/* Ensure perf_events assignment is visible to all CPUs before enabling
+	 * profile functionality
+	 */
+	smp_mb();
+
 	if (!total_ref_count) {
 		char __percpu *buf;
 		int i;
-- 
2.39.5

