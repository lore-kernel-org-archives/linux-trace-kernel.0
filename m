Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645652;
	b=4WMljtD2uZVCso0vcMHHY2yvqPLqopV1uknEalEAHN2Lv9piuCcIh3wAghY49R1xAxMz
	 E7boK8ddDdv27LMv/CRhPjJyy7JCdswrhuWSApApL1ZW9FagmOOjecchyOylfgj+0oB1N
	 Mg7vFITaiss8ANo/3NaoDUfRopdYZLrdpePWO55ukp3pTCzSyNT5GEvfz2D6mIcg6hyBv
	 P/eC7EnI925f6GZNNGEZqi5fjQuskj6j4iXOx0Ufv2zkQulaggaw6cUOkMDrEfpdzETr3
	 pJX0GNvZU6CFq7PCXyIL+UgDs8ZLd5MMeYNO9AuFLapvNkrYWrrpLZD2N5NDDkAr86A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BHdQ3oJdq4X8d6012LcEuzSwz1eQzQcjplU9SozkqnY=;
	b=G/OUM48OALmpi7tzp8l9mu7T3vVn2VCUibHdupOyj87IPdktfYVmvHnvtuhz4LQEgSTY
	 Q11Wgia6Uc9GgP291A7RcCnxaq7UYqRxt8mQ1BwaYnCQi5hPvQ0VSVjPVNsOCDXyQfTEe
	 I0nwWyFWr2yjzEzHaOIQs/XO47wObA3jChVfq+AwgkqqkzonszMc1ubI8ITsM9angYAeO
	 MuFnmN/y2vu3I1bRAUDaw7ONLCbngrU1r3uRywwBUxTVZOjByxA79zl+1JZBY+XG2WiY4
	 ddy/fXGEH+KOwu4R5TW17MzBFhFn2bzwZjN8IUacbbaT9DPEjr//zPj5yqEIUns7auA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="s/7J6us2";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2D606A32E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B2D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s/7J6us2
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so11739865e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645650; x=1793250450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHdQ3oJdq4X8d6012LcEuzSwz1eQzQcjplU9SozkqnY=;
        b=s/7J6us2hJBtKEltw05BfMAxGdzT25Uwu9UNPL9ArTG1NjHKP8ZCKRKvpdpUlV+YmS
         TsDEggwxduLOZ45VSWqlGuPQCC+4yaAljoSc0ob10LZaBGW4SNV/Wfo6O9p0QOANNi8z
         yi/xUzmpUk7f1PH3BX/d6ncYyizdpM/5XvKIQ4Zrz73fTC2ONu2T2BE5uDGWbi/1fCTB
         1oFu16NdJzex8TzDfcXp32v4wYpndNbh7Ve/pauJJTB3BE/4KGSggYFaB0U7P8bIT9Ls
         aTEl0Owc9W5faFBtP8mXl9fPQywY9zHlKMxJMiKnjfKKSUEChIkKdnQteDLXMDtZt7/y
         Qpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645650; x=1793250450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BHdQ3oJdq4X8d6012LcEuzSwz1eQzQcjplU9SozkqnY=;
        b=JyWXVMF7DldLqTa6qiOYMMJUM6JJXB1ujGWJBqz1pLO/U9+Otkp6rjTRi39XJmGWUW
         tTrTlIUMLBntwWyxOak9Prmh+l/kcEPNe7in1jgcxe5+javtpgtjeBHIow0Y8WbxsQyC
         kP6et6tmVVCcfrEqVpCdNsHmEdnUBPfnEX/0tBbuZD6UqYEFiZpONMMSBjxxYf3BbvaW
         SDbTd20C/WvMcytxv+b/FEqY9J2LWpKARoW+TXIUgzFV+ILHubaLcd1jgvKjNc99KXXP
         ++5bCX63foTGzd4bfD9Btd1HbDIX7wGTvE6+3n8F9tEYLwknZzG5ABraGNxcqkSr81lX
         n8xA==
