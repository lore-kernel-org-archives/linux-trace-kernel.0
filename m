Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071594;
	b=JZfYWESNq0akbF73OyNB4WaxKdKP3lMT1+xMAyF6XITnfHLSPIC/xQj9pTLgYaz8nF4k
	 gsn/Xs6WGnv/lv3B8MnWjZqo3iKokFj9gVZtQHiC47Q048BEgU9KM16yY+L0GlvpjXNxo
	 J/EHC7Oax3b/Gl0Bebacf0ru4RUxK5eTCf+NZ2pB9zZwk1A/jm/NRe+uSlP3sadv3+W2L
	 9kQ3GtRWxhf7xtCuOySMVyLxl35EhYzGNtdG9NQEWB8KDDMYun0dwNXCisYsnffpomIx2
	 b2vYeOvmW3dvkJPJFGXgZvwYoGtQnLkoqmKuN1T79t6d/cjhFGy0oDdyR6VchkZZwuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vG12dDB2cOlbfaJe777WCUEVPBMgOyFMr8jFTvptykE=;
	b=yNogqClki2YiuXP7gmPnhN8tVaPEGa4xBQJilpEr9EXUhhsqXpamTtRSkkdRUqptFrEh
	 9SkPxtWg+wNedhMQzZ4V17E9nD/JYRx2VdLjcCQTOTJx+chK28wWqynydVonSM2frJDwY
	 4RRNpLwg8XQHkaumtKHEvT//OUSeBUyWLeb9ApuMuhTtjIJKqh0wirTIpvklCtJJ/jcHQ
	 ujAbt/exBGo6Pbfn3reuEMsNYNVuKNnDScvNZEZVoigsZIosktpZ8bg70mqhlJTBKclXo
	 TVWRk7vKPW1Lc3KsfQ6uLyTq7KbBj7JTuPgCgOzcRic4Y0bQZNJo4tVWAZAAqsFP59Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWVyDxQw;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42D606EEAF
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 17:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD42D606EEAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWVyDxQw
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso682840f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071592; x=1794676392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vG12dDB2cOlbfaJe777WCUEVPBMgOyFMr8jFTvptykE=;
        b=SWVyDxQwJ8qnXh3rwRERwuMRPtImEWFDn2JsbKBNMOVftDIcZuWLZbpxkw2PqJv1wu
         An6AX/k7xtIc3KVgSd0KlmjvlEs+GX91Wyov3SnQ9k/U0nDCBTNpUY7/1cmTid/HpgYV
         XI9B/A2Fd+lMDhd8uD7u4FacrI9Hq3z0BvhVCWGGus+8Dsx+vVVBKyH+7vNLApBC/S+e
         2tvuIYR0aDxUCOIkOwep7nQq3subLl3ktGXWx27vSL+y52S35hFUpCpVE4dwW+aEyjfS
         3EsaajPa9jH/oDSkETW5BbCJV3qIvctPKtnv+gQUjGbg4LzVu+Cb74CKt2y8RDrHXhgQ
         vQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071592; x=1794676392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vG12dDB2cOlbfaJe777WCUEVPBMgOyFMr8jFTvptykE=;
        b=fILgJ5C3E7wHwVgheLjrQnBPOhSCYCKJGM/DKRQERoV06Ab368S1uz3cSJ+QgZ8VJW
         v9dOGjuBj5ggDKxGMhyKe+zrjzeDJVzRcdLGFo1b43sccQ1DRPjR3agGyzVwzjy3rWRX
         hk1py1rW8CC6scVkSJTYIqOLa0gu43QAyEFXeWCrYM6HZ1jeFVA0NhL5qnCApm8tKXj4
         ifLJNbGpQU5Wthg0kC2Ns3z0gmhE8G5MLC7p399ZZ/VpTwLy46iWmSyVHqNlrbFkxNYT
         ETRYXt2Uz72d9ZXxEvXWNmHbVePtlclhMsQCHZN/w9zYIsxX0kGp8m5Aouq1gSL6UIIB
         30jQ==
X-Forwarded-Encrypted: i=1; AL+hErGkLMExqbU0tMiPqrYWfH3AUmwjzy/Lm9cE4Zn1qAA5AyIwBNfEcR/2SM4bUCfamP3Do4+yM0e0WhUAY43ChO/sGvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZWiZIqKbUDcPhSr+ziv9VwwzbNDR53eOfonXnAW4CfYVboZVa
	ZNSXF84MpmM7Qf5UJ8mNqeFj3yaSqWuAx+DZDIdpvRe53/o5UcUBT4UK
