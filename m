Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BD19F424;
	Wed, 13 Aug 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095409; cv=none; b=qMQ7R5Nx2bTlzJ3YOQ2NbMZmvn104Kh7x1DlOZonqe3klO0sBZENINKW0IQDrd/7wJtSfMhNOzKChnCEITTYPaHDPy+9pC6PrEhA2nT+RXo4vnkm720X7rDZcAZHCa3OFQw6AYDFPKdk5pOOXh1f5B+HEaz6jpxc5iRbo/Jgiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095409; c=relaxed/simple;
	bh=f7YCp6FEN6d54fq27DFGuyBRZqienKDzQ2bRuqKKHYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMv/YVZI6GkhV9z3s2cCzthvIZliFLYlZXOeImkxgm4P5QPrNUDAVTsbnIe7tNil9yRqhT9p0gEhn+bkEq6LtRnQYjgx45yScqNORmv1rWW8eU+XS7Eu9HTt5Dq8rvghQMhkslPVmq10VwwO+zfOGgFnaTb/9FtkSUByJ+/r93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSb3yT/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSb3yT/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AB5C4CEEB;
	Wed, 13 Aug 2025 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095408;
	bh=f7YCp6FEN6d54fq27DFGuyBRZqienKDzQ2bRuqKKHYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSb3yT/SOsJYhTeVzx015sM1oaPTV93Eg5KzPRMYFpG5L3aOAVwIgwiRjJKQSYwYf
	 YcMT362zqh7dh4wUbMUmJOPNu5rET8o3jFmr5ha+eHkmkh3MIH1BMYuWKHNDJAfmxj
	 LYu9ZdDyBwfnPIPvDaeJQ60OO37WXgHLwpktjvEyl1VfkGzm9oS0RPw5eeQP77p5j/
	 sMhX7vi1eN8C8Oof3gaTYVJX9OgQ62RcIqg7O1erQ9T4pAJlmbkqhj5ApmSSxIig3e
	 Du8jvv0PUEyr4mUXDc5TK7sIQJGE0Ea/P/pfwBcq8UPF1ZHAh1/CIOeH1V5yvZNfW6
	 iQS6FGs3DXu5g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/4] tracing: uprobes: Cleanup __trace_uprobe_create() with __free()
Date: Wed, 13 Aug 2025 23:30:04 +0900
Message-ID: <175509540482.193596.6541098946023873304.stgit@devnote2>
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

Use __free() to cleanup ugly gotos in __trace_uprobe_create().

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_uprobe.c |   68 ++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 722316b3dc16..9c628dab3dc6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -533,22 +533,25 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	return ret;
 }
 
+DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (_T) free_trace_uprobe(_T))
+
 /*
  * Argument syntax:
  *  - Add uprobe: p|r[:[GRP/][EVENT]] PATH:OFFSET[%return][(REF)] [FETCHARGS]
  */
 static int __trace_uprobe_create(int argc, const char **argv)
 {
+	struct trace_uprobe *tu __free(free_trace_uprobe) = NULL;
 	const char *trlog __free(trace_probe_log_clear) = NULL;
 	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
-	char *arg, *filename, *rctr, *rctr_end, *tmp;
+	struct path path __free(path_put) = {};
 	unsigned long offset, ref_ctr_offset;
+	char *filename __free(kfree) = NULL;
+	char *arg, *rctr, *rctr_end, *tmp;
 	char *gbuf __free(kfree) = NULL;
 	char *buf __free(kfree) = NULL;
 	enum probe_print_type ptype;
-	struct trace_uprobe *tu;
 	bool is_return = false;
-	struct path path;
 	int i, ret;
 
 	ref_ctr_offset = 0;
@@ -586,10 +589,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	/* Find the last occurrence, in case the path contains ':' too. */
 	arg = strrchr(filename, ':');
-	if (!arg || !isdigit(arg[1])) {
-		kfree(filename);
+	if (!arg || !isdigit(arg[1]))
 		return -ECANCELED;
-	}
 
 	trace_probe_log_set_index(1);	/* filename is the 2nd argument */
 
@@ -597,13 +598,11 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (ret) {
 		trace_probe_log_err(0, FILE_NOT_FOUND);
-		kfree(filename);
 		return ret;
 	}
 	if (!d_is_reg(path.dentry)) {
 		trace_probe_log_err(0, NO_REGULAR_FILE);
-		ret = -EINVAL;
-		goto fail_address_parse;
+		return -EINVAL;
 	}
 
 	/* Parse reference counter offset if specified. */
@@ -611,16 +610,14 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	if (rctr) {
 		rctr_end = strchr(rctr, ')');
 		if (!rctr_end) {
-			ret = -EINVAL;
 			rctr_end = rctr + strlen(rctr);
 			trace_probe_log_err(rctr_end - filename,
 					    REFCNT_OPEN_BRACE);
-			goto fail_address_parse;
+			return -EINVAL;
 		} else if (rctr_end[1] != '\0') {
-			ret = -EINVAL;
 			trace_probe_log_err(rctr_end + 1 - filename,
 					    BAD_REFCNT_SUFFIX);
-			goto fail_address_parse;
+			return -EINVAL;
 		}
 
 		*rctr++ = '\0';
@@ -628,7 +625,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		ret = kstrtoul(rctr, 0, &ref_ctr_offset);
 		if (ret) {
 			trace_probe_log_err(rctr - filename, BAD_REFCNT);
-			goto fail_address_parse;
+			return ret;
 		}
 	}
 
@@ -640,8 +637,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 			is_return = true;
 		} else {
 			trace_probe_log_err(tmp - filename, BAD_ADDR_SUFFIX);
-			ret = -EINVAL;
-			goto fail_address_parse;
+			return -EINVAL;
 		}
 	}
 