X-Forwarded-Encrypted: i=1; AKwUvByLy/htOicKQKzU0RQx9+1clSZR4EYETBK8TD12Jo2pg/x/JiGXEBqEA0/j9mlI2YwObn8rVbTH22EyreOebDjI4oo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjmvxv6kD+vkMcKOmxxUn5Pt7l/z4BpeeuaIc6Eo5DoEBfmES7
	RM/YPvUHtxApUIqOfQQgN20uoJZ2ZcAXeSH9ssDVtf6ADsMD7vah2ThB
X-Gm-Gg: AYBFou1ViQOqTRXJgDaTtPT34vgtOuTPhJrx/hjauIhbnY7u17NkZfvRb6BsBmAr6jh
	1Dj+4g4xtBpuPF9+3pCZ+jOv6M13aAaOMbTbAQ19voYzB9mxyZJ5V/SZ1/yCs02vZvvKY61zDqU
	obcftjIjrAabg2TMjuLZTAhR/aFWf6yLvM+CnN35cnGOqBOmNYqCCJ7TNk7lsxZS1eYx9jg3XQt
	crAlUAoFgSMj4DumY4u+MSfnFSMGHlt2voM5Hh+7b6HlXJ999I19LJ11C4Ek9S+tnyvvMrKYaK3
	tJEUdn7R0SHyvLsUDs1ojZji83xK5cPhVWnqKN5BsZfDlNQOkIMzkT3O48qBrUIENSAzmq3gN6s
	4TZ5p1RsBnIet2GpD/9MEUESzsmw0kjDFuxqtFR93Jck6kdSGw3rDS+C0ZiF0jT2AraxkPWg2r5
	yFLgsRFC04jSP10w7QQLQJkMFNbOr1+8lDf3JK0pCXLtO+zAal8/Dri65GFKoXf7nFGrkPQ1Hu9
	JMW3gLn13VnPJ8tcehf6eDVjiNONEzSrBU7AoujGI2/0rlvPnxmNCqdBk78RB8rwDm9aiLOn4p4
	kpwc8gp0FiFDfRenY/K+2gwYOnZPMGoH4BRqHjBAcUOEMVR/lh70FS7egSTIWkl7MIotyqLSuEc
	cFhLu+tJnzCsqS2BcJ+D65eGKIW1QWf7V9sd2ljZ40Oi/NhSclVG968mvjSw=
X-Received: by 2002:a05:600c:4715:b0:4a1:e46d:1bd4 with SMTP id 5b1f17b1804b1-4a1fdd574dcmr76304425e9.29.1792645649512;
        Wed, 21 Oct 2026 22:07:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:28 -0700 (PDT)
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
Subject: [RFC PATCH 1/9] tracing/irq: Add generic IRQ context boundary events
Date: Thu, 22 Oct 2026 07:07:04 +0200
Message-Id: <20261022050712.75035-2-kmehltretter@gmail.com>
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

IRQ action tracepoints describe handlers, not the enclosing interrupt
context. One hardirq context may run several actions. Synthetic dispatch
may also invoke an action outside hardirq context.

Add events at the generic hardirq and serving-softirq boundaries. Record
the hardirq depth and whether serving-softirq state temporarily replaces
hardirq state during interrupt return.

A callback attached to a boundary event can raise softirq work after the
normal pending-work check. Include work raised by the softirq-entry
callback in the initial pending snapshot. Wake ksoftirqd or ktimerd for
work raised by a final boundary callback.

The events cover paths through irq_enter()/irq_exit() or
irq_enter_rcu()/irq_exit_rcu(). Direct __irq_enter()/__irq_exit() users
and raw paths remain outside their scope.

Assisted-by: LLM
---
 include/trace/events/irq.h | 70 ++++++++++++++++++++++++++++++++
 kernel/softirq.c           | 83 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index 837c1740d0d07..0549fbcdbb1b6 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -39,6 +39,76 @@ SOFTIRQ_NAME_LIST
 #define show_softirq_name(val)				\
 	__print_symbolic(val, SOFTIRQ_NAME_LIST)
 
