Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4782EACF6;
	Wed, 13 Aug 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095399; cv=none; b=KVujMB/2TWGzKOO81tyMZtsQwR6slaoOLGYmjKcrcgDBlFiq18GSY2ov0tBR6yFKUkxdgmdeiGooJG3M1w3R9QHloKaUvOILkczXbND8QGIrbFfGLkrzyat2dJBLoQHw5v9pOtm7oiV1ZxGewoLZbN0UvYB36WVmuL060SQGzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095399; c=relaxed/simple;
	bh=oAEVYAf3dzCEcckSbjnoduKc/tJlsEEvbBAJNtGqAd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRa6SbqONNTUhh8kp6qJm2+d0VPPd1YPrHDvccjuJWgHQEkmDDSXgPP7PxgFNcCDcSOSWG+92wrnMDmOQDEADr8zj9y+fV3NX0QVXIadOzUk25VUpu7nO7KStlXZt/hRcqHvmoI79Zjav8/W+C+GicLnuM2gTeeLdmFMWFZMtTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2D2Uu4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2D2Uu4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E875C4CEEB;
	Wed, 13 Aug 2025 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095399;
	bh=oAEVYAf3dzCEcckSbjnoduKc/tJlsEEvbBAJNtGqAd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2D2Uu4PPO9CxjojV19+JqJ6dKOW7c6vk1qiocVZ5I8+9tAHE0bpJkte/VPfiQGLm
	 qYfWDJOFcRxxejH7hQgpwac6W4GnZ8gIkD+woDgvfV1gVx2ilh3UHHdurMR+w6B3qf
	 fWhuVeRjEBndCcLRKI9D4kf2I+VS5rI1cMt/XjHGwpLCigGTUO56C6cSxJ8kFxKcGw
	 NGDPF30EfBZnx433LayklqlS3O7DCW3a05uuxsZAWC28syCE03T1T7DKlUZOb8PXU6
	 cssZ30Zs2urBdjjcsi6FuwLWWLRyKyyEWK8kSHyDK/cekn4GIIaAvN+KKEGjDiAdtC
	 Dpx1zk+bgPS9Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/4] tracing: eprobe: Cleanup eprobe event using __free()
Date: Wed, 13 Aug 2025 23:29:55 +0900
Message-ID: <175509539571.193596.4674012182718751429.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175509537667.193596.9139462012987606126.stgit@devnote2>
References: <175509537667.193596.9139462012987606126.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use __free(trace_event_probe_cleanup) to remove unneeded gotos and
cleanup the last part of trace_eprobe_parse_filter().

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |   71 ++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index aaba765d54cf..f7a1ff509d7e 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -61,6 +61,9 @@ static void trace_event_probe_cleanup(struct trace_eprobe *ep)
 	kfree(ep);
 }
 
