Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645654;
	b=O0HIZxC5nKrn565yTbXj9iOYT6H4d4hE84xlFlY2WdR/E2eJz/zfLQC80SInwdR3dd15
	 q9RUu8721eejBPSoCnPcDs7jL9i12ht53V/J3kFW5UV9KDGYna88EG3m4wOi+4rgBQMfs
	 CEoJTQQg/NPBa+B/8BU9q2OAYRbP9zAavjIWJCfQuSdzcdDft900MTCmORa6HhOdb2orx
	 zaoOSPDSBtqE7aObdQGLU30h0G5beqq+XqajO8kgNKwK6zzA4KLwB4bvezRH07C/L9rHJ
	 UdDTKTjN71rC9MCIJRqKyRKxy19GZFi/toZiAlKgcmKNDnwwmUNZwKDEXEDS1dmjd2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RVCEYCvcD/LI4F4phUaENR7v/vt6SGoYCV0hEXjw1+k=;
	b=gpsRNPrO8nPPJ/07bUIAR/CIzmHm/k1IDoxmewDAB3QAAfIgnItX4A92OneTocuaXlAP
	 RpgPdadO0W6YCfNM6dT9Ra3s5iaYTVR0//+cPYBHfc7v7A6g519I2i2T6c2n0sw2QZV7R
	 kPUupLzyNG8cmaUXQsK1zkTwwuwFFHX7b/+YUH7bgkAh9alcOLqqTtuBah1pAyNYXKloz
	 ypH6Juo/oeEtDkXj4WG2iSMUolG1gay5m0YLliyn6hCDyZysniZYmvLCKr7D+IbBCOF/x
	 7sheCLKMDcEYhgG/RBWmNqeCZbChZZd6xha1sv9PmT5ew8vUk+j/X0Qt0QQnbKMRF2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CjyDnivs;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501F606A33F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2501F606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CjyDnivs
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e0d1da913so363302f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645652; x=1793250452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVCEYCvcD/LI4F4phUaENR7v/vt6SGoYCV0hEXjw1+k=;
        b=CjyDnivsbUXekRe28bU+4kigayrmmS633jYNn++rBZWTeQESc565ClJCC4iJvWq79e
         V9mSo1t49B6Th5fUFTsyKkcpXisr6DiLqV8u/f6rBoTMQW61+3vg5D5Jk5yEcYquTo+n
         ieRdCQvgpRrBEUMy2po0iIOewAp7EQRZAdOPyVpgt34Y5ThNr5CsdeWxe5PEH3XGVIWY
         sHOvf/0l6BA0s+WEEPp3bq6fpT+vzueGYdkb5GAbbc4fkJ9qe1c4HJtwpB/YBnIErqgY
         Kos2xrJKu0ZH4ocrhxBaCmDAqx/314WFEXn74uTuJkdyInxLwpOXx4ky/GyNyEhgESx2
         N5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645652; x=1793250452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVCEYCvcD/LI4F4phUaENR7v/vt6SGoYCV0hEXjw1+k=;
        b=Jkm+7r3xTTNMgi7DBobatmp8mgcA2FXUX/vSZZiuku4OsXBdN52kv6oUBSugIBgt4T
         scyAGnoQoZfawP0V0P0xZfEFJHshZGC7jjGqdIzJB5WAzKs3Csfyk8zJaIftoe4uQjMm
         vGsy5Wcvvr+qwUuMdki/UmHcc32FQRPFMUf60iCkr0B2DLD1np1aFrRjx8EtKYpOGaKn
         PXpAYFb0msx8t1KySmmlh46O1oD1bge/O8vX7nIWvI3IH25mfMU27u81PqOuT2ZFs990
         Q8JlujlXZWR0wzXYloH1TebxnmNxgtrWJC5AfhEVYrm6Y+z/3h2M3TiXuGWtGv/ddBCr
         6MEA==
X-Forwarded-Encrypted: i=1; AKwUvBw15Tf/HzwEJ4UhIxEcyNwTDowEN1er0P0Cx5R6wfI73MCJC5spDilj0nwqbDdiGBlX1y5aFv/xfPmWsbbrdgLbquw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLc7AOdxboM61YUMY7Srt8fEtZ3+e66tur0jLQALK2sMb2eo1T
	HOaSiU7rDy3uTSQVSqVEiYuTBjbVDQZAf6HAH/A424gdp34dqnL/cdXV
