Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640A33F8DE;
	Wed,  5 Nov 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359567; cv=none; b=Cf6JJ4VWceq3d+LTYs93J8qla+LQEVB1TQcNF86K26pdPsZXg8MCSB2AoRMmE1pskP4cuHpA1JfoeT5voGJlmAPbncZAx7skIaFHDa9R7XNRIFkNpIter+HG4OYg6tYUVxjLGnCowehnT1H1BdUQHwgesnhD1wkcYtTYnwi2uhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359567; c=relaxed/simple;
	bh=UbMMUEEh5kH2fKPUtIHqA54/voWDDknuZccPtnRfSgo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IzYd5J/s6jBbgmU38BxIOoUCFd0OaLh4guPvh5K3vKH98TWOG4X1WUYRWBb795KZJ7lz0UvEFqTf+dxhi1gVy/PcI/5S3fA7oUzd2DWwnl+CrRIylr+EuY+Q3dSkxwx+95tIGl/2PcpGEr+F8Ho+oir8CBB/KttqwEwLOxWYKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llTQ7wM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llTQ7wM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01FDC116C6;
	Wed,  5 Nov 2025 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359566;
	bh=UbMMUEEh5kH2fKPUtIHqA54/voWDDknuZccPtnRfSgo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=llTQ7wM3+H/sMor95uEA3xbKtJQJFufno624LJuVs6KGakv3ZiDCKe5K4PrTdMTse
	 /I3Qnyb2IYP4zyG+E+jeHlt6joQpIsHuANO/vDfJaqLDRzIJlM+OAdJuREs3Bauf0t
	 sGMp4cJ+C+/XDWJavjPYXC7GPAtcs9FinBCsvrRT6uxjbsS02YajJZN043Q9gt7mM/
	 alAl3S9eGqDZarqsdBKrvKHX8a5tW+YykUYR5H7XUSEFYO+/aEr0UkPmUuKxICGWLS
	 g6T9pEqBldUd4kB5UxFsp/oXf61f2qlYwRYpoLQBOlOBollPpRHJwuqNaSyb6gTrum
	 Pth823HmbUCOQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vGgER-00000000pVh-2CAr;
	Wed, 05 Nov 2025 11:19:35 -0500
Message-ID: <20251105161935.375299297@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 05 Nov 2025 11:19:11 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/5] tracing: Have add_tracer_options() error pass up to callers
References: <20251105161909.590008129@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function add_tracer_options() can fail, but currently it is ignored.
Pass the status of add_tracer_options() up to adding a new tracer as well
as when an instance is created. Have the instance creation fail if the
add_tracer_options() fail.

Only print a warning for the top level instance, like it does with other
failures.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 55 +++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index afeaa9a164e9..ed929d331e1d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2302,7 +2302,7 @@ static inline int do_run_tracer_selftest(struct tracer *type)
 }
 #endif /* CONFIG_FTRACE_STARTUP_TEST */
 
-static void add_tracer_options(struct trace_array *tr, struct tracer *t);
+static int add_tracer_options(struct trace_array *tr, struct tracer *t);
 
 static void __init apply_trace_boot_options(void);
 
@@ -2353,9 +2353,14 @@ int __init register_tracer(struct tracer *type)
 	if (ret < 0)
 		goto out;
 
+	ret = add_tracer_options(&global_trace, type);
+	if (ret < 0) {
+		pr_warn("Failed to create tracer options for %s\n", type->name);
+		goto out;
+	}
+
 	type->next = trace_types;
 	trace_types = type;
-	add_tracer_options(&global_trace, type);
 
  out:
 	mutex_unlock(&trace_types_lock);
@@ -6221,7 +6226,7 @@ int tracing_update_buffers(struct trace_array *tr)
 
 struct trace_option_dentry;
 
-static void
+static int
 create_trace_option_files(struct trace_array *tr, struct tracer *tracer);
 
 /*
@@ -6243,17 +6248,17 @@ static void tracing_set_nop(struct trace_array *tr)
 
 static bool tracer_options_updated;
 
-static void add_tracer_options(struct trace_array *tr, struct tracer *t)
+static int add_tracer_options(struct trace_array *tr, struct tracer *t)
 {
 	/* Only enable if the directory has been created already. */
 	if (!tr->dir && !(tr->flags & TRACE_ARRAY_FL_GLOBAL))
-		return;
+		return 0;
 
 	/* Only create trace option files after update_tracer_options finish */
 	if (!tracer_options_updated)
-		return;
+		return 0;
 
-	create_trace_option_files(tr, t);
+	return create_trace_option_files(tr, t);
 }
 
 int tracing_set_tracer(struct trace_array *tr, const char *buf)
@@ -9585,7 +9590,7 @@ create_trace_option_file(struct trace_array *tr,
 
 }
 
-static void
+static int
 create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 {
 	struct trace_option_dentry *topts;
@@ -9596,24 +9601,24 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 	int i;
 
 	if (!tracer)
-		return;
+		return 0;
 
 	flags = tracer->flags;
 
 	if (!flags || !flags->opts)
-		return;
+		return 0;
 
 	/*
 	 * If this is an instance, only create flags for tracers
 	 * the instance may have.
 	 */
 	if (!trace_ok_for_array(tracer, tr))
-		return;
+		return 0;
 
 	for (i = 0; i < tr->nr_topts; i++) {
 		/* Make sure there's no duplicate flags. */
 		if (WARN_ON_ONCE(tr->topts[i].tracer->flags == tracer->flags))
-			return;
+			return -EINVAL;
 	}
 
 	opts = flags->opts;
@@ -9623,13 +9628,13 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 
 	topts = kcalloc(cnt + 1, sizeof(*topts), GFP_KERNEL);
 	if (!topts)
-		return;
+		return 0;
 
 	tr_topts = krealloc(tr->topts, sizeof(*tr->topts) * (tr->nr_topts + 1),
 			    GFP_KERNEL);
 	if (!tr_topts) {
 		kfree(topts);
-		return;
+		return -ENOMEM;
 	}
 
 	tr->topts = tr_topts;
@@ -9644,6 +9649,7 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 			  "Failed to create trace option: %s",
 			  opts[cnt].name);
 	}
+	return 0;
 }
 
 static struct dentry *
@@ -10094,15 +10100,18 @@ static void init_trace_flags_index(struct trace_array *tr)
 		tr->trace_flags_index[i] = i;
 }
 
-static void __update_tracer_options(struct trace_array *tr)
+static int __update_tracer_options(struct trace_array *tr)
 {
 	struct tracer *t;
+	int ret = 0;
+
+	for (t = trace_types; t && !ret; t = t->next)
+		ret = add_tracer_options(tr, t);
 
-	for (t = trace_types; t; t = t->next)
-		add_tracer_options(tr, t);
+	return ret;
 }
 
-static void update_tracer_options(struct trace_array *tr)
+static __init void update_tracer_options(struct trace_array *tr)
 {
 	guard(mutex)(&trace_types_lock);
 	tracer_options_updated = true;
@@ -10151,9 +10160,13 @@ static int trace_array_create_dir(struct trace_array *tr)
 	}
 
 	init_tracer_tracefs(tr, tr->dir);
-	__update_tracer_options(tr);
-
-	return ret;
+	ret = __update_tracer_options(tr);
+	if (ret) {
+		event_trace_del_tracer(tr);
+		tracefs_remove(tr->dir);
+		return ret;
+	}
+	return 0;
 }
 
 static struct trace_array *
-- 
2.51.0


