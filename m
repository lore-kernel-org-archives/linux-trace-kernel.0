Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFF1A6810;
	Tue, 31 Mar 2026 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918688; cv=none; b=ovQPCsOzXux+27apUMqRoc42uEhwuxivZhrirCX8OcuDuK8Hva3CTlzXAkih353pJ4dbSiBep4gk+J8vFS5X+4rA5gpfAN1oZ8fSEOvLzVdpHi5vqdJbyUJhrfLFO6uVjNQmDSiooWg44GWC9aCO9zcynihpH3CtVrDPeBll41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918688; c=relaxed/simple;
	bh=y7l7IE1VrnfHT4iipmmjDL2L9hGegYXVrVqY8IBM9VU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EillTGv0/zNko76wHb/UeIPK19cnWEPF8chXB6OgYxyZQW7mKy634T8d3Eu9mbHNTYZYGe7tn61IJI+T7v1MZ/Kl+UAX1IO3AZJAEUF81vmiDuxIzkc42X/nvFl7wn23ark6qv1no8eBdDZGz3ZNBBpODUYh11B0W0dXQAIxjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id CF4BAC2365;
	Tue, 31 Mar 2026 00:58:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 3A55460011;
	Tue, 31 Mar 2026 00:58:04 +0000 (UTC)
Date: Mon, 30 Mar 2026 20:58:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Remove duplicate latency_fsnotify() stub
Message-ID: <20260330205859.24c0aae3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q99npdryaj1homo9rxo676sftrh66zxa
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3A55460011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19swNYNZAZ9VzpD8rVxaoGlXC5I8gGw7tU=
X-HE-Tag: 1774918684-545386
X-HE-Meta: U2FsdGVkX1/+h+N1q2ViMYv7h+JAd5xWs9zVapRk6NVtdH0/8vFvfbaj2eodE8jUlQ10B0nppWc6kiKNySc5sqF16IMQck+Cdy+2CwSVlu7V7ujQWqXHEFVAZeJ0GlC6+Q/dWnGA8UCYRgwg+65vjMfSjTigITDliEw7z1UBs5g4paVsEy6diENRBkLUiFJ/yLSyWohqjAW2Ll6fkAB04pa5re2lquZoKEyNYF7iizD/UUQrZNWChs5TqXQzAeonwg8F4XK6nuzCIMA3McrRLuYc2OkMOh8VHDlnrkRP3q7HGRnqMmeKgLgohWCmFXYCKYoFfTfheKUBKXh1t2uZWO8gM0mJ5HDmFk7j9jbAxYt0XwiiBsoa8xZB8+euKA1pD6gWiJGZpCJV6YkCjdY8KCts6iiB44+1ftxWW4vn86U=

From: Steven Rostedt <rostedt@goodmis.org>

When the SNAPSHOT is defined but FSNOTIFY is not the latency_fsnotify()
function is turned into a static inline stub. But this stub was defined in
both trace.h and trace_snapshot.c causing a error in build when
CONFIG_SNAPSHOT is defined but FSNOTIFY is not. The stub is not needed in
trace_snapshot.c as it will be defined in trace.h, remove it from the C
file.

Fixes: bade44fe5462 ("tracing: Move snapshot code out of trace.c and into trace_snapshot.c")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603310604.lGE9LDBK-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h          | 2 +-
 kernel/trace/trace_snapshot.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a3ea735a9ef6..a59d6acdf95d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -845,13 +845,13 @@ void update_max_tr_single(struct trace_array *tr,
 #if defined(CONFIG_TRACER_MAX_TRACE) && defined(CONFIG_FSNOTIFY)
 # define LATENCY_FS_NOTIFY
 #endif
+#endif /* CONFIG_TRACER_SNAPSHOT */
 
 #ifdef LATENCY_FS_NOTIFY
 void latency_fsnotify(struct trace_array *tr);
 #else
 static inline void latency_fsnotify(struct trace_array *tr) { }
 #endif
-#endif /* CONFIG_TRACER_SNAPSHOT */
 
 #ifdef CONFIG_STACKTRACE
 void __trace_stack(struct trace_array *tr, unsigned int trace_ctx, int skip);
diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
index 8865b2ef2264..07b43c9863a2 100644
--- a/kernel/trace/trace_snapshot.c
+++ b/kernel/trace/trace_snapshot.c
@@ -391,9 +391,8 @@ void latency_fsnotify(struct trace_array *tr)
 	 */
 	irq_work_queue(&tr->fsnotify_irqwork);
 }
-#else
-static inline void latency_fsnotify(struct trace_array *tr) { }
 #endif /* LATENCY_FS_NOTIFY */
+
 static const struct file_operations tracing_max_lat_fops;
 
 void trace_create_maxlat_file(struct trace_array *tr,
-- 
2.51.0

