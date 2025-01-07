Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045281E379F;
	Tue,  7 Jan 2025 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250653; cv=none; b=Gi5gC8TNhrCFg1vwHwGI6lMWlcotnS5igo0Sqkpj50/TtVjReyM+afuRlO/0j+fd3aJ4EuI6akF+/X+Yx7Yp15l93+wmWPfsTFUscw3zynoU12xqnPxc5RlwbK5ocz/5CZBXZxgLRfFKtCqMTSMHtnDDlgGyvyvsxEUjRzAZe8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250653; c=relaxed/simple;
	bh=oz75zD4hz8TVndlevnw8+K50k+0vYc6T0yklKGuI40g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m50f0Kya6T2bCHIvQugHYcfjNRbotUi2rs3DW+NUA5lj/Qlj7NW2+EA3U3bGPd7J41c9AZn16LuGBk81SUB4eFGmqq3tdW0fgZWsdPzvvhdezYh48x9eTXQr90mkZS3sfSdCCQ0tbzsB5FEDM3aqFsow7HQYSaMobKqSqRiv870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkGu2ro8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkGu2ro8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFF6C4CED6;
	Tue,  7 Jan 2025 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250652;
	bh=oz75zD4hz8TVndlevnw8+K50k+0vYc6T0yklKGuI40g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkGu2ro89exC5pa9GZOxD3cgw80S2LW7nBfk7BHpKajgBtX9swz3ZrCCgQx3EqB+5
	 5YCfoBFieetNOGVRSc4qUgreOnJke31pnwjKlHdlQUYckEwH/T9m9RN4nkFnOAQsX/
	 XA7neyJIAe9rTptnFNDHDQt0swSN7G96KIb2iVMkAf1xHKmrJXk+cxKvdOt7rSUc7k
	 jDtLUS+n2rVekO1PO0YzVEbx0aF9z6V+zItxNhcUkn8avzaVVwCpws4aSDxZuDROI+
	 LQMsgaX8dFyutIm03lo3RRw/+7EKbIMoG8bvqVBMSEt6CFhSenJFme2rYLCpvAfy+D
	 O4mjhYB46tW3w==
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
Subject: [PATCH v3 4/5] tracing/kprobes: Simplify __trace_kprobe_create() by removing gotos
Date: Tue,  7 Jan 2025 20:50:46 +0900
Message-ID: <173625064678.1375434.12268197997262287477.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173625060316.1375434.11048027439794595989.stgit@devnote2>
References: <173625060316.1375434.11048027439794595989.stgit@devnote2>
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

Simplify __trace_kprobe_create() by removing gotos.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   82 ++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 2d8b5ef47e96..f487473cf255 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -841,7 +841,8 @@ static int validate_probe_symbol(char *symbol)
 static int trace_kprobe_entry_handler(struct kretprobe_instance *ri,
 				      struct pt_regs *regs);
 
-static int __trace_kprobe_create(int argc, const char *argv[])
+static int ___trace_kprobe_create(int argc, const char *argv[],
+				  struct traceprobe_parse_context *ctx)
 {
 	/*
 	 * Argument syntax:
@@ -882,7 +883,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
 	char *dbuf __free(kfree) = NULL;
-	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
 	case 'r':
@@ -896,8 +896,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	if (argc < 2)
 		return -ECANCELED;
 
-	trace_probe_log_init("trace_kprobe", argc, argv);
-
 	event = strchr(&argv[0][1], ':');
 	if (event)
 		event++;
@@ -905,7 +903,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	if (isdigit(argv[0][1])) {
 		if (!is_return) {
 			trace_probe_log_err(1, BAD_MAXACT_TYPE);
-			goto parse_error;
+			return -EINVAL;
 		}
 		if (event)
 			len = event - &argv[0][1] - 1;
@@ -913,21 +911,21 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 			len = strlen(&argv[0][1]);
 		if (len > MAX_EVENT_NAME_LEN - 1) {
 			trace_probe_log_err(1, BAD_MAXACT);
-			goto parse_error;
+			return -EINVAL;
 		}
 		memcpy(buf, &argv[0][1], len);
 		buf[len] = '\0';
 		ret = kstrtouint(buf, 0, &maxactive);
 		if (ret || !maxactive) {
 			trace_probe_log_err(1, BAD_MAXACT);
-			goto parse_error;
+			return -EINVAL;
 		}
 		/* kretprobes instances are iterated over via a list. The
 		 * maximum should stay reasonable.
 		 */
 		if (maxactive > KRETPROBE_MAXACTIVE_MAX) {
 			trace_probe_log_err(1, MAXACT_TOO_BIG);
-			goto parse_error;
+			return -EINVAL;
 		}
 	}
 