+DECLARE_EVENT_CLASS(hardirq_context,
+		    TP_PROTO(unsigned int depth),
+		    TP_ARGS(depth),
+		    TP_STRUCT__entry(__field(unsigned int, depth)),
+		    TP_fast_assign(__entry->depth = depth;),
+		    TP_printk("depth=%u", __entry->depth));
+
+/**
+ * hardirq_context_entry - generic hardirq state has been established
+ * @depth: hardirq nesting depth, including the context being entered
+ *
+ * This event is emitted after generic hardirq preempt-count, lockdep, timer,
+ * and accounting state has been established. It does not describe the
+ * architecture-specific interval before irq_enter() or irq_enter_rcu().
+ */
+DEFINE_EVENT(hardirq_context, hardirq_context_entry,
+	     TP_PROTO(unsigned int depth),
+	     TP_ARGS(depth));
+
+/**
+ * hardirq_context_exit - generic hardirq state is about to be removed
+ * @depth: hardirq nesting depth, including the context being exited
+ *
+ * This event is emitted with interrupts disabled immediately before generic
+ * hardirq preempt-count state is removed. Hardirq accounting ends earlier.
+ */
+DEFINE_EVENT(hardirq_context, hardirq_context_exit,
+	     TP_PROTO(unsigned int depth),
+	     TP_ARGS(depth));
+
+DECLARE_EVENT_CLASS(softirq_context,
+		    TP_PROTO(bool serving, bool from_hardirq),
+		    TP_ARGS(serving, from_hardirq),
+		    TP_STRUCT__entry(
+			    __field(bool, serving)
+			    __field(bool, from_hardirq)
+		    ),
+		    TP_fast_assign(
+			    __entry->serving = serving;
+			    __entry->from_hardirq = from_hardirq;
+		    ),
+		    TP_printk("serving=%d from_hardirq=%d",
+			      __entry->serving, __entry->from_hardirq));
+
+/**
+ * softirq_context_entry - serving-softirq state has been established
+ * @serving: whether the current task is serving a softirq
+ * @from_hardirq: whether hardirq state was replaced by serving-softirq state
+ *
+ * This event runs with local interrupts disabled after the serving bit is
+ * set. On PREEMPT_RT it includes preparation before handle_softirqs(), even
+ * if the pending-work check finds nothing. It does not mark an individual
+ * action or the start of CPU-time accounting.
+ */
+DEFINE_EVENT(softirq_context, softirq_context_entry,
+	     TP_PROTO(bool serving, bool from_hardirq),
+	     TP_ARGS(serving, from_hardirq));
+
+/**
+ * softirq_context_exit - serving-softirq state is about to be removed
+ * @serving: whether the current task is serving a softirq
+ * @from_hardirq: whether hardirq state will replace serving-softirq state
+ *
+ * This event runs with local interrupts disabled before the serving bit is
+ * cleared. On PREEMPT_RT this includes teardown after handle_softirqs().
+ */
+DEFINE_EVENT(softirq_context, softirq_context_exit,
+	     TP_PROTO(bool serving, bool from_hardirq),
+	     TP_ARGS(serving, from_hardirq));
+
 /**
  * irq_handler_entry - called immediately before the irq action handler
  * @irq: irq number
diff --git a/kernel/softirq.c b/kernel/softirq.c
index be49e6469f3ad..2e3b6fd3f6d5d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -178,7 +178,9 @@ bool local_bh_blocked(void)
 
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
+	unsigned long trace_flags = 0;
 	unsigned long flags;
+	bool trace_serving;
 	int newcnt;
 
 	WARN_ON_ONCE(in_hardirq());
@@ -200,6 +202,16 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 		}
 	}
 
+	/*
+	 * A serving interval starts here, before handle_softirqs(). When its
+	 * entry is traced, keep IRQs and task switches from observing the bit
+	 * before the event. Any blocking BH lock was acquired above.
+	 */
+	trace_serving = (cnt & SOFTIRQ_OFFSET) &&
+			trace_softirq_context_entry_enabled();
+	if (trace_serving)
+		local_irq_save(trace_flags);
+
 	/*
 	 * Track the per CPU softirq disabled state. On RT this is per CPU
 	 * state to allow preemption of bottom half disabled sections.
@@ -233,15 +245,27 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 			raw_local_irq_restore(flags);
 		}
 	}
+
+	if (trace_serving) {
+		trace_softirq_context_entry(!!in_serving_softirq(), false);
+		local_irq_restore(trace_flags);
+	}
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 
 static void __local_bh_enable(unsigned int cnt, bool unlock)
 {
+	bool entering = (cnt & SOFTIRQ_OFFSET) && !in_serving_softirq();
+	bool trace_exiting = (cnt & SOFTIRQ_OFFSET) && !entering &&
+			     trace_softirq_context_exit_enabled();
 	unsigned long flags;
 	bool sirq_en = false;
 	int newcnt;
 
+	/* Callers already disabled IRQs around the counter and its events. */
+	if (trace_exiting)
+		trace_softirq_context_exit(!!in_serving_softirq(), false);
+
 	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
 		DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
 				    this_cpu_read(softirq_ctrl.cnt));