X-Gm-Gg: AYBFou2kS7uKtHpOBN0MDxHsprX7Fz3uF8XpDSUKZ8XICN1KVtvqzucNJYqf6eWt0gG
	vA1NhzM35PJPnyKeBSsBD+dOLKo/Vmmd6SElEpOD9rpzd935sZZ1HE4t/ea19khRSD1fPS+itEJ
	8gVPHUg4AsgH2mjYcCan6ceo3sRvmer82W0jUATeC6t10OfBVgHswYFwTpsGi2OOmgq67XzN1Ud
	pGUnXhIBgNR1J5F9uRG2TlMFjMh3W6GNbc+zzewiqWp/J+34rgXbhB10ZFk2MHNHT6fernQy+Nf
	NEyHxMrvHx3zeR9fPOloeWAA4Ip55Nmc30GXqSvsQuZPdFsGawkod0TeB0qulhR+T+84VPTpvSy
	v0at2FPVu1r6kfEsuPIeSfAEo4RtbtrienLhOCBi4MvlSPqRtt2sBsIG9/HSbAmI1B2kpo5JHor
	Sl2ZNdjeuEowdKsfhifBDiwNJrbJYlQl5zKpyfCYN3yKghEzzBj5lPF1FpRzotjEmxq8MElIenx
	Oa3/TbxvHSs3cDnSPnzsRPLZK0a5zIISifsTRljFK8DkI7OH0EpFA5ZXTBJL3W4y/0GJU+ACOEM
	t+ndemOrJAupoYc20HituhbmgbSosG+aCTzaCJTf6ZrQSmC9QuRMQs6BuBh/RH1GbrLRpHfg3Rv
	7P9ZPI4O+iTcvZwjWMwWomklZaCtdBLR/yyAd2noIQSXcgZNkAKmnPvD987A=
X-Received: by 2002:a05:6000:1611:b0:48d:fce6:884e with SMTP id ffacd0b85a97d-48e2d110a50mr1772805f8f.12.1792645652196;
        Wed, 21 Oct 2026 22:07:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/9] tracing/sched: Add IRQ preemption lifecycle events
Date: Thu, 22 Oct 2026 07:07:05 +0200
Message-Id: <20261022050712.75035-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022050712.75035-1-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracepoints around __schedule() do not identify the boundaries of one
preempt_schedule_irq() invocation. The calling task may switch out and
resume on another CPU before the invocation returns.

Add events at entry to and return from preempt_schedule_irq(). Record the
calling task as the owner in both events so consumers can follow the
invocation across switches and migration. Sample the preempt count and
interrupt state before dispatching the callbacks.

The events bracket preempt_schedule_irq() only. They do not cover
architecture-specific interrupt-return work or establish that the helper
was reached from a physical interrupt.

Assisted-by: LLM
---
 include/trace/events/sched.h | 51 ++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c          |  6 +++++
 2 files changed, 57 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 535860581f159..d0f510c35b02b 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -52,6 +52,57 @@ TRACE_EVENT(sched_kthread_stop_ret,
 	TP_printk("ret=%d", __entry->ret)
 );
 
+DECLARE_EVENT_CLASS(sched_irq_preempt,
+
+	TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+
+	TP_ARGS(owner, pc, irq_off),
+
+	TP_STRUCT__entry(
+		__array(char, owner_comm, TASK_COMM_LEN)
+		__field(pid_t, owner_pid)
+		__field(unsigned long, pc)
+		__field(bool, irq_off)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->owner_comm, owner->comm, TASK_COMM_LEN);
+		__entry->owner_pid = owner->pid;
+		__entry->pc = pc;
+		__entry->irq_off = irq_off;
+	),
+
+	TP_printk("owner=%s/%d pc=0x%lx irq_off=%d",
+		  __entry->owner_comm, __entry->owner_pid,
+		  __entry->pc, __entry->irq_off)
+);
+
+/**
+ * sched_irq_preempt_entry - begin preempt_schedule_irq() processing
+ * @owner: task whose interrupted execution will resume after scheduling
+ * @pc: preempt count sampled at the call site, before tracing bookkeeping
+ * @irq_off: interrupt state sampled at the same call site
+ *
+ * Emitted after entry assertions and context-tracking setup, with zero
+ * preempt count and local interrupts disabled. Exception-return paths can
+ * also use this scheduler entrypoint.
+ */
+DEFINE_EVENT(sched_irq_preempt, sched_irq_preempt_entry,
+	     TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+	     TP_ARGS(owner, pc, irq_off));
+
+/**
+ * sched_irq_preempt_exit - original preempt_schedule_irq() invocation resumes
+ * @owner: task saved by the matching entry, possibly on a different CPU
+ * @pc: preempt count sampled at the call site, before tracing bookkeeping
+ * @irq_off: interrupt state sampled at the same call site
+ *
+ * Emitted with local interrupts disabled before restoring context tracking.
+ */
+DEFINE_EVENT(sched_irq_preempt, sched_irq_preempt_exit,
+	     TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+	     TP_ARGS(owner, pc, irq_off));
+
 /**
  * sched_kthread_work_queue_work - called when a work gets queued
  * @worker:	pointer to the kthread_worker
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1754d9f95f2cf..b971a373ea3a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7593,12 +7593,16 @@ EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
  */
 asmlinkage __visible void __sched preempt_schedule_irq(void)
 {
+	struct task_struct *owner = current;
 	enum ctx_state prev_state;
 
 	/* Catch callers which need to be fixed */
 	BUG_ON(preempt_count() || !irqs_disabled());
 
 	prev_state = exception_enter();
+	/* Sample before tracing bookkeeping can change the observed context. */
+	if (trace_sched_irq_preempt_entry_enabled())
+		trace_sched_irq_preempt_entry(owner, preempt_count(), irqs_disabled());
 
 	do {
 		preempt_disable();
@@ -7608,6 +7612,8 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 
+	if (trace_sched_irq_preempt_exit_enabled())
+		trace_sched_irq_preempt_exit(owner, preempt_count(), irqs_disabled());
 	exception_exit(prev_state);
 }
 
-- 
2.39.5 (Apple Git-154)

