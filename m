Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40062423A72;
	Fri, 10 Jul 2026 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686841; cv=none; b=qhx9ZmGFesxeO3R6e8IbyrUfPulB5SQkZiS17NJsiyv01aRVnClslR672sLNG7eSTy4apYpZ4fzpkG66wSr2UrklCrEGiN8uv1GUcSVcDmB0oNdl28Sjpq21qFT0G3ABCQxVbEcHZGl62MT74Bsn8ixLz//Q5DCse3sKzjCjHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686841; c=relaxed/simple;
	bh=/3LFfTSz1Yugn4IIayMnDpcXV2ZYwmDm5Wl1FKx3IBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT6KDdvzgWFak3uIwuhBbrd0VlR9xXQHD2nYPUoxmR7Cbaa6zw8FV5ToN85JgXGAym4pAjiWujgeniyBZaLWaIWjeEzluoKtRmeJiZV3BNtj3GAtHZAvuwxO5cSfLnAhhaMGmU03bpySaemRw6Sao8sPMFY2AbDPyH9D1GujPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A0D8D40410;
	Fri, 10 Jul 2026 12:33:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id BB0192000E;
	Fri, 10 Jul 2026 12:33:48 +0000 (UTC)
Date: Fri, 10 Jul 2026 08:33:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jeongho Choi <jh1012.choi@samsung.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ji2yoon.jo@samsung.com, minki.jang@samsung.com, hajun.sung@samsung.com
Subject: Re: [BUG] tracing: Too many tries to read user space
Message-ID: <20260710083357.49e05ff6@gandalf.local.home>
In-Reply-To: <20260710122231.9bc9fae3dcfc72215f4a2dcd@kernel.org>
References: <CGME20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7@epcas2p1.samsung.com>
	<20260708123753.GB1386@KORCO121415.samsungds.net>
	<20260710122231.9bc9fae3dcfc72215f4a2dcd@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xjwbczaszc4t3he3xfzi6yazcunkhpiz
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: BB0192000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+zHIeKZhK7mP2nmQsGk+OI/EIv5Ok18wM=
X-HE-Tag: 1783686828-862018
X-HE-Meta: U2FsdGVkX1/GGL8uJ/7M/7VxhSll9bXtVPaA451hM9m/77IbAzKC/ihtUjpIGrN0ctZI0F4GzlVU4vXFTZDxLa7oI12LWLcZdfFSsMTOv5mv8dm9aZG233NVNDObpK+Ma2AX7n45OwB8qfJi0vdeC41lpKHRboEAslEIF8TllLvXWTpAet30V80Kms/NM524a/EtEOLRB68lCOR5Hj6B5mLJR3lIBiJo+P933Iks/oSbXI68GKVYGdd62lKJx46OuOGCkXO3b55eEYmTuNcJWH0qiH3livap50JY5Cu3kMl4XdKZY+tTOeWawkhsBtuHKLL2U8FzJJTx8pXnCrkWej/N1K7zqPvmFvCARE7JKgMCKvDyvxepMA==

On Fri, 10 Jul 2026 12:22:31 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hm, in my view, this warning indicates that the circuit breaker has
> triggered correctly, so that is not a bug. Under the heavy memory
> pressure and low-memory situation, the page can be reclaimed soon
> after it is copied.

So you are saying that every time the copy_from_user() is executed, the
page is reclaimed? And this causes a schedule?

Now, I did have a version that used sched_switch and only incremented the
counter when a non-kernel thread was scheduled in. Then the test would
check if the counter increased by 2 or more. As an increase by 1 meant that
only kernel threads scheduled in which would not corrupt the buffer. The 1
increment was the current task scheduling back.

