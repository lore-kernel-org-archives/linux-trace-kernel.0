Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F514136E09;
	Mon,  6 Jan 2025 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179435; cv=none; b=TckMMqj0H7rwnpWdYz3k6do1+5j3xahQZon5W9kkXqOB2+3st4+IU6DgeSUrVCPqRAvUoykOy4sXqbTDsacpFQrMmH6tHFeSjLNqXx3UqVZHKn6ULRStj+RGJZmQtvhPaGLj3tHw26ypAzRuJRTYsVYFyh7gn9USpLKF/3XYSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179435; c=relaxed/simple;
	bh=Gk3o75YMIw3xMzD/DKPLtj44OpiH8ST1bQqRWhJEOlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9MLxP+ladqcmhl1qMk5CXMlrCmumAsuMs17f1S/OF1WUJI/MrzUftGKh6YLxQuqjH6H3SkxJvkKx/Flo/FdyQtixC2BGDHyVgLwcqvQq0g1X9rFCP+Hkah8irPv2aV9A8xdNIRJ/W+aeNFHkbJ/EZWML6xAwVSyzH0VfLotbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWsr1VCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWsr1VCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5184C4CEE1;
	Mon,  6 Jan 2025 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736179435;
	bh=Gk3o75YMIw3xMzD/DKPLtj44OpiH8ST1bQqRWhJEOlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWsr1VCPWtszzFPscJEKrHgwi7/C0mABy9VwBaUOqS4SYEqB7NDtJugBtlT2dn4Lq
	 s5Sn0vsBVUttcXWs0ur5VGJXFoI/G5d1e6APBLR97/DZcsSUJL0af2zrZnHGdSzNR5
	 Y8ggEt35nGO0SAD/jIdzbb45RkflbsmnOX11jh7vGsD2GqNpeKLGT+SymFPgHLg5Uq
	 QFc3uzccgwSt/GUuNIXQvdV56sExB3QWp+wVBrsmToyy8I8TSYjimsfIBONpP+ZeUP
	 0VWRCC57X5di4RgyGrVs2BN4i/WSWdEsDbs8bKDhDSSVQHn+rVobjylH3EVf9jdBsb
	 izYGbReVYKUYg==
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
Subject: [PATCH v2 5/7] tracing: Use __free() for kprobe events to cleanup
Date: Tue,  7 Jan 2025 01:03:49 +0900
Message-ID: <173617942938.1366315.9259030204539374186.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173617937395.1366315.17590944219163017504.stgit@devnote2>
References: <173617937395.1366315.17590944219163017504.stgit@devnote2>
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
---
 Changes in v3:
  - Rename to __free(free_trace_kprobe) to clarify what function will be called.
  - Add !IS_ERR_OR_NULL() check because alloc_trace_kprobe() returns an error code.
  - Prevent freeing 'tk' in create_local_trace_kprobe() when succeeded to register.
 Changes in v2:
  - Instead of using no_free_ptr(), just assign NULL to the registered pointer.
---
 kernel/trace/trace_kprobe.c |   63 +++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 4c3e316454a0..6f58957ff616 100644
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
@@ -861,11 +862,12 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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
@@ -874,7 +876,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
-	char *dbuf = NULL;
+	char *dbuf __free(kfree) = NULL;
 	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
@@ -931,7 +933,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		/* Check whether uprobe event specified */
 		if (strchr(argv[1], '/') && strchr(argv[1], ':')) {
 			ret = -ECANCELED;
-			goto error;
+			goto out;
 		}
 		/* a symbol specified */
 		symbol = kstrdup(argv[1], GFP_KERNEL);
@@ -1035,7 +1037,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		ctx.offset = 0;
 		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
 		if (ret)
-			goto error;	/* This can be -ENOMEM */
+			goto out;	/* This can be -ENOMEM */
 	}
 	/* entry handler for kretprobe */
 	if (is_return && tk->tp.entry_arg) {
@@ -1046,7 +1048,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	ptype = is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
 	ret = traceprobe_set_print_fmt(&tk->tp, ptype);
 	if (ret < 0)
-		goto error;
+		goto out;
 
 	ret = register_trace_kprobe(tk);
 	if (ret) {
@@ -1057,21 +1059,20 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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
 
@@ -1893,7 +1894,8 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 			  bool is_return)
 {
 	enum probe_print_type ptype;
-	struct trace_kprobe *tk;
+	struct trace_kprobe *tk __free(free_trace_kprobe) = NULL;
+	struct trace_probe *tp;
 	int ret;
 	char *event;
 
@@ -1924,19 +1926,16 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 
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
+	tp = &tk->tp;
+	tk = NULL;	/* 'tk' is registered successfully, so do not free. */
+	return trace_probe_event_call(tp);
 }
 
 void destroy_local_trace_kprobe(struct trace_event_call *event_call)

