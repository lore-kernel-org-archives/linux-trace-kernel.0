Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC430C36E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690654; cv=none; b=lzwbZPCGhHyaaVNikbtfG4dvxWE0UmU5SuIiz240KA5Vl92RcyU8h8/kYoH15Sf1M1tCYzBDf0hVQit0wptzaKW9/YFUG9eEHQm1PChdTAYylkNqBNoA/bvXC+cGnwByCaLlPj9X0eYUieAwJ+h/zCU5vbnY3k2ykoan1iEyTX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690654; c=relaxed/simple;
	bh=/YCcFx9fK4X6vkZb2r65rdSswmVUHKmtCmFNEnHBgpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OD+yJERpQUOhaHTPue0pfRfitBITBoaoDkwEdUyqDgX+opFmDT7DheRVXourJYr+W7GFOJGynSWEOFtO//8CkQrLOT6WMyXwPF2yZXJw6tGNrkbEqLcyY0JoImq+7rYxO3/a9AxaFpg4BP/hlFT0QftvIf8AXTkuMYPUOTaabs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b1OHgoBK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b1OHgoBK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cd413b4so796545e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 01:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767690651; x=1768295451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq+ApTTyCsVEAV3Mh5mFQtTRHKhX3x1YwcZ2qcrzmns=;
        b=b1OHgoBKvUtNlCidH/Sa/UxG+SvyNuBhxliL92vJHmHVuurBwb2KfMW+bdyCdMjrTU
         bpRBrK0rI6coepCZ+3X6hzmHx053NRscoy0nX8icy6HD9KLOo59WGhGlzq7hnbLa9WRP
         XFs6YtepugPlL//s9loX0pzQrp7ywSb/KUhmdPFhBRK7VE349q9i9pXF20wQJnFTlFox
         7QGatOcxuj4vpnAONBLbWnoz+4turMAAFm4sjqO8XnVYE340dkc3SGpPeTBKq9H60NH4
         Zaqo48v5uc8SxMn8U/vzmnsrWRvch6YfgkPo9P+aojJ8YQK+XyUW+9XZNH/l8z7bZ/dv
         q70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690651; x=1768295451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq+ApTTyCsVEAV3Mh5mFQtTRHKhX3x1YwcZ2qcrzmns=;
        b=oSVBB6XMxhL11PTYdQIR+xlN0VChxjT5RDIXuaCVU6Yf6WMLOtnAEwT1sLGgYqiX09
         iA8IErSBymmSzvVKuFnsw8IlK+4NYRpAVBGiZor2pLSomgjJPhLbukPtHFptxLIAg1Fe
         E3c4j69B/xM8pvVlDwIDZKpHA+FCkZG4rzGqin9wCxNYVboCwPNUeGz9tMJefdPCy+P1
         5DEMl7W92E3YN53zbzTsMuvvclQXbpQJb9Bu0Ow/cHgaSxkhl4gPFPjrysnOzInZhROe
         MSyVWxEKoEYf9fClwtcmEEOG5SjRqvTgchWgfJTJnwMCr/hDm1X+BI1u4rcE0S7M/Hh+
         0uig==
X-Forwarded-Encrypted: i=1; AJvYcCWncBCi+gq1pHm2DYXcSP2WZrgO/Zmfs4Dg/+KkLHr4H1S1LGVJ4zUyHfkCHaiLlC3/E7wq8uMHsaWQtfrrHcyoWIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9JrhFJdSgji1Jl/vKL2jXrKBav4WnjIkFYMcfZuuU5TmPHYGG
	TkgpaVNnUwqVEFq70bZb2sn2Wg3BiqEgIfAngaPraFzFTyLUpg6n6m6V79n7z8l7DNU=
X-Gm-Gg: AY/fxX5qtxXynogUD7dwl4iuPZl67crgV7URRSNueTWgUQmpS0HiEr5PSPN0PoEBV8D
	pL/4JK143bvUDF1VQMdjVLpSFEcL3uh0cW3KlYqmph//NvGEMqmQXr1KE+mWiNVx1fqFwi0DW/7
	NI0Q4usVucoF9YiVD+8IfO0WLjLJTKe4gTRJ95p+e6Eg+V12TYH++D+i+h/0/9ug0tkhdwPcs5Q
	nyWchbw92Xo/Flm2aSyL+NRLRDZAJWACE0TkrIyX4WrwE2oKiKRBuXuc0oCQGVDXKRB/gB8qQ3v
	tadY8c0AhojxuL4gkW942eef4amrmuWhhPy8dz8bD7ftEfOs6sS5edka6iOiTwwFh+0oOiBRCSU
	7WlbDvPlN0ougFe/SdSdboYRQMjJbqknuSED2HRApu3yjdhVa5fdfElXpYhSemw8bFggAiuL+Jc
	5SG87b6OiX7R51auVKwui/nzWZcPlzibDr
