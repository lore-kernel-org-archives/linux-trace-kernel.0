Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00915330D2F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Dec 2025 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033447; cv=none; b=cGPGWlSgF4+mJ3QdGijWuvo6pfPWcRkCUUKtfLyKTRqGhYy7hcwyqhpbul/Jn3Q6EC4naF4UNwrxDwoin7o+vTFBhgLstx+pvBkQePxzQae6A70E/R48JV7beNdHeaPVL4VWIpyz5Tsgw+7qLX1cxuXGA8xBuXKlB2dbGWTdK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033447; c=relaxed/simple;
	bh=Jx+EO9Ce1F9T173mpF4siJiSEmsC0Yy9s9mwqd1Frnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1oIJdxHavJXslrqgFxZDt5I4ba+lAU5DedWdXFNYO82yKSWFHtAGt5CqS0Dl397xcdONF2Lp+jnG2q4uP6G2ZaYtiZRjkPyuDi4gQDux9LTgoSx87UkCSlZq0f6QIUCLKDwq4IbMbBvf4bvJ56ZnOZ+GJhhYqw/Utlrmk4WVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 303EE59A0C;
	Mon, 29 Dec 2025 18:29:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 7A3832F;
	Mon, 29 Dec 2025 18:29:36 +0000 (UTC)
Date: Mon, 29 Dec 2025 13:29:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v2 2/2] mm: vmscan: add PIDs to vmscan tracepoints
Message-ID: <20251229132942.31a2b583@gandalf.local.home>
In-Reply-To: <20251229105427.14720-1-tballasi@linux.microsoft.com>
References: <20251216130302.5202ca81@gandalf.local.home>
	<20251229105427.14720-1-tballasi@linux.microsoft.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 7A3832F
X-Stat-Signature: gnhnftzf34duj18fbzhtmxtnnxzqp7bu
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18X0yaxY/nuYiParjAbf7uR2X56SJVmoqE=
X-HE-Tag: 1767032976-144404
X-HE-Meta: U2FsdGVkX19+vMrYqJreb8g9AH/d7iocmx6izFefRJgUMGcZ6pRpl0T0gATfc3vgSaHQvZuwrgZFi81dwYrPPgkXujotpa/+Y7OlN37CpG2XlT/ADsBhOFP6CpKwmdPn8m1w4XqD7hRovBP0Ymnk3DkGm07XLbBCg7JgqGPExuZJz1kZcjROtwAoSjFaq5b5AlejqUZkh92hSnppLxVlfvGZShcGBCKkk0CQ7+//J4ii0hhHwEVVI6bs/LgqSGibLQbbzGygz82kueaURx05JpKBpPdO6XjRXfPha2SXldO7XlZCJYFJ6z86LJOmF1p7cgHjLNyv2BooB4U5UtftN8642ywAPV79

On Mon, 29 Dec 2025 02:54:27 -0800
Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> It indeed shows whether or not we're in an IRQ, but I believe the
> kernel shouldn't show erronous debugging values. Even though it can be
> obvious that we're in an interrupt, some people might look directly at
> the garbage PID value without having second thoughts and taking it for
> granted. On the other hand, it takes just a small check to mark the
> debugging information as clearly invalid, which complements the IRQ
> context flag.
> 
> If we shouldn't put that check there, I'd happily remove it, but I'd
> tend to think it's a trivial addition that can only be for the best.

I just don't like wasting valuable ring buffer space for something that can
be easily determined without it.

How about this. I just wrote up this patch, and it could be something you
use. I tested it against the sched waking events, by adding:

 		__entry->target_cpu	= task_cpu(p);
 	),
 
-	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d",
+	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d %s",
 		  __entry->comm, __entry->pid, __entry->prio,
-		  __entry->target_cpu)
+		  __entry->target_cpu,
+		  __event_in_irq() ? "(in-irq)" : "")
 );
 
Which produces:

          <idle>-0     [003] d.h4.    44.832126: sched_waking:         comm=in:imklog pid=619 prio=120 target_cpu=006 (in-irq)
          <idle>-0     [003] d.s3.    44.832180: sched_waking:         comm=rcu_preempt pid=15 prio=120 target_cpu=001 (in-irq)
       in:imklog-619   [006] d..2.    44.832393: sched_waking:         comm=rs:main Q:Reg pid=620 prio=120 target_cpu=003 

You can see it adds "(in-irq)" when the even is executed from IRQ context
(soft or hard irq). But I also added __event_in_hardirq() and
__event_in_softirq() if you wanted to distinguish them.

Now you don't need to update what goes into the ring buffer (and waste its
space), but only update the output format that makes it obvious that the
task was in interrupt context or not.

I also used trace-cmd to record the events, and it still parses properly
with no updates to libtraceevent needed.

Would this work for you?

Below is the patch that allows for this:

-- Steve


diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 1e7b0bef95f5..53a23988a3b8 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -150,3 +150,11 @@
 
 #undef __get_buf
 #define __get_buf(len)		trace_seq_acquire(p, (len))
+
+#undef __event_in_hardirq
+#undef __event_in_softirq
+#undef __event_in_irq
+
+#define __event_in_hardirq()	(__entry->ent.flags & TRACE_FLAG_HARDIRQ)
+#define __event_in_softirq()	(__entry->ent.flags & TRACE_FLAG_SOFTIRQ)
+#define __event_in_irq()	(__entry->ent.flags & (TRACE_FLAG_HARDIRQ | TRACE_FLAG_SOFTIRQ))
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index fcd564a590f4..47008897a795 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -26,6 +26,25 @@
 #undef __print_hex_dump
 #undef __get_buf
 
+#undef __event_in_hardirq
+#undef __event_in_softirq
+#undef __event_in_irq
+
+/*
+ * The TRACE_FLAG_* are enums. Instead of using TRACE_DEFINE_ENUM(),
+ * use their hardcoded values. These values are parsed by user space
+ * tooling elsewhere so they will never change.
+ *
+ * See "enum trace_flag_type" in linux/trace_events.h:
+ *   TRACE_FLAG_HARDIRQ
+ *   TRACE_FLAG_SOFTIRQ
+ */
+
+/* This is what is displayed in the format files */
+#define __event_in_hardirq()	(REC->common_flags & 0x8)
+#define __event_in_softirq()	(REC->common_flags & 0x10)
+#define __event_in_irq()	(REC->common_flags & 0x18)
+
 /*
  * The below is not executed in the kernel. It is only what is
  * displayed in the print format for userspace to parse.
