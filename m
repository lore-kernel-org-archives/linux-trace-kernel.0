Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AA38B9B3;
	Fri,  6 Feb 2026 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397928; cv=none; b=NaQuvrM3EHf1qhQGscOCbVuwrGLr1vNdB4hu1i+QmfylzegGwW67kCRLnU1BXShQAFV57nNBOlMOyYcmwnm40ZlFz01xSPv0LBtIxBIg9jbIP2SR1lkdWe22+M72CHhyxIpA/qb4KRu4UqKQMmQ8bl7S8OUrtTrvI8i+D0yRuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397928; c=relaxed/simple;
	bh=C9lyYm1t0iSah1ZFPmrrK7NrIqaedL3OuDjKiuy/kjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=q6yA8JFzKsRIoYy40OZY3T/ZSVU2s/846mqqEXZKotzqIbrN9pKR0ui6NeeHOpBtA8Yzr7TLqTMvBqYfYXbkCMG/GVMDkn5hiot8v302xo7VqGNl5F8Cda8TPltQ4Hk+da45OowSQPHlVyED+O0NNcFLmJ+PRYJfo9K5d4OKBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 88AE48A8AA;
	Fri,  6 Feb 2026 17:12:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id D88696000B;
	Fri,  6 Feb 2026 17:12:04 +0000 (UTC)
Date: Fri, 6 Feb 2026 12:12:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Clean up use of trace_create_maxlat_file()
Message-ID: <20260206121242.6cb1934d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D88696000B
X-Stat-Signature: qd573ctyig8faro88z6ri8yiybh135y4
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/fjKJEEep7ugQmQobsIC3RDbZLoMSPSDM=
X-HE-Tag: 1770397924-782519
X-HE-Meta: U2FsdGVkX1868pKA45ZB25bRHf5/lmD7lTyWT7qDolPDWX05PowOQugdm9KiJKo0YT/v4fFRVwoj/oX5E+uJT85ai/1LU2RAm6r7AYOOzgoJD1lEg5Wfnrukugeyzrz9K49Va7qgCp5zCLfCmc2TNrMcq79tPXqRz9CtUDnWeFUCj50XpsCFfT+wE/oseP3fzWlMwEAKYt1hSs0FagiWvEHI06oExs9S4/b9wPhgrWen5BZmdEC4310GA0wQTXJy4ilw8RkNf3LKhuXvs2Ut5nF88MCmAcJmLpemDdOPH9XcM/m0vge6WrVtHlZ1FTWpmeIJqmPtvPMmsrBXoVuywCWYIxP/e/TWe37NBn4jmTYEwf/+eXTFukQIzkEOAJPu

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
 kernel/trace/trace.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dfa30711c6e2..5bc22d966834 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1547,10 +1547,8 @@ void latency_fsnotify(struct trace_array *tr)
 
 #else /* !LATENCY_FS_NOTIFY */
 
-#define trace_create_maxlat_file(tr, d_tracer)				\
-	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, tr, &tracing_max_lat_fops)
-
+static inline void trace_create_maxlat_file(struct trace_array *tr,
+					    struct dentry *d_tracer) { }
 #endif
 
 /*
@@ -9909,9 +9907,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
 	trace_create_maxlat_file(tr, d_tracer);
-#endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
-- 
2.51.0