@@ -276,6 +300,18 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
 			WARN_ON_ONCE(current->softirq_disable_cnt < 0);
 		}
 	}
+
+	/*
+	 * An exit probe can raise a softirq while serving state still suppresses
+	 * the normal ksoftirqd wakeup. Hand it off once no outer BH-disable
+	 * reference remains.
+	 */
+	if (trace_exiting && sirq_en && unlikely(local_softirq_pending()))
+		wakeup_softirqd();
+
+	/* local_bh_enable() can turn BH-disabled state into serving state. */
+	if (entering)
+		trace_softirq_context_entry(!!in_serving_softirq(), false);
 }
 
 void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
@@ -640,11 +676,15 @@ static void handle_softirqs(bool ksirqd)
 	 */
 	current->flags &= ~PF_MEMALLOC;
 
-	pending = local_softirq_pending();
-
 	from_irq_exit = softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		trace_softirq_context_entry(!!in_serving_softirq(),
+					    from_irq_exit);
+
+	/* Include work raised by the context-entry event. */
+	pending = local_softirq_pending();
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
@@ -692,6 +732,14 @@ restart:
 		wakeup_softirqd();
 	}
 
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
+	    trace_softirq_context_exit_enabled()) {
+		trace_softirq_context_exit(!!in_serving_softirq(),
+					   from_irq_exit);
+		/* The final pending-work decision above has already completed. */
+		if (unlikely(local_softirq_pending()))
+			wakeup_softirqd();
+	}
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
 	softirq_handle_end(from_irq_exit);
@@ -722,6 +770,7 @@ void irq_enter_rcu(void)
 		tick_irq_enter();
 
 	account_hardirq_enter(current);
+	trace_hardirq_context_entry(hardirq_count() >> HARDIRQ_SHIFT);
 }
 
 /**
@@ -796,6 +845,36 @@ static inline void __irq_exit_rcu(void)
 		wake_timersd();
 
 	tick_irq_exit();
+	if (trace_hardirq_context_exit_enabled()) {
+		bool ksoftirqd_wake_requested = false;
+		bool timersd_wake_requested = false;
+
+		trace_hardirq_context_exit(hardirq_count() >> HARDIRQ_SHIFT);
+
+		/* Hand work raised by the final boundary event to its worker. */
+		if (hardirq_count() == HARDIRQ_OFFSET) {
+			if (irq_count() == HARDIRQ_OFFSET &&
+			    unlikely(local_softirq_pending()) &&
+			    should_wake_ksoftirqd()) {
+				wakeup_softirqd();
+				ksoftirqd_wake_requested = true;
+			}
+
+			if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) &&
+			    force_irqthreads() && local_timers_pending_force_th()) {
+				wake_timersd();
+				timersd_wake_requested = true;
+			}
+
+			/* The timersd wakeup can itself raise a softirq. */
+			if (timersd_wake_requested &&
+			    !ksoftirqd_wake_requested &&
+			    irq_count() == HARDIRQ_OFFSET &&
+			    unlikely(local_softirq_pending()) &&
+			    should_wake_ksoftirqd())
+				wakeup_softirqd();
+		}
+	}
 	preempt_count_sub(HARDIRQ_OFFSET);
 }
 
-- 
2.39.5 (Apple Git-154)

