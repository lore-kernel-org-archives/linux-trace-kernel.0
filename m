Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4041DE8BB;
	Fri, 10 Jul 2026 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783653758; cv=none; b=nV8D0fANZhi9EeWzCA0J/3POyE6yw1PpA279dc/SG9sRP6aIhgtRXrf7nayeuKxdT8KK37VDVRsUQBImh+h0MvJIngH2JpINO8a8IZ73/ZEgrghmrzqPzBA6pPmSpcEK11dwN3MEoZwEUpry6hRsZCJOpF0nIeDMJ0jhu49B7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783653758; c=relaxed/simple;
	bh=bW/+REXaEFHZ67xqCCrqVKMzdimuw5BXlp6aTBllk/0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XQYfO7PxVgZKKnXXqWT8MaTfcrjHEbmCd7fV4uNPDdsz3/PzFwJoUzC8Ha8AZU66d2at2XuVblh+F1GiDbAOBlrY+NAzQSDfALGmzlymDWH6AqCmt3+FPGJlQSi2ijsqhbAlUnl4QVF48MsD9+FSvejhFCLB9GFYuY6Y6F+/FK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3uFp7cy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3uFp7cy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F121F000E9;
	Fri, 10 Jul 2026 03:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783653756;
	bh=2pOGmsvtjNu32q26XoviVJrQKvJL759wkqD5qCeM9dg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N3uFp7cyYP32eLqgYTp5txTjG8IUSEkGj+Z5X/KZSbXTwKiRLkQwglJuMhi5O18qD
	 XlbgW4h4rGguHsK0uOHz0QFci9Uf3/Ht3QVj3LpVBpm5CrVuVZaofv3id5JD7teub1
	 9n36hUPkY06lfEgw42SK7av4cM4JmtPrHJ4m0emzzzcsspO/n9rVleFu/zaIAAFEl9
	 kQ3q/pcYRbS5yZl78phb24LeMMzuRjEL5+gVJ95A3ZoQMWkQVbB+egl+rUWAWdBpKl
	 0e9qiZj4eQGrjIPeqN+bMyszdOuo41WUyfubu5px3FmhM9gJYZjLMEUbcS9oX8k1GV
	 j2RvzoUOGJ+4w==
Date: Fri, 10 Jul 2026 12:22:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeongho Choi <jh1012.choi@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, ji2yoon.jo@samsung.com, minki.jang@samsung.com,
 hajun.sung@samsung.com
Subject: Re: [BUG] tracing: Too many tries to read user space
Message-Id: <20260710122231.9bc9fae3dcfc72215f4a2dcd@kernel.org>
In-Reply-To: <20260708123753.GB1386@KORCO121415.samsungds.net>
References: <CGME20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7@epcas2p1.samsung.com>
	<20260708123753.GB1386@KORCO121415.samsungds.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jul 2026 21:37:53 +0900
Jeongho Choi <jh1012.choi@samsung.com> wrote:

> Hello,
> 
> We are seeing a reproducible kernel panic related to the tracing code
> when it fails to read user-space memory.
> 
> The issue was originally reported through the Android/Google Issue
> Tracker, and we were advised to report it to the upstream trace mailing
> list because the affected code is upstream.
> 
> Environment:
> 
> Architecture: arm64
> Kernel: Linux 6.18.21
> Base: Android Common Kernel (android17-6.18)
> Affected area: kernel/trace/
> 
> The relevant error/panic log is:
> [48916.569148] [9:           lmkd:  536] Error: Too many tries to read
> user space
> [48916.569156] [9:           lmkd:  536] WARNING: CPU: 9 PID: 536 at
> kernel/trace/trace.c:7374 trace_user_fault_read+0x334/0x360
> [48916.569443] [9:           lmkd:  536] CPU: 9 UID: 1069 PID: 536 Comm:
> lmkd Tainted: G           OE       6.18.21-android17-5-ga1a8e8cab9ec-4k
> #1 PREEMPT  25372cd4750dcac3c0fe86b57d47c665f97a6046
> 
> [48916.569450] [9:           lmkd:  536] pstate: 63402005 (nZCv daif
> +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [48916.569452] [9:           lmkd:  536] pc :
> trace_user_fault_read+0x334/0x360
> [48916.569454] [9:           lmkd:  536] lr :
> trace_user_fault_read+0x330/0x360
> [48916.569456] [9:           lmkd:  536] sp : ffffffc096993cc0
> [48916.569457] [9:           lmkd:  536] x29: ffffffc096993cd0 x28:
> 0000000000000065 x27: ffffff8817e45200
> [48916.569461] [9:           lmkd:  536] x26: 0000000000000000 x25:
> 000000011616c082 x24: 0000000000000000
> [48916.569463] [9:           lmkd:  536] x23: 0000000000000009 x22:
> 000000000000002b x21: ffffff880597f740
> [48916.569466] [9:           lmkd:  536] x20: 0000007fc42dd940 x19:
> ffffff8817e45770 x18: ffffffd5947ce240
> [48916.569468] [9:           lmkd:  536] x17: 2073656972742079 x16:
> 6e616d206f6f5420 x15: 3a726f727245205d
> [48916.569471] [9:           lmkd:  536] x14: 36333520203a646b x13:
> 6563617073207265 x12: 0000000000000001
> [48916.569473] [9:           lmkd:  536] x11: 6f74207365697274 x10:
> 0000000000000001 x9 : 4bd9ad4516d75100
> [48916.569476] [9:           lmkd:  536] x8 : 4bd9ad4516d75100 x7 :
> 205d383431393635 x6 : 2e36313938345b0a
> [48916.569479] [9:           lmkd:  536] x5 : ffffffc080fa5998 x4 :
> ffffffd591707202 x3 : 0001360a00000000
> [48916.569481] [9:           lmkd:  536] x2 : ffffffc096993af4 x1 :
> 00000000000000c0 x0 : 0000000000000028
> [48916.569484] [9:           lmkd:  536] Call trace:
> [48916.569486] [9:           lmkd:  536]
> trace_user_fault_read+0x334/0x360 (P)
> [48916.569488] [9:           lmkd:  536]  tracing_mark_write+0x84/0x174
> [48916.569491] [9:           lmkd:  536]  __arm64_sys_write+0x2a0/0x5c0
> [48916.569494] [9:           lmkd:  536]  invoke_syscall+0x58/0xe4
> [48916.569498] [9:           lmkd:  536]  do_el0_svc+0x48/0xdc
> [48916.569500] [9:           lmkd:  536]  el0_svc+0x3c/0x98
> [48916.569503] [9:           lmkd:  536]
> el0t_64_sync_handler+0x20/0x130
> [48916.569505] [9:           lmkd:  536]  el0t_64_sync+0x1c4/0x1c8
> [48916.569508] [9:           lmkd:  536] Kernel panic - not syncing:
> kernel: panic_on_warn set ...
> 
> 
> The code at the WARN location mentioned in the log above is as follows.
> 
> 7374                 if (WARN_ONCE(trys++ > 100, "Error: Too many
>   tries to read user space"))
> 7375                         return NULL;
> 
> 
> Our current analysis is as follows:
> 
> In the Gmail process, during a low memory situation, LMKD writes strings
> to /sys/kernel/tracing/trace_marker for systrace recording. At the same
> time, it broadcasts a sigkill due to low memory, which is causing the
> LMKD trace marker operation to stall.

Hm, in my view, this warning indicates that the circuit breaker has
triggered correctly, so that is not a bug. Under the heavy memory
pressure and low-memory situation, the page can be reclaimed soon
after it is copied.

However, this seems a bit strange that we only checks the CPU-wide context
switching in the loop. Instead, can we introduce a per-cpu sequence counter
to per-cpu buffer, and check it? 

Could you try this ?

From f76d8e4400a5961725d17899f4290c9334987e2b Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Fri, 10 Jul 2026 12:11:00 +0900
Subject: [PATCH] tracing: Use per-CPU sequence counter in
 trace_user_fault_read

trace_user_fault_read() copies trace data from user space to the
per-CPU trace buffer. When preemption is enabled during the copy, it
checks if any context switches occurred on the current CPU via
nr_context_switches_cpu() to detect whether the buffer may have been
corrupted by another trace writer.

However, under heavy memory pressure, copying from user space can trigger
page faults (e.g., for swapped-out BSS or anonymous pages) that block and
cause a context switch. Because nr_context_switches_cpu() detects any
context switch (even unrelated ones), it mistakenly assumes the buffer was
corrupted. This leads to repeated retries (up to the 100-try limit), which
causes a WARN_ONCE backtrace and returns -EFAULT to user space, even if
no other task ever accessed the trace buffer.

To mitigate this issue, replace the CPU-wide context switch check with
a dedicated per-CPU sequence counter in struct trace_user_buf.

Since only other tasks invoking trace_user_fault_read() on the same CPU
will increment this counter, unrelated context switches (including those
from page fault sleep) will no longer trigger retries.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1bc27c0ad029..46cec63f5798 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5989,6 +5989,7 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char *buf,
 
 struct trace_user_buf {
 	char		*buf;
+	unsigned int	sequence;
 };
 
 static DEFINE_MUTEX(trace_user_buffer_mutex);
@@ -6031,7 +6032,10 @@ static int user_fault_buffer_enable(struct trace_user_buf_info *tinfo, size_t si
 
 	/* Clear each buffer in case of error */
 	for_each_possible_cpu(cpu) {
-		per_cpu_ptr(tinfo->tbuf, cpu)->buf = NULL;
+		struct trace_user_buf *tbuf = per_cpu_ptr(tinfo->tbuf, cpu);
+
+		tbuf->buf = NULL;
+		tbuf->sequence = 0;
 	}
 
 	for_each_possible_cpu(cpu) {
@@ -6196,8 +6200,9 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 			     trace_user_buf_copy copy_func, void *data)
 {
 	int cpu = smp_processor_id();
-	char *buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
-	unsigned int cnt;
+	struct trace_user_buf *tbuf = per_cpu_ptr(tinfo->tbuf, cpu);
+	char *buffer = tbuf->buf;
+	unsigned int seq;
 	int trys = 0;
 	int ret;
 
@@ -6211,10 +6216,10 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		return NULL;
 
 	/*
-	 * This acts similar to a seqcount. The per CPU context switches are
+	 * This acts similar to a seqcount. The per CPU sequence counters are
 	 * recorded, migration is disabled and preemption is enabled. The
 	 * read of the user space memory is copied into the per CPU buffer.
-	 * Preemption is disabled again, and if the per CPU context switches count
+	 * Preemption is disabled again, and if the per CPU sequence count
 	 * is still the same, it means the buffer has not been corrupted.
 	 * If the count is different, it is assumed the buffer is corrupted
 	 * and reading must be tried again.
@@ -6235,7 +6240,8 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 			preempt_enable_notrace();
 			preempt_disable_notrace();
 			cpu = smp_processor_id();
-			buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
+			tbuf = per_cpu_ptr(tinfo->tbuf, cpu);
+			buffer = tbuf->buf;
 		}
 
 		/*
@@ -6250,8 +6256,9 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		if (WARN_ONCE(trys++ > 100, "Error: Too many tries to read user space"))
 			return NULL;
 
-		/* Read the current CPU context switch counter */
-		cnt = nr_context_switches_cpu(cpu);
+		/* Increment the per-CPU buffer sequence counter */
+		tbuf->sequence++;
+		seq = tbuf->sequence;
 
 		/*
 		 * Preemption is going to be enabled, but this task must
@@ -6282,12 +6289,12 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 			return NULL;
 
 		/*
-		 * Preemption is disabled again, now check the per CPU context
-		 * switch counter. If it doesn't match, then another user space
+		 * Preemption is disabled again, now check the per CPU sequence
+		 * counter. If it doesn't match, then another user space
 		 * process may have schedule in and corrupted our buffer. In that
 		 * case the copying must be retried.
 		 */
-	} while (nr_context_switches_cpu(cpu) != cnt);
+	} while (tbuf->sequence != seq);
 
 	return buffer;
 }
-- 
2.43.0



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
