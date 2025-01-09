Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50B14F98;
	Thu,  9 Jan 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433007; cv=none; b=WeCTIlB/3sQrK67z+j7No7iAa0e6aTDvmVLi6LmQBa8iJcpCerl6e8WjrH5sPEBKINZ3L6arTz8SkkS6YvYlDmkEVfOXRNTqO0MBbxdD62kEN5N/JCqZ/GECiMEz5CW6a/ApUGE3mkqQdhba3pTCtF3E2ixBKDauQG6xIVv0WUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433007; c=relaxed/simple;
	bh=biVgPS9plYMJvev1Yn1+TzTLjypNy5+48mL+at8CfnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWfTZRanmt8EFqwzi1a/iGJmZUNtwG/KY3ILU9ax6K3v0lQStYboMQpRQwifODF6Ev1Z32q5vkI+uH2VNB2+Z1jjPYW3F6n2J2PTUBjVQ5UALGeVgUcNma+yCtXWyET9TPL/gVCknQTfu6TTU/ywdnhkjg4NO9hoBifIWMOLKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAE4xM0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAE4xM0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD73C4CED2;
	Thu,  9 Jan 2025 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736433005;
	bh=biVgPS9plYMJvev1Yn1+TzTLjypNy5+48mL+at8CfnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAE4xM0acTlIaqXme/9fUg+vBBkDqKTqqwXdsSx4TiIyOxOlEXSeNNDROWoWdvSrD
	 Faa+E0xkfFwmhY+UuGeK1eVVPFab5f/JoZ70hS5LFBEsF9ctdZj4uuoUqL9zsw/pwG
	 LyAUUzOYDFu1MNaey91p4Gb92zl2Gx0xZnWYlKpzqRs7qwPk0xQbk6hrs27VLmoRf9
	 w1PUv4XejaZVWM2lfk+dhm1yNb+HWWkbIni4WXu9wFQjaQgXH052VZz6gx5MRNxCq0
	 IVrjxG6Tev3JboltxbZEYYZDXjIqcVSWPytggd7iIf4bgaEgYI02ueNAhXbIfme9Ln
	 2Q8g6FLqdXy3g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 3/5] tracing: Use __free() for kprobe events to cleanup
Date: Thu,  9 Jan 2025 23:29:59 +0900
Message-ID: <173643299989.1514810.2924926552980462072.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173643296599.1514810.1580554610685712071.stgit@devnote2>
References: <173643296599.1514810.1580554610685712071.stgit@devnote2>
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

Use __free() in trace_kprobe.c to cleanup code.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes in v4:
  - Use no_free_ptr(tk)->tp instead of assiging NULL to tk.
 Changes in v3:
  - Rename to __free(free_trace_kprobe) to clarify what function will be called.
  - Add !IS_ERR_OR_NULL() check because alloc_trace_kprobe() returns an error code.
  - Prevent freeing 'tk' in create_local_trace_kprobe() when succeeded to register.
 Changes in v2:
  - Instead of using no_free_ptr(), just assign NULL to the registered pointer.
---
 kernel/trace/trace_kprobe.c |   62 ++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fb9d4dffa66e..2d86ef88d36a 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)	"trace_kprobe: " fmt
 
 #include <linux/bpf-cgroup.h>
+#include <linux/cleanup.h>
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
@@ -257,6 +258,9 @@ static void free_trace_kprobe(struct trace_kprobe *tk)
 	}
 }
 
+DEFINE_FREE(free_trace_kprobe, struct trace_kprobe *,
+	if (!IS_ERR_OR_NULL(_T)) free_trace_kprobe(_T))
+
 /*
  * Allocate new trace_probe and initialize it (including kprobes).
  */