X-Gm-Gg: AYBFou0TkijaYka23vyqZ/hVHK6+i3DyW1n7tKEWyyOthqk6utvdQVtt4Wok5svTRUL
	IJmwCd4x6lKPezpwRQcVmmogkG8T1TBZCnRROWc3+tgt0wcUj5+u0HgRNo848O9VLtymafbvueC
	CloBOTqJQPzj4l8D98MvGHkb1ucLhm1apCyTPF9zsZSOj8c3BavRd0Y0sa/jGQ29ghPqDucqEUp
	ZtKZ8HNQds9Uv+xkqjDnuljsvwRUk6Vx2BJwACXYj8mOcxDuRDzpSEszIOwqBS9gsXEtDvyMrv4
	YouXmIco9vPExrdz+5LZnhuxUFYAtA1ilWTEZZ/d9AxTL9GNhAF38aiPwUmBPF3oZQ+dleFbS5R
	QMFBZdnebhht/N3yRwZpbNKGOc+CkF62EhQrWXFFz7s3QB/MBbTro4gu0dsRNy/bgSzS5gSU05w
	s2qzW8o0jdM+aONLUChcAOIDZBaSAraNpqu3Am42JhXZGC8sWh1yoMRSl+byWuKrZbmdb28S++w
	sL+pf/5TlyIalIZnaW4O/awvpOWPg7MlDwTnIkh/gwOvzABF+dLadQw7p7nWz/HkbAD+ATlhBn8
	nA/vYLnol/htzJmB6YgrOofDgw2OyJS/XEz788QABi9r02K3eQeSLfntrJ69AFonYPsy7eghIwq
	tosTBS+1ej7PA6hz8yiI/q9syxL8BNVrJph3IhETcdrQetcr2LspfBdORy673k3A37qEOxm1lq6
	XcJ0nN5VJ0mMWD2kI83OIyBHgkVuGmzgk=
X-Received: by 2002:a05:6000:2dc9:b0:491:8462:20cc with SMTP id ffacd0b85a97d-49277bb1d39mr11173964f8f.37.1794071592005;
        Sat, 07 Nov 2026 09:13:12 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:11 -0800 (PST)
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
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/9] tracing/sched: Add IRQ preemption lifecycle tracepoints
Date: Sat,  7 Nov 2026 18:12:45 +0100
Message-Id: <20261107171252.25090-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107171252.25090-1-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
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

Tracepoints around __schedule() do not identify the start and end of one
preempt_schedule_irq() invocation. The calling task may switch out and
resume on another CPU before the invocation returns.

Add bare entry and exit tracepoints around the generic helper using
DECLARE_TRACE() so they are not exported in tracefs. Record the task
that called preempt_schedule_irq() as the owner in both tracepoints so
consumers can follow the invocation across switches and migration.
Sample the preempt count and interrupt state before dispatching
tracepoint callbacks.

The tracepoints bracket preempt_schedule_irq() only. They do not cover
architecture-specific interrupt-return work or establish that the helper
was reached from a physical interrupt.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/trace/events/sched.h | 26 ++++++++++++++++++++++++++
 kernel/sched/core.c          |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 535860581f159..c7aeaa85d27ef 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,32 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+/*
+ * sched_irq_preempt_entry - begin preempt_schedule_irq() processing
+ * @owner: task whose interrupted execution will resume after scheduling
+ * @pc: preempt count sampled at the call site, before tracing bookkeeping
+ * @irq_off: interrupt state sampled at the same call site
+ *
+ * Emitted after entry assertions and context-tracking setup, with zero
+ * preempt count and local interrupts disabled. Exception-return paths can
+ * also use this scheduler entrypoint.
+ */
+DECLARE_TRACE(sched_irq_preempt_entry,
+	      TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+	      TP_ARGS(owner, pc, irq_off));
+
+/*
+ * sched_irq_preempt_exit - original preempt_schedule_irq() invocation resumes
+ * @owner: task saved by the matching entry, possibly on a different CPU
+ * @pc: preempt count sampled at the call site, before tracing bookkeeping
+ * @irq_off: interrupt state sampled at the same call site
+ *
+ * Emitted with local interrupts disabled before restoring context tracking.
+ */
+DECLARE_TRACE(sched_irq_preempt_exit,
+	      TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+	      TP_ARGS(owner, pc, irq_off));
+
 #define DL_OTHER 0
 #define DL_TASK 1
 #define DL_SERVER_FAIR 2
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8ca..e5c476d27eca7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7649,12 +7649,16 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
  */
 asmlinkage __visible void __sched preempt_schedule_irq(void)
 {
+	struct task_struct *owner = current;
 	enum ctx_state prev_state;
 
 	/* Catch callers which need to be fixed */
 	BUG_ON(preempt_count() || !irqs_disabled());
 
 	prev_state = exception_enter();
+	/* Sample before tracing bookkeeping can change the observed context. */
+	if (trace_sched_irq_preempt_entry_tp_enabled())
+		trace_sched_irq_preempt_entry_tp(owner, preempt_count(), irqs_disabled());
 
 	do {
 		preempt_disable();
@@ -7664,6 +7668,8 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 
+	if (trace_sched_irq_preempt_exit_tp_enabled())
+		trace_sched_irq_preempt_exit_tp(owner, preempt_count(), irqs_disabled());
 	exception_exit(prev_state);
 }
 
-- 
2.39.5 (Apple Git-154)

