Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC1218ADA;
	Thu,  9 Jan 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432995; cv=none; b=T7zBHDOWIOzQp5m94t2SzU9HaOw+tEs0Ny/hsiMt9ixL039Wner1YQJtgOC2B37Si3kX7hy1Cn1nbb2gFq+OW5Bx8phIVeZrNlSZb85Awi5+ezJWng3EuHhaPef98B8lCyCgakPBJjVPiT4p3OrOED8R3U7F2VfJRIlFQMQ+neg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432995; c=relaxed/simple;
	bh=XiX6J4fICj5ZQFV0TX0y3kCgIGbBrOM0Wv+n/GullO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HETR+z/um3wlbgrfnhrnm7QCEa5K2hIj0tn95FXj4iM92CUoBaaxM9gTzZDM3QHquvr79QuZhZ2GRFkc5aY7ZcbOGKE/ve7I5d3tXE/k7wwO7MwBPeFXwPjdviOyD00M/m66UZjTLRkudhbJY13XaipMpSLoUVvmOXlwU3UZmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgpyPY3D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgpyPY3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1CFC4CED2;
	Thu,  9 Jan 2025 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736432994;
	bh=XiX6J4fICj5ZQFV0TX0y3kCgIGbBrOM0Wv+n/GullO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgpyPY3Dox7fk+R4lLkTf6/7d6ZMze0E+D2ggxFfGOLoJj7EfGG6YrV53jhroahyJ
	 wcFL+9oL61KISRukyQGMBuvq2RSwZYVl9PDfy204O/OOYz9vevbXZ/h0zBqzd0GezZ
	 T+syV5kV/Uy2z+OOQW5cf+KRt9sSlyM3n8NOm2TMSJnT8LBOnsVVtW0Q3oETEul+Sa
	 XN63D7Vbx7hZnsq+t0T3Q+XdlKfFrINTcucimSAaM4/Tmq4doWca2mTXwfVkqJqU5M
	 BxOXbsvY4jd1RjOSe8IOgJIguoGb0fcEm51G8xq/qyE48H35eaaNr/r5yXmOcKT9Qv
	 BN2CeXkD0RvaA==
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
Subject: [PATCH v6 2/5] tracing: Use __free() in trace_probe for cleanup
Date: Thu,  9 Jan 2025 23:29:48 +0900
Message-ID: <173643298860.1514810.7267350121047606213.stgit@devnote2>
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

Use __free() in trace_probe to cleanup some gotos.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes in v5:
  - Fix to remove kfree() in for loop. Since I confirmed __free(kfree) is
    called in each iteration.
---
 kernel/trace/trace_probe.c |   51 +++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 16a5e368e7b7..8f58ee1e8858 100644
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
@@ -1790,18 +1777,14 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
 				       offsetof(struct file, f_path.dentry),
 				       equal ? equal + 1 : tmp);
 
-		kfree(tmp);
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