@@ -268,7 +272,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 					     int maxactive,
 					     int nargs, bool is_return)
 {
-	struct trace_kprobe *tk;
+	struct trace_kprobe *tk __free(free_trace_kprobe) = NULL;
 	int ret = -ENOMEM;
 
 	tk = kzalloc(struct_size(tk, tp.args, nargs), GFP_KERNEL);
@@ -277,12 +281,12 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 
 	tk->nhit = alloc_percpu(unsigned long);
 	if (!tk->nhit)
-		goto error;
+		return ERR_PTR(ret);
 
 	if (symbol) {
 		tk->symbol = kstrdup(symbol, GFP_KERNEL);
 		if (!tk->symbol)
-			goto error;
+			return ERR_PTR(ret);
 		tk->rp.kp.symbol_name = tk->symbol;
 		tk->rp.kp.offset = offs;
 	} else
@@ -299,13 +303,10 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 
 	ret = trace_probe_init(&tk->tp, event, group, false, nargs);
 	if (ret < 0)
-		goto error;
+		return ERR_PTR(ret);
 
 	dyn_event_init(&tk->devent, &trace_kprobe_ops);
-	return tk;
-error:
-	free_trace_kprobe(tk);
-	return ERR_PTR(ret);
+	return_ptr(tk);
 }
 
 static struct trace_kprobe *find_trace_kprobe(const char *event,
@@ -866,11 +867,12 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	 * Type of args:
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
-	struct trace_kprobe *tk = NULL;
+	struct trace_kprobe *tk __free(free_trace_kprobe) = NULL;
 	int i, len, new_argc = 0, ret = 0;
 	bool is_return = false;
-	char *symbol = NULL, *tmp = NULL;
-	const char **new_argv = NULL;
+	char *symbol __free(kfree) = NULL;
+	char *tmp = NULL;
+	const char **new_argv __free(kfree) = NULL;
 	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
 	enum probe_print_type ptype;
 	int maxactive = 0;
@@ -879,7 +881,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
-	char *dbuf = NULL;
+	char *dbuf __free(kfree) = NULL;
 	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
@@ -936,13 +938,13 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		/* Check whether uprobe event specified */
 		if (strchr(argv[1], '/') && strchr(argv[1], ':')) {
 			ret = -ECANCELED;
-			goto error;
+			goto out;
 		}
 		/* a symbol specified */
 		symbol = kstrdup(argv[1], GFP_KERNEL);
 		if (!symbol) {
 			ret = -ENOMEM;
-			goto error;
+			goto out;
 		}
 
 		tmp = strchr(symbol, '%');
@@ -1040,7 +1042,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		ctx.offset = 0;
 		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
 		if (ret)
-			goto error;	/* This can be -ENOMEM */
+			goto out;	/* This can be -ENOMEM */
 	}
 	/* entry handler for kretprobe */
 	if (is_return && tk->tp.entry_arg) {
@@ -1051,7 +1053,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	ptype = is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
 	ret = traceprobe_set_print_fmt(&tk->tp, ptype);
 	if (ret < 0)
-		goto error;
+		goto out;
 
 	ret = register_trace_kprobe(tk);
 	if (ret) {
@@ -1062,21 +1064,20 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 		else if (ret != -ENOMEM && ret != -EEXIST)
 			trace_probe_log_err(0, FAIL_REG_PROBE);
-		goto error;
-	}
+	} else
+		/*
+		 * Here, 'tk' has been registered to the list successfully,
+		 * so we don't need to free it.
+		 */
+		tk = NULL;
 
 out:
 	traceprobe_finish_parse(&ctx);
 	trace_probe_log_clear();
-	kfree(new_argv);
-	kfree(symbol);
-	kfree(dbuf);
 	return ret;
 
 parse_error:
 	ret = -EINVAL;
-error:
-	free_trace_kprobe(tk);
 	goto out;
 }
 
@@ -1898,7 +1899,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 			  bool is_return)
 {
 	enum probe_print_type ptype;
-	struct trace_kprobe *tk;
+	struct trace_kprobe *tk __free(free_trace_kprobe) = NULL;
 	int ret;
 	char *event;
 
@@ -1929,19 +1930,14 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 
 	ptype = trace_kprobe_is_return(tk) ?
 		PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
-	if (traceprobe_set_print_fmt(&tk->tp, ptype) < 0) {
-		ret = -ENOMEM;
-		goto error;
-	}
+	if (traceprobe_set_print_fmt(&tk->tp, ptype) < 0)
+		return ERR_PTR(-ENOMEM);
 
 	ret = __register_trace_kprobe(tk);
 	if (ret < 0)
-		goto error;
+		return ERR_PTR(ret);
 
-	return trace_probe_event_call(&tk->tp);
-error:
-	free_trace_kprobe(tk);
-	return ERR_PTR(ret);
+	return trace_probe_event_call(&(no_free_ptr(tk)->tp));
 }
 
 void destroy_local_trace_kprobe(struct trace_event_call *event_call)

