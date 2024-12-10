Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5772451F1;
	Tue, 10 Dec 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869536; cv=none; b=aDSbh64Oszhp4sauhXTTd2x9RuK5fVHw1WGtL6cQQlgIbqDfEDJDs928zcIz/fuZx7gk/bLstbeplYN8kYL4ho2kcaWWNJBFe1rmlihkz7+AZHcxwPjOpz/+du0itIesS9vkcj7oBfaSlRU7DbGUesMNCgGUuQmMG74yFTJ56hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869536; c=relaxed/simple;
	bh=O3OJbBLmg2fsTkk7oAuJubmyRerENRw8xeQZIlNz7zw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=skzMHnrd/jW1TpSAo9LZOmG1d3fo1kkjN82syHEqykqUZKax/rbORXRYxcHg4FK0mxLqP1pfYFoDbzfPFOgEjbkt1WboPbsB8NYgAd2gwzL0kLHTnI86HfqPGJt/SE8WGH75Nw9qp8Utqv69pK4JTMNB9A2IIfbcatTjTe8DeK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4948DC4CED6;
	Tue, 10 Dec 2024 22:25:35 +0000 (UTC)
Date: Tue, 10 Dec 2024 17:25:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Fix trace output when pointer hash is disabled
Message-ID: <20241210172533.04bcd5f7@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The "%p" in the trace output is by default hashes the pointer. An option
was added to disable the hashing as reading trace output is a privileged
operation (just like reading kallsyms). When hashing is disabled, the
iter->fmt temp buffer is used to add "x" to "%p" into "%px" before sending
to the svnprintf() functions.

The problem with using iter->fmt, is that the trace_check_vprintf() that
makes sure that trace events "%pX" pointers are not dereferencing freed
addresses (and prints a warning if it does) also uses the iter->fmt to
save to and use to print out for the trace file. When the hash_ptr option
is disabled, the "%px" version is added to the iter->fmt buffer, and that
then is passed to the trace_check_vprintf() function that then uses the
iter->fmt as a temp buffer. Obviously this caused bad results.

This was noticed when backporting the persistent ring buffer to 5.10 and
added this code without the option being disabled by default, so it failed
one of the selftests because the sched_wakeup was missing the "comm"
field:

     cat-907     [006] dN.4.   249.722403: sched_wakeup: comm= pid=74 prio=120 target_cpu=006

Instead of showing:

  <idle>-0       [004] dNs6.    49.076464: sched_wakeup: comm=sshd-session pid=896 prio=120 target_cpu=0040

To fix this, change trace_check_vprintf() to modify the iter->fmt instead
of copying to it. If the fmt passed in is not the iter->fmt, first copy
the entire fmt string to iter->fmt and then iterate the iter->fmt. When
the format needs to be processed, perform the following like actions:

  save_ch = p[i];
  p[i] = '\0';
  trace_seq_printf(&iter->seq, p, str);
  p[i] = save_ch;