+DEFINE_FREE(trace_event_probe_cleanup, struct trace_eprobe *,
+		if (!IS_ERR_OR_NULL(_T)) trace_event_probe_cleanup(_T))
+
 static struct trace_eprobe *to_trace_eprobe(struct dyn_event *ev)
 {
 	return container_of(ev, struct trace_eprobe, devent);
@@ -197,10 +200,10 @@ static struct trace_eprobe *alloc_event_probe(const char *group,
 					      struct trace_event_call *event,
 					      int nargs)
 {
-	struct trace_eprobe *ep;
+	struct trace_eprobe *ep __free(trace_event_probe_cleanup) = NULL;
 	const char *event_name;
 	const char *sys_name;
-	int ret = -ENOMEM;
+	int ret;
 
 	if (!event)
 		return ERR_PTR(-ENODEV);
@@ -211,25 +214,22 @@ static struct trace_eprobe *alloc_event_probe(const char *group,
 	ep = kzalloc(struct_size(ep, tp.args, nargs), GFP_KERNEL);
 	if (!ep) {
 		trace_event_put_ref(event);
-		goto error;
+		return ERR_PTR(-ENOMEM);
 	}
 	ep->event = event;
 	ep->event_name = kstrdup(event_name, GFP_KERNEL);
 	if (!ep->event_name)
-		goto error;
+		return ERR_PTR(-ENOMEM);
 	ep->event_system = kstrdup(sys_name, GFP_KERNEL);
 	if (!ep->event_system)
-		goto error;
+		return ERR_PTR(-ENOMEM);
 
 	ret = trace_probe_init(&ep->tp, this_event, group, false, nargs);
 	if (ret < 0)
-		goto error;
+		return ERR_PTR(ret);
 
 	dyn_event_init(&ep->devent, &eprobe_dyn_event_ops);
-	return ep;
-error:
-	trace_event_probe_cleanup(ep);
-	return ERR_PTR(ret);
+	return_ptr(ep);
 }
 
 static int eprobe_event_define_fields(struct trace_event_call *event_call)
@@ -856,13 +856,10 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
 	ret = create_event_filter(top_trace_array(), ep->event, ep->filter_str,
 				  true, &dummy);
 	free_event_filter(dummy);
-	if (ret)
-		goto error;
-
-	return 0;
-error:
-	kfree(ep->filter_str);
-	ep->filter_str = NULL;
+	if (ret) {
+		kfree(ep->filter_str);
+		ep->filter_str = NULL;
+	}
 	return ret;
 }
 
@@ -874,6 +871,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	 * Fetch args (no space):
 	 *  <name>=$<field>[:TYPE]
 	 */
+	struct trace_eprobe *ep __free(trace_event_probe_cleanup) = NULL;
 	const char *trlog __free(trace_probe_log_clear) = NULL;
 	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
 	const char *sys_event = NULL, *sys_name = NULL;
@@ -881,7 +879,6 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	char *buf1 __free(kfree) = NULL;
 	char *buf2 __free(kfree) = NULL;
 	char *gbuf __free(kfree) = NULL;
-	struct trace_eprobe *ep = NULL;
 	int ret = 0, filter_idx = 0;
 	int i, filter_cnt;
 
@@ -894,12 +891,12 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	if (event) {
 		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
 		if (!gbuf)
-			goto mem_error;
+			return -ENOMEM;
 		event++;
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
-			goto parse_error;
+			return -EINVAL;
 	}
 
 	trace_probe_log_set_index(1);
@@ -907,18 +904,18 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	buf2 = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
 	if (!buf2)
-		goto mem_error;
+		return -ENOMEM;
 
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
 	if (ret || !sys_event || !sys_name) {
 		trace_probe_log_err(0, NO_EVENT_INFO);
-		goto parse_error;
+		return -EINVAL;
 	}
 
 	if (!event) {
 		buf1 = kstrdup(sys_event, GFP_KERNEL);
 		if (!buf1)
-			goto mem_error;
+			return -ENOMEM;
 		event = buf1;
 	}
 
@@ -934,8 +931,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	if (argc - 2 > MAX_TRACE_ARGS) {
 		trace_probe_log_set_index(2);
 		trace_probe_log_err(0, TOO_MANY_ARGS);
-		ret = -E2BIG;
-		goto error;
+		return -E2BIG;
 	}
 
 	scoped_guard(mutex, &event_mutex) {
@@ -949,15 +945,14 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 			trace_probe_log_err(0, BAD_ATTACH_EVENT);
 		/* This must return -ENOMEM or missing event, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM && ret != -ENODEV);
-		ep = NULL;
-		goto error;
+		return ret;
 	}
 
 	if (filter_idx) {
 		trace_probe_log_set_index(filter_idx);
 		ret = trace_eprobe_parse_filter(ep, filter_cnt, argv + filter_idx);
 		if (ret)
-			goto parse_error;
+			return -EINVAL;
 	} else
 		ep->filter_str = NULL;
 
@@ -967,11 +962,12 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		trace_probe_log_set_index(i + 2);
 		ret = trace_eprobe_tp_update_arg(ep, argv, i);
 		if (ret)
-			goto error;
+			return ret;
 	}
 	ret = traceprobe_set_print_fmt(&ep->tp, PROBE_PRINT_EVENT);
 	if (ret < 0)
-		goto error;
+		return ret;
+
 	init_trace_eprobe_call(ep);
 	scoped_guard(mutex, &event_mutex) {
 		ret = trace_probe_register_event_call(&ep->tp);
@@ -980,24 +976,17 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 				trace_probe_log_set_index(0);
 				trace_probe_log_err(0, EVENT_EXIST);
 			}
-			goto error;
+			return ret;
 		}
 		ret = dyn_event_add(&ep->devent, &ep->tp.event->call);
 		if (ret < 0) {
 			trace_probe_unregister_event_call(&ep->tp);
-			goto error;
+			return ret;
 		}
+		/* To avoid freeing registered eprobe event, clear ep. */
+		ep = NULL;
 	}
 	return ret;
-
-mem_error:
-	ret = -ENOMEM;
-	goto error;
-parse_error:
-	ret = -EINVAL;
-error:
-	trace_event_probe_cleanup(ep);
-	return ret;
 }
 
 /*