@@ -649,7 +645,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	ret = kstrtoul(arg, 0, &offset);
 	if (ret) {
 		trace_probe_log_err(arg - filename, BAD_UPROBE_OFFS);
-		goto fail_address_parse;
+		return ret;
 	}
 
 	/* setup a probe */
@@ -657,12 +653,12 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	if (event) {
 		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
 		if (!gbuf)
-			goto fail_mem;
+			return -ENOMEM;
 
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
-			goto fail_address_parse;
+			return ret;
 	}
 
 	if (!event) {
@@ -671,7 +667,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 		tail = kstrdup(kbasename(filename), GFP_KERNEL);
 		if (!tail)
-			goto fail_mem;
+			return -ENOMEM;
 
 		ptr = strpbrk(tail, ".-_");
 		if (ptr)
@@ -679,7 +675,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 		buf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
 		if (!buf)
-			goto fail_mem;
+			return -ENOMEM;
 		snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_0x%lx", 'p', tail, offset);
 		event = buf;
 		kfree(tail);
@@ -693,49 +689,37 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		ret = PTR_ERR(tu);
 		/* This must return -ENOMEM otherwise there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM);
-		goto fail_address_parse;
+		return ret;
 	}
 	tu->offset = offset;
 	tu->ref_ctr_offset = ref_ctr_offset;
 	tu->path = path;
-	tu->filename = filename;
+	/* Clear @path so that it will not freed by path_put() */
+	memset(&path, 0, sizeof(path));
+	tu->filename = no_free_ptr(filename);
 
 	/* parse arguments */
 	for (i = 0; i < argc; i++) {
 		struct traceprobe_parse_context *ctx __free(traceprobe_parse_context)
 			= kzalloc(sizeof(*ctx), GFP_KERNEL);
 
-		if (!ctx) {
-			ret = -ENOMEM;
-			goto error;
-		}
+		if (!ctx)
+			return -ENOMEM;
 		ctx->flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER;
 		trace_probe_log_set_index(i + 2);
 		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i], ctx);
 		if (ret)
-			goto error;
+			return ret;
 	}
 
 	ptype = is_ret_probe(tu) ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
 	ret = traceprobe_set_print_fmt(&tu->tp, ptype);
 	if (ret < 0)
-		goto error;
+		return ret;
 
 	ret = register_trace_uprobe(tu);
 	if (!ret)
-		goto out;
-
-error:
-	free_trace_uprobe(tu);
-out:
-	return ret;
-
-fail_mem:
-	ret = -ENOMEM;
-
-fail_address_parse:
-	path_put(&path);
-	kfree(filename);
+		tu = NULL;
 
 	return ret;
 }