@@ -936,16 +934,13 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	if (kstrtoul(argv[1], 0, (unsigned long *)&addr)) {
 		trace_probe_log_set_index(1);
 		/* Check whether uprobe event specified */
-		if (strchr(argv[1], '/') && strchr(argv[1], ':')) {
-			ret = -ECANCELED;
-			goto out;
-		}
+		if (strchr(argv[1], '/') && strchr(argv[1], ':'))
+			return -ECANCELED;
+
 		/* a symbol specified */
 		symbol = kstrdup(argv[1], GFP_KERNEL);
-		if (!symbol) {
-			ret = -ENOMEM;
-			goto error;
-		}
+		if (!symbol)
+			return -ENOMEM;
 
 		tmp = strchr(symbol, '%');
 		if (tmp) {
@@ -954,7 +949,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 				is_return = true;
 			} else {
 				trace_probe_log_err(tmp - symbol, BAD_ADDR_SUFFIX);
-				goto parse_error;
+				return -EINVAL;
 			}
 		}
 
@@ -962,7 +957,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
 		if (ret || offset < 0 || offset > UINT_MAX) {
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
-			goto parse_error;
+			return -EINVAL;
 		}
 		ret = validate_probe_symbol(symbol);
 		if (ret) {
@@ -970,17 +965,17 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 				trace_probe_log_err(0, NON_UNIQ_SYMBOL);
 			else
 				trace_probe_log_err(0, BAD_PROBE_ADDR);
-			goto parse_error;
+			return -EINVAL;
 		}
 		if (is_return)
-			ctx.flags |= TPARG_FL_RETURN;
+			ctx->flags |= TPARG_FL_RETURN;
 		ret = kprobe_on_func_entry(NULL, symbol, offset);
 		if (ret == 0 && !is_return)
-			ctx.flags |= TPARG_FL_FENTRY;
+			ctx->flags |= TPARG_FL_FENTRY;
 		/* Defer the ENOENT case until register kprobe */
 		if (ret == -EINVAL && is_return) {
 			trace_probe_log_err(0, BAD_RETPROBE);
-			goto parse_error;
+			return -EINVAL;
 		}
 	}
 
@@ -989,7 +984,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
-			goto parse_error;
+			return ret;
 	}
 
 	if (!event) {
@@ -1005,26 +1000,24 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	}
 
 	argc -= 2; argv += 2;
-	ctx.funcname = symbol;
+	ctx->funcname = symbol;
 	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,
-					       abuf, MAX_BTF_ARGS_LEN, &ctx);
+					       abuf, MAX_BTF_ARGS_LEN, ctx);
 	if (IS_ERR(new_argv)) {
 		ret = PTR_ERR(new_argv);
 		new_argv = NULL;
-		goto out;
+		return ret;
 	}
 	if (new_argv) {
 		argc = new_argc;
 		argv = new_argv;
 	}
-	if (argc > MAX_TRACE_ARGS) {
-		ret = -E2BIG;
-		goto out;
-	}
+	if (argc > MAX_TRACE_ARGS)
+		return -E2BIG;
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* setup a probe */
 	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
@@ -1033,16 +1026,16 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		ret = PTR_ERR(tk);
 		/* This must return -ENOMEM, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM);
-		goto out;	/* We know tk is not allocated */
+		return ret;	/* We know tk is not allocated */
 	}
 
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
-		ctx.offset = 0;
-		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
+		ctx->offset = 0;
+		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], ctx);
 		if (ret)
-			goto out;	/* This can be -ENOMEM */
+			return ret;	/* This can be -ENOMEM */
 	}
 	/* entry handler for kretprobe */
 	if (is_return && tk->tp.entry_arg) {
@@ -1053,7 +1046,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	ptype = is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
 	ret = traceprobe_set_print_fmt(&tk->tp, ptype);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = register_trace_kprobe(tk);
 	if (ret) {
@@ -1071,14 +1064,21 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		 */
 		tk = NULL;
 
-out:
+	return ret;
+}
+
+static int __trace_kprobe_create(int argc, const char *argv[])
+{
+	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
+	int ret;
+
+	trace_probe_log_init("trace_kprobe", argc, argv);
+
+	ret = ___trace_kprobe_create(argc, argv, &ctx);
+
 	traceprobe_finish_parse(&ctx);
 	trace_probe_log_clear();
 	return ret;
-
-parse_error:
-	ret = -EINVAL;
-	goto out;
 }
 
 static int trace_kprobe_create(const char *raw_command)