This is based on that work (I'm glad I save old versions in my git tree :-)

Funny, the comments were from the original change I did back in August of
2025, which mentions kernel threads scheduling in to handle the fault.

I also kept this around in case it was needed. Looks like it may be needed.

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 18710c190c92..19354fe2fca1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -53,6 +53,8 @@
 #include <linux/io.h> /* vmap_page_range() */
 #include <linux/fs_context.h>
 
+#include <trace/events/sched.h>
+
 #include <asm/setup.h> /* COMMAND_LINE_SIZE */
 
 #include "trace.h"
@@ -5984,6 +5986,32 @@ struct trace_user_buf {
 static DEFINE_MUTEX(trace_user_buffer_mutex);
 static struct trace_user_buf_info *trace_user_buffer;
 
+static DEFINE_PER_CPU(unsigned long, sched_switch_cnt);
+
+/*
+ * The per CPU buffer trace_user_buffer is written to optimstically.
+ * The counter sched_switch_cnt is taken, preemption is enabled,
+ * the copying of the user space memory is placed into the trace_user_buffer,
+ * Preeption is re-enabled and the count is read again. If the count is greater
+ * than one from its previous reading, it means that another user space
+ * task scheduled in and the buffer is unreliable for use.
+ */
+static void
+probe_sched_switch(void *ignore, bool preempt,
+		   struct task_struct *prev, struct task_struct *next,
+		   unsigned int prev_state)
+{
+	/*
+	 * The buffer can only be corrupted by another user space task.
+	 * Ignore kernel tasks that may be scheduled in order to process
+	 * the faulting memory.
+	 */
+	if (!is_user_task(next))
+		return;
+
+	this_cpu_inc(sched_switch_cnt);
+}
+
 /**
  * trace_user_fault_destroy - free up allocated memory of a trace user buffer
  * @tinfo: The descriptor to free up
@@ -6003,6 +6031,8 @@ void trace_user_fault_destroy(struct trace_user_buf_info *tinfo)
 		kfree(buf);
 	}
 	free_percpu(tinfo->tbuf);
+
+	unregister_trace_sched_switch(probe_sched_switch, NULL);
 }
 
 static int user_fault_buffer_enable(struct trace_user_buf_info *tinfo, size_t size)
@@ -6053,11 +6083,17 @@ static int user_buffer_init(struct trace_user_buf_info **tinfo, size_t size)
 
 	lockdep_assert_held(&trace_user_buffer_mutex);
 
+	ret = register_trace_sched_switch(probe_sched_switch, NULL);
+	if (ret < 0)
+		return ret;
+
 	if (!*tinfo) {
 		alloc = true;
 		*tinfo = kzalloc_obj(**tinfo);
-		if (!*tinfo)
+		if (!*tinfo) {
+			unregister_trace_sched_switch(probe_sched_switch, NULL);
 			return -ENOMEM;
+		}
 	}
 
 	ret = user_fault_buffer_enable(*tinfo, size);
@@ -6241,7 +6277,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 			return NULL;
 
 		/* Read the current CPU context switch counter */
-		cnt = nr_context_switches_cpu(cpu);
+		cnt = this_cpu_read(sched_switch_cnt);
 
 		/*
 		 * Preemption is going to be enabled, but this task must
@@ -6272,12 +6308,19 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 			return NULL;
 
 		/*
-		 * Preemption is disabled again, now check the per CPU context
-		 * switch counter. If it doesn't match, then another user space
-		 * process may have schedule in and corrupted our buffer. In that
-		 * case the copying must be retried.
+		 * Preemption is disabled again, now check the sched_switch_cnt.
+		 * If it increased by two or more, then another user space process
+		 * may have schedule in and corrupted our buffer. In that case
+		 * the copying must be retried.
+		 *
+		 * Note, if this task was scheduled out and only kernel threads
+		 * were scheduled in (maybe to process the fault), then the
+		 * counter would increment again when this task scheduled in.
+		 * If this task scheduled out and another user task scheduled
+		 * in, this task would still need to be scheduled back in and
+		 * the counter would increment by at least two.
 		 */
-	} while (nr_context_switches_cpu(cpu) != cnt);
+	} while (this_cpu_read(sched_switch_cnt) > cnt + 1);
 
 	return buffer;
 }
