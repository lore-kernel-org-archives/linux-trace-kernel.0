Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8E14A8B;
	Sat,  7 Feb 2026 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770437061; cv=none; b=Kb/0KsLdX4069Rc6WHyDcyonbCxeZHQstX2TPWHYMU4NTqa6PkIYKNQFQQ4kWq7Gc05w/ddbn/IvpKDMPmvjXlIk3D+/Kh3ZFhkAzp2JZpBTocjosMh0qdksFNmIE0+z2IyM7UF0IOuvsuiv3HdklrRgqnh7rTGMQQGwQrg5Gow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770437061; c=relaxed/simple;
	bh=c/rBNCzJkfNFIGfWuWZ8dEeSaFONcPzxPQcb2+HrKo4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AhH/uYLfmwmnSWuT3Py9CYrAMkqqiKtmNBnQX7IOLR2jfBXPoi9FBCRf2nrTMvdn0JcNvrg5JVx/Ob1C6C50QY0ZUnRklvEPdebmE8HEGR4ZgCUB28L56gdAtYAFPjpqnzX+CDw7Y9TP9iaI2gzD+NfkLkoKlQE7pggzPx9KQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id F3E0058A1F;
	Sat,  7 Feb 2026 04:04:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 62E2820028;
	Sat,  7 Feb 2026 04:04:12 +0000 (UTC)
Date: Fri, 6 Feb 2026 23:04:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Clean up use of trace_create_maxlat_file()
Message-ID: <20260206230410.4ed96e9f@robin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 62E2820028
X-Stat-Signature: qkhtkwqf9fsczo9npi5rafrwjxf799s4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19b3U7bj8SAg4Eq+Dqa57EDAVyXP15wboo=
X-HE-Tag: 1770437052-734699
X-HE-Meta: U2FsdGVkX19cicQd/ZFCAvtcm2YBRnbEYowheJ590kgpuPmx5JPCPZUKVBBNKhGjTqh7UI335SJASRElpYRwRLw7WBjLbMPWI0Sax1Hdqlr1YD8PZ5y7yWPvss8ba3dswrSfX2q2DbHOYXdlBvWH1Cq9nLXGkCS1rSKFl7hzBvoIf8eDuNvTDI7kQvj0SkDKghk5AgRpf1Sf8BWyPG+Ko42Xb1p0nR/rBOcVYLz6ewEw/bi62KIua+0y8MZc40hdOFI8PAbs4PF9Fva8yGvSNiwsEqpyNQlyN5F+nCQxM2yB8DC+aAeaGpGQvyIJ1TeSK2lQyMgXYcStYuYh3udO8LDi8p66UgkLDJQ9SE8dJCGCjX2iUdyZnKXUnTzZXjNMrOHvrHbQHflQoCxeussuRvdA4GFoa434Z5YwdpCm6fW8J/RUfm8DoQPbRSWMGcJFAv60G8NAkqlu2wXi43pUYw==

From: Steven Rostedt <rostedt@goodmis.org>

In trace.c, the function trace_create_maxlat_file() is defined behind the
 #ifdef CONFIG_TRACER_MAX_TRACE block. The #else part defines it as:

 #define trace_create_maxlat_file(tr, d_tracer)				\
	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
			  d_tracer, tr, &tracing_max_lat_fops)

But the one place that it it used has:

 #ifdef CONFIG_TRACER_MAX_TRACE
	trace_create_maxlat_file(tr, d_tracer);
 #endif

Which is pointless.

Define trace_create_maxlat_file() when CONFIG_TRACER_MAX_TRACE is not
defined as:

 static inline void trace_create_maxlat_file(struct trace_array *tr,
				     struct dentry *d_tracer) { }

And remove the #ifdef's from the code.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20260206121242.6cb1934d@gandalf.local.home

- Fix stub function missing from !CONFIG_TRACER_MAX_TRACE

 kernel/trace/trace.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6815df23e5a3..b59c237f463c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1969,11 +1969,8 @@ void latency_fsnotify(struct trace_array *tr)
 }
 
 #else /* !LATENCY_FS_NOTIFY */
-
-#define trace_create_maxlat_file(tr, d_tracer)				\
-	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, tr, &tracing_max_lat_fops)
-
+static inline void trace_create_maxlat_file(struct trace_array *tr,
+					    struct dentry *d_tracer) { }
 #endif
 
 /*
@@ -2109,7 +2106,9 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	__update_max_tr(tr, tsk, cpu);
 	arch_spin_unlock(&tr->max_lock);
 }
-
+#else
+static inline void trace_create_maxlat_file(struct trace_array *tr,
+					    struct dentry *d_tracer) { }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 struct pipe_wait {
@@ -10684,9 +10683,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
 	trace_create_maxlat_file(tr, d_tracer);
-#endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
-- 
2.51.0

