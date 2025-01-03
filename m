Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29A1BD9D3;
	Fri,  3 Jan 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945335; cv=none; b=Zy9EPWlA+yyseYZk10rE4i3TeGq/p4x716ePgmyaPNJ/JhLfEZIfDQo0YgU6uMUQamL5wTXLh39v7KKFzFoX6Hx/KIsOduRirnDiHXNse8cCFPVFcCS9oLafQ0VKWoDbw2vYjDOrGonjvQ6kXp+bwQDrEYDm8xSZE83RwLF/YR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945335; c=relaxed/simple;
	bh=BcADqpQVIfcOvYJDWh5fJTXzfcEJmhMIEhtchptg8lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zqj4q7nBsyctFmbyHQ8PoJfLVbUp9Do4ACM8RUq11U12enzo6ictffexg8fE8ojUaX9LpRngPM8Dj1kfwvcqeRy/CkJs1CIdsETZsjL1YlDP+v7LeKM/lyMQjXeH+ADLvU2iHSwftEE5T2YFeP22bqC4S3tTzExDkfKsTb1O6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzQQLuBk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzQQLuBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF7EC4CEDD;
	Fri,  3 Jan 2025 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735945335;
	bh=BcADqpQVIfcOvYJDWh5fJTXzfcEJmhMIEhtchptg8lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzQQLuBkgiU/de/kjZ2FpLpZNt8jwaHdqxyGQPlBgAYvRqqNuCqUsWC5N6UJclBo8
	 dMydqQu2Trx4K5rFiure9OoQGtNsCizZrL80Z7Jfhe6/L8/o83eHrzXZbz6NX2OyrC
	 2BtELKVqAr3ioqm90m0KPn/0GKBNAJH4l2gwb3mgldSNH4vJERWOUMCEeG89DMoAAL
	 vuswtrpHaXQejswmOhTyZfzktN4pHUEY2b7m19eDokqW2NhQVC5eH80hSuLaRju0Eg
	 ZtxAgaL+9MNeAl7YLwbz01gf/PKjPdsrdKOU+UtlCg1LxGLhLDUQ2jZ0C2cRDH16CT
	 VtlxpPGxGzeSw==
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
Subject: [PATCH 4/6] tracing: Use __free() in trace_probe for cleanup
Date: Sat,  4 Jan 2025 08:02:09 +0900
Message-ID: <173594532943.1055889.15559781281734742703.stgit@devnote2>
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

Use __free() in trace_probe to cleanup some gotos.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   52 +++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 16a5e368e7b7..bf6a7b81ae95 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1409,7 +1409,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 					   struct traceprobe_parse_context *ctx)
 {
 	struct fetch_insn *code, *tmp = NULL;
-	char *type, *arg;
+	char *type, *arg __free(kfree) = NULL;
 	int ret, len;
 
 	len = strlen(argv);
@@ -1426,22 +1426,16 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		return -ENOMEM;
 
 	parg->comm = kstrdup(arg, GFP_KERNEL);
-	if (!parg->comm) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!parg->comm)
+		return -ENOMEM;
 
 	type = parse_probe_arg_type(arg, parg, ctx);
-	if (IS_ERR(type)) {
-		ret = PTR_ERR(type);
-		goto out;
-	}
+	if (IS_ERR(type))
+		return PTR_ERR(type);
 
 	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
-	if (!code) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!code)
+		return -ENOMEM;
 	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
 
 	ctx->last_type = NULL;
@@ -1497,8 +1491,6 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 				kfree(code->data);
 	}
 	kfree(tmp);
-out:
-	kfree(arg);
 
 	return ret;
 }
@@ -1668,7 +1660,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 {
 	const struct btf_param *params = NULL;
 	int i, j, n, used, ret, args_idx = -1;
-	const char **new_argv = NULL;
+	const char **new_argv __free(kfree) = NULL;
 
 	ret = argv_has_var_arg(argc, argv, &args_idx, ctx);
 	if (ret < 0)
@@ -1707,7 +1699,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 				ret = sprint_nth_btf_arg(n, "", buf + used,
 							 bufsize - used, ctx);
 				if (ret < 0)
-					goto error;
+					return ERR_PTR(ret);
 
 				new_argv[j++] = buf + used;
 				used += ret + 1;
@@ -1721,25 +1713,20 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 			n = simple_strtoul(argv[i] + 4, &type, 10);
 			if (type && !(*type == ':' || *type == '\0')) {
 				trace_probe_log_err(0, BAD_VAR);
-				ret = -ENOENT;
-				goto error;
+				return ERR_PTR(-ENOENT);
 			}
 			/* Note: $argN starts from $arg1 */
 			ret = sprint_nth_btf_arg(n - 1, type, buf + used,
 						 bufsize - used, ctx);
 			if (ret < 0)
-				goto error;
+				return ERR_PTR(ret);
 			new_argv[j++] = buf + used;
 			used += ret + 1;
 		} else
 			new_argv[j++] = argv[i];
 	}
 
-	return new_argv;
-
-error:
-	kfree(new_argv);
-	return ERR_PTR(ret);
+	return_ptr(new_argv);
 }
 
 /* @buf: *buf must be equal to NULL. Caller must to free *buf */
@@ -1747,14 +1734,14 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
 {
 	int i, used, ret;
 	const int bufsize = MAX_DENTRY_ARGS_LEN;
-	char *tmpbuf = NULL;
+	char *tmpbuf __free(kfree) = NULL;
 
 	if (*buf)
 		return -EINVAL;
 
 	used = 0;
 	for (i = 0; i < argc; i++) {
-		char *tmp;
+		char *tmp __free(kfree) = NULL;
 		char *equal;
 		size_t arg_len;
 
@@ -1769,7 +1756,7 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
 
 		tmp = kstrdup(argv[i], GFP_KERNEL);
 		if (!tmp)
-			goto nomem;
+			return -ENOMEM;
 
 		equal = strchr(tmp, '=');
 		if (equal)
@@ -1790,18 +1777,15 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
 				       offsetof(struct file, f_path.dentry),
 				       equal ? equal + 1 : tmp);
 
-		kfree(tmp);
+		kfree(no_free_ptr(tmp));
 		if (ret >= bufsize - used)
-			goto nomem;
+			return -ENOMEM;
 		argv[i] = tmpbuf + used;
 		used += ret + 1;
 	}
 
-	*buf = tmpbuf;
+	*buf = no_free_ptr(tmpbuf);
 	return 0;
-nomem:
-	kfree(tmpbuf);
-	return -ENOMEM;
 }
 
 void traceprobe_finish_parse(struct traceprobe_parse_context *ctx)

