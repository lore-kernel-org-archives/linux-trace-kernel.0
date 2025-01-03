Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653DE1BEF73;
	Fri,  3 Jan 2025 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945346; cv=none; b=XS+2X8UYtj5mo4VSnU5jtSqRo1Z7aALnlmfDtCtU5f6HOqhyKRFJZqNLAAUUkGR+efosYboERm5plhp2BNfOkHiV3F73fyzcCNy2PgATvmGzJOoHvuhkaTHI7SODmxvBaJRRWdnn3iXT5uuu6gqOxXOfghi0TudBehwSjL14C8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945346; c=relaxed/simple;
	bh=x4kabNr8G2/lX849M4airJHXsAaRvHSFPtZzf267JBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmsvNH+xJzNVHE+IcPvddG27gD+jUY4jwKuavxttDPAEKkW6D2YSlCAFlJLLFccuPvzbYAZu4Qr09Wt99HeXDeC51ZyppAejogAg0gWXGuNa5SXqMi6HznxylWS83xhRvDBrnSPvOA/0MQ9Io5Lo6pFbc2widyB2I31zYkbSNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4IG9z6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4IG9z6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D4BC4CEDD;
	Fri,  3 Jan 2025 23:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735945346;
	bh=x4kabNr8G2/lX849M4airJHXsAaRvHSFPtZzf267JBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4IG9z6L/i4+iORu/LAyMgKFwr7megOyLHnF22ztY2E70BsxaCaWwD1lsUVxQH9wB
	 BT5NYvS9uvDQ5BlEdNqso4AghWB3tRfdzc4SZ7m+1uqdSD6k5NhRibyu7BPEc3Hycg
	 yyueyMGciqY+dmQPoz2gm0mLafcMbWabH/p/EFU/tEhwrZXBh+/uzB4vFCn8q9o7v/
	 3xbfK1Rae3pkpotIIO5vXpSAHuh0c0RegB7z2GPRCj2gH5g0Fq6tRy1R4jA7EzFFct
	 CR3K3pIU2IbaQ/oXofhCc6erWIAPPnYIa78i43z2vEfCj2uqIVzCIOWfceNUzCX0cR
	 XvgZ1AiqwEfaQ==
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
Subject: [PATCH 5/6] tracing: Use __free() for kprobe events to cleanup
Date: Sat,  4 Jan 2025 08:02:20 +0900
Message-ID: <173594534060.1055889.15132206436919221336.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173594528527.1055889.2175884987203674189.stgit@devnote2>
References: <173594528527.1055889.2175884987203674189.stgit@devnote2>
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
 kernel/trace/trace_kprobe.c |   53 ++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 4c3e316454a0..c5fd4471c137 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)	"trace_kprobe: " fmt
 
 #include <linux/bpf-cgroup.h>
+#include <linux/cleanup.h>
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
@@ -257,6 +258,8 @@ static void free_trace_kprobe(struct trace_kprobe *tk)
 	}
 }
 
+DEFINE_FREE(trace_kprobe, struct trace_kprobe *, free_trace_kprobe(_T))
+
 /*
  * Allocate new trace_probe and initialize it (including kprobes).
  */
@@ -268,7 +271,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 					     int maxactive,
 					     int nargs, bool is_return)
 {
-	struct trace_kprobe *tk;
+	struct trace_kprobe *tk __free(trace_kprobe) = NULL;
 	int ret = -ENOMEM;
 
 	tk = kzalloc(struct_size(tk, tp.args, nargs), GFP_KERNEL);
@@ -277,12 +280,12 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 
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
@@ -299,13 +302,10 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
 
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
@@ -861,11 +861,12 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	 * Type of args:
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
-	struct trace_kprobe *tk = NULL;
+	struct trace_kprobe *tk __free(trace_kprobe) = NULL;
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
@@ -874,7 +875,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
-	char *dbuf = NULL;
+	char *dbuf __free(kfree) = NULL;
 	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
@@ -931,7 +932,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		/* Check whether uprobe event specified */
 		if (strchr(argv[1], '/') && strchr(argv[1], ':')) {
 			ret = -ECANCELED;
-			goto error;
+			goto out;
 		}
 		/* a symbol specified */
 		symbol = kstrdup(argv[1], GFP_KERNEL);
@@ -1035,7 +1036,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		ctx.offset = 0;
 		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
 		if (ret)
-			goto error;	/* This can be -ENOMEM */
+			goto out;	/* This can be -ENOMEM */
 	}
 	/* entry handler for kretprobe */
 	if (is_return && tk->tp.entry_arg) {
@@ -1046,7 +1047,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	ptype = is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
 	ret = traceprobe_set_print_fmt(&tk->tp, ptype);
 	if (ret < 0)
-		goto error;
+		goto out;
 
 	ret = register_trace_kprobe(tk);
 	if (ret) {
@@ -1057,21 +1058,16 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 		else if (ret != -ENOMEM && ret != -EEXIST)
 			trace_probe_log_err(0, FAIL_REG_PROBE);
-		goto error;
-	}
+	} else
+		no_free_ptr(tk);
 
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
 
@@ -1893,7 +1889,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 			  bool is_return)
 {
 	enum probe_print_type ptype;
-	struct trace_kprobe *tk;
+	struct trace_kprobe *tk __free(trace_kprobe) = NULL;
 	int ret;
 	char *event;
 
@@ -1924,19 +1920,14 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 
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
 
 	return trace_probe_event_call(&tk->tp);
-error:
-	free_trace_kprobe(tk);
-	return ERR_PTR(ret);
 }
 
 void destroy_local_trace_kprobe(struct trace_event_call *event_call)