X-Google-Smtp-Source: AGHT+IHcR0555ohsRlawXEi+d03mZxbXk81vFyB7IVZMXoTi2fYsuDrx0nGHYaHbE3bLvtvjD41pxQ==
X-Received: by 2002:a05:600c:4753:b0:477:9dd9:ac57 with SMTP id 5b1f17b1804b1-47d7f01502cmr13171025e9.0.1767690651096;
        Tue, 06 Jan 2026 01:10:51 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653c78sm33651745e9.11.2026.01.06.01.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:10:50 -0800 (PST)
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Date: Tue,  6 Jan 2026 10:10:39 +0100
Message-ID: <20260106091039.2012108-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid running the wakeup irq_work on an isolated CPU. Since the wakeup can
run on any CPU, let's pick a housekeeping CPU to do the job.

This change reduces additional noise when tracing isolated CPUs. For
example, the following ipi_send_cpu stack trace was captured with
nohz_full=2 on the isolated CPU:

          <idle>-0       [002] d.h4.  1255.379293: ipi_send_cpu: cpu=2 callsite=irq_work_queue+0x2d/0x50 callback=rb_wake_up_waiters+0x0/0x80
          <idle>-0       [002] d.h4.  1255.379329: <stack trace>
 => trace_event_raw_event_ipi_send_cpu
 => __irq_work_queue_local
 => irq_work_queue
 => ring_buffer_unlock_commit
 => trace_buffer_unlock_commit_regs
 => trace_event_buffer_commit
 => trace_event_raw_event_x86_irq_vector
 => __sysvec_apic_timer_interrupt
 => sysvec_apic_timer_interrupt
 => asm_sysvec_apic_timer_interrupt
 => pv_native_safe_halt
 => default_idle
 => default_idle_call
 => do_idle
 => cpu_startup_entry
 => start_secondary
 => common_startup_64

The IRQ work interrupt alone adds considerable noise, but the impact can
get even worse with PREEMPT_RT, because the IRQ work interrupt is then
handled by a separate kernel thread. This requires a task switch and makes
tracing useless for analyzing latency on an isolated CPU.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kernel/trace/ring_buffer.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 41c9f5d079beb..ed9160599091d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
  */
+#include <linux/sched/isolation.h>
 #include <linux/trace_recursion.h>
 #include <linux/trace_events.h>
 #include <linux/ring_buffer.h>
@@ -4011,19 +4012,31 @@ static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_end_commit(cpu_buffer);
 }
 
+static inline bool
+rb_irq_work_queue(struct rb_irq_work *irq_work)
+{
+	int cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
+
+	/*
+	 * If CPU isolation is not active, cpu is always the current
+	 * CPU, and the following is equivallent to irq_work_queue().
+	 */
+	return irq_work_queue_on(&irq_work->work, cpu);
+}
+
 static __always_inline void
 rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 {
 	if (buffer->irq_work.waiters_pending) {
 		buffer->irq_work.waiters_pending = false;
 		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&buffer->irq_work.work);
+		rb_irq_work_queue(&buffer->irq_work);
 	}
 
 	if (cpu_buffer->irq_work.waiters_pending) {
 		cpu_buffer->irq_work.waiters_pending = false;
 		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&cpu_buffer->irq_work.work);
+		rb_irq_work_queue(&cpu_buffer->irq_work);
 	}
 
 	if (cpu_buffer->last_pages_touch == local_read(&cpu_buffer->pages_touched))
@@ -4043,7 +4056,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->irq_work.wakeup_full = true;
 	cpu_buffer->irq_work.full_waiters_pending = false;
 	/* irq_work_queue() supplies it's own memory barriers */
-	irq_work_queue(&cpu_buffer->irq_work.work);
+	rb_irq_work_queue(&cpu_buffer->irq_work);
 }
 
 #ifdef CONFIG_RING_BUFFER_RECORD_RECURSION
-- 
2.52.0