Cc: stable@vger.kernel.org
Fixes: efbbdaa22bb78 ("tracing: Show real address for trace event arguments")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 82 ++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814..ceae68b7466d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3711,8 +3711,10 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 {
 	long text_delta = 0;
 	long data_delta = 0;
-	const char *p = fmt;
 	const char *str;
+	char *p;
+	char save_ch;
+	char *buf = NULL;
 	bool good;
 	int i, j;
 
@@ -3737,6 +3739,19 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 	if (iter->fmt == static_fmt_buf)
 		goto print;
 
+	if (fmt != iter->fmt) {
+		int len = strlen(fmt);
+		while (iter->fmt_size < len + 1) {
+			/*
+			 * If we can't expand the copy buffer,
+			 * just print it.
+			 */
+			if (!trace_iter_expand_format(iter))
+				goto print;
+		}
+		strscpy(iter->fmt, fmt, iter->fmt_size);
+	}
+	p = iter->fmt;
 	while (*p) {
 		bool star = false;
 		int len = 0;
@@ -3748,14 +3763,6 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		 * as well as %p[sS] if delta is non-zero
 		 */
 		for (i = 0; p[i]; i++) {
-			if (i + 1 >= iter->fmt_size) {
-				/*
-				 * If we can't expand the copy buffer,
-				 * just print it.
-				 */
-				if (!trace_iter_expand_format(iter))
-					goto print;
-			}
 
 			if (p[i] == '\\' && p[i+1]) {
 				i++;
@@ -3788,10 +3795,11 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		if (!p[i])
 			break;
 
-		/* Copy up to the %s, and print that */
-		strncpy(iter->fmt, p, i);
-		iter->fmt[i] = '\0';
-		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
+		/* Print up to the %s */
+		save_ch = p[i];
+		p[i] = '\0';
+		trace_seq_vprintf(&iter->seq, p, ap);
+		p[i] = save_ch;
 
 		/* Add delta to %pS pointers */
 		if (p[i+1] == 'p') {
@@ -3837,6 +3845,8 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			good = trace_safe_str(iter, str, star, len);
 		}
 
+		p += i;
+
 		/*
 		 * If you hit this warning, it is likely that the
 		 * trace event in question used %s on a string that
@@ -3849,41 +3859,47 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		if (WARN_ONCE(!good, "fmt: '%s' current_buffer: '%s'",
 			      fmt, seq_buf_str(&iter->seq.seq))) {
 			int ret;
+#define TEMP_BUFSIZ 1024
+
+			if (!buf) {
+				char *buf = kmalloc(TEMP_BUFSIZ, GFP_KERNEL);
+				if (!buf) {
+					/* Need buffer to read address */
+					trace_seq_printf(&iter->seq, "(0x%px)[UNSAFE-MEMORY]", str);
+					goto print;
+				}
+			}
+			if (len >= TEMP_BUFSIZ)
+				len = TEMP_BUFSIZ - 1;
 
 			/* Try to safely read the string */
 			if (star) {
-				if (len + 1 > iter->fmt_size)
-					len = iter->fmt_size - 1;
-				if (len < 0)
-					len = 0;
-				ret = copy_from_kernel_nofault(iter->fmt, str, len);
-				iter->fmt[len] = 0;
-				star = false;
+				ret = copy_from_kernel_nofault(buf, str, len);
+				buf[len] = 0;
 			} else {
-				ret = strncpy_from_kernel_nofault(iter->fmt, str,
-								  iter->fmt_size);
+				ret = strncpy_from_kernel_nofault(buf, str, 1024);
 			}
 			if (ret < 0)
 				trace_seq_printf(&iter->seq, "(0x%px)", str);
 			else
-				trace_seq_printf(&iter->seq, "(0x%px:%s)",
-						 str, iter->fmt);
-			str = "[UNSAFE-MEMORY]";
-			strcpy(iter->fmt, "%s");
+				trace_seq_printf(&iter->seq, "(0x%px:%s)", str, buf);
+			trace_seq_puts(&iter->seq, "[UNSAFE-MEMORY]");
 		} else {
-			strncpy(iter->fmt, p + i, j + 1);
-			iter->fmt[j+1] = '\0';
+			save_ch = p[j + 1];
+			p[j + 1] = '\0';
+			if (star)
+				trace_seq_printf(&iter->seq, p, len, str);
+			else
+				trace_seq_printf(&iter->seq, p, str);
+			p[j + 1] = save_ch;
 		}
-		if (star)
-			trace_seq_printf(&iter->seq, iter->fmt, len, str);
-		else
-			trace_seq_printf(&iter->seq, iter->fmt, str);
 
-		p += i + j + 1;
+		p += j + 1;
 	}
  print:
 	if (*p)
 		trace_seq_vprintf(&iter->seq, p, ap);
+	kfree(buf);
 }
 
 const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
-- 
2.45.2

