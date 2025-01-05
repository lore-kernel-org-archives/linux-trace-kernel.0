Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697314D2A7;
	Sun,  5 Jan 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081326; cv=none; b=PcuKa/kVUlF6TcNs401wug8m/2wJtH4uxsG10Ns/Jbci8yEzNRTfpCfXVEmEjkNs3BhVMApI6MYooiD7+dswlxL64XYCn/TdDRLwHpNF5N7K8knGSIC9S4CWL7k16sJ6TbkjuKCvK5ki+hZFt+M2QMJLXgVAHsXUzeLjT2NFrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081326; c=relaxed/simple;
	bh=cUk0FGMod4R3TPo7w6+8KT52zO+2JcZZNj1drC22v3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nr7iTFiDl0jCJ35SS03yfRCoMvLjgBPH69ArgTj32kEMqfyC+hz4C94UIKTerI87OqPLVMAaOqpRpbrG8sjz19JXmgZ2p27LnJ1A71ZdJWERJl+hpRyJk0rGL49V5pFqdpEVntNnGYU3a9Sp24J9VC7I3XT8atz38ylaadWo3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWjyr3Wu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWjyr3Wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB95C4CEE0;
	Sun,  5 Jan 2025 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736081326;
	bh=cUk0FGMod4R3TPo7w6+8KT52zO+2JcZZNj1drC22v3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWjyr3Wu5mq8zOqM3qHUHRJFg22MO5e4N5+vecfsl9uJ1KDJNC+hvo6EmwxLcuYnS
	 d9fIBrd5Tn17pkBV8rnc6ogru1Wn8rzEk3zm+gQK1waCMJZdAGZ9DHChOVkCj83z/k
	 ElGp1AoKCvF5MWm+1avki/TaAlZ92q+GgOzXay7EhvjSpre3/sI85okZuCYP7yHlla
	 4VWMOCLU/X1dCWgZOTjVGLOgt0/MxCOBsQlztSzLGX51U7U/E8I36nNbmi1AH1Jpjo
	 Joe283+aGIdfqSCeLPyNhr93xLlyoMDR2cUrnEbW61fNLlkQbKDrXXhInbNjpeySQK
	 kFnw8jr3ryu7Q==
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
Subject: [PATCH v2 6/6] tracing/kprobes: Simplify __trace_kprobe_create() by removing gotos
Date: Sun,  5 Jan 2025 21:48:40 +0900
Message-ID: <173608132061.1253657.12688788891506602137.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173608125422.1253657.3732758016133408588.stgit@devnote2>
References: <173608125422.1253657.3732758016133408588.stgit@devnote2>
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
index e1ae65f57bf9..b5c59c0f83cb 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -835,7 +835,8 @@ static int validate_probe_symbol(char *symbol)
 static int trace_kprobe_entry_handler(struct kretprobe_instance *ri,
 				      struct pt_regs *regs);
 
-static int __trace_kprobe_create(int argc, const char *argv[])
+static int ___trace_kprobe_create(int argc, const char *argv[],
+				  struct traceprobe_parse_context *ctx)
 {
 	/*
 	 * Argument syntax:
@@ -876,7 +877,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char abuf[MAX_BTF_ARGS_LEN];
 	char *dbuf __free(kfree) = NULL;
-	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
 
 	switch (argv[0][0]) {
 	case 'r':
@@ -890,8 +890,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	if (argc < 2)
 		return -ECANCELED;
 
-	trace_probe_log_init("trace_kprobe", argc, argv);
-
 	event = strchr(&argv[0][1], ':');
 	if (event)
 		event++;
@@ -899,7 +897,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	if (isdigit(argv[0][1])) {
 		if (!is_return) {
 			trace_probe_log_err(1, BAD_MAXACT_TYPE);
-			goto parse_error;
+			return -EINVAL;
 		}
 		if (event)
 			len = event - &argv[0][1] - 1;
@@ -907,21 +905,21 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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
 
@@ -930,16 +928,13 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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
@@ -948,7 +943,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 				is_return = true;
 			} else {
 				trace_probe_log_err(tmp - symbol, BAD_ADDR_SUFFIX);
-				goto parse_error;
+				return -EINVAL;
 			}
 		}
 
@@ -956,7 +951,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
 		if (ret || offset < 0 || offset > UINT_MAX) {
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
-			goto parse_error;
+			return -EINVAL;
 		}
 		ret = validate_probe_symbol(symbol);
 		if (ret) {
@@ -964,17 +959,17 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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
 
@@ -983,7 +978,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
-			goto parse_error;
+			return ret;
 	}
 
 	if (!event) {
@@ -999,26 +994,24 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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
@@ -1027,16 +1020,16 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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
@@ -1047,7 +1040,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	ptype = is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
 	ret = traceprobe_set_print_fmt(&tk->tp, ptype);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = register_trace_kprobe(tk);
 	if (ret) {
@@ -1065,14 +1058,21 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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

