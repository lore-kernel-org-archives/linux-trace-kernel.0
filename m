Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96602EACF6;
	Wed, 13 Aug 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095390; cv=none; b=ayQvnMRX7V/n/BxfjzEld3BpNgZx9UVmGGgDxG+oqmJ+sHZd/aqTmTYJMfmk07GvACGFxI0FR2xV3UbzU2vXn0GIBLJsgLViSLc+vf/fmGc5JU3tXW9Ln5gsR10Kr/0bNXLaou/4WPoWd+lQTLtoPUyqOqB2mWZ7bzjHIL09W+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095390; c=relaxed/simple;
	bh=KtZOOoU0yNnyX0bs6ukfbHdLNrul7k2oPOAIlTcgzIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFOLq6r1Hc8zNvyJtZIMjREbFxsBIryJ5tKPlJrbPWDQCrO8Wyw7sDXIbKWQv7dTPVb/vop4rLNgQkyigEKLr9Dtazlo9dOthEAwZZwTAge8YriAI3eoVMKkfWO0uF5Fr2zp7N3czI3lwtzDEGvnnq9D+7a+r3OG2UzX6qGgkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I42ZjTtD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I42ZjTtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A69C4CEEB;
	Wed, 13 Aug 2025 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095390;
	bh=KtZOOoU0yNnyX0bs6ukfbHdLNrul7k2oPOAIlTcgzIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I42ZjTtDRVKB7SR84WgEp8XT6HIJQL4anw4JwP0t+l/3IziYJzavo9naZih5tXXoC
	 ky+ddu/ybGgdO24l7/Yo6pgerlVFIUBzL12VgdfwL0fB7Yq0VyZWqlVf69OnSJF2hU
	 oPx8OiLeadZNQIX5DCqhE82745ViYqi82srPpKyyk6xPdrBwt8JZ/U9B9TxSAfXVSL
	 7L4RwlutX0XiQPMDitHAs6iysSkT7UYCAPNvmYNnVycmArkZLfmBE5haPDlDtucEd/
	 WwJsZxAAw4hLDEmSqqmJAU0gJLPH5bY153Zf49igwOcTQYSH4/JwolofCu7v9pLeOd
	 ZnsXDlC1mNl8w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/4] tracing: probes: Use __free() for trace_probe_log
Date: Wed, 13 Aug 2025 23:29:46 +0900
Message-ID: <175509538609.193596.16646724647358218778.stgit@devnote2>
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

Use __free() for trace_probe_log_clear() to cleanup error log interface.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    5 ++---
 kernel/trace/trace_probe.c  |    3 ++-
 kernel/trace/trace_probe.h  |    4 +++-
 kernel/trace/trace_uprobe.c |    6 ++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index a1d402124836..aaba765d54cf 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -874,6 +874,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	 * Fetch args (no space):
 	 *  <name>=$<field>[:TYPE]
 	 */
+	const char *trlog __free(trace_probe_log_clear) = NULL;
 	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
 	const char *sys_event = NULL, *sys_name = NULL;
 	struct trace_event_call *event_call;
@@ -887,7 +888,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	if (argc < 2 || argv[0][0] != 'e')
 		return -ECANCELED;
 
-	trace_probe_log_init("event_probe", argc, argv);
+	trlog = trace_probe_log_init("event_probe", argc, argv);
 
 	event = strchr(&argv[0][1], ':');
 	if (event) {
@@ -987,7 +988,6 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 			goto error;
 		}
 	}
-	trace_probe_log_clear();
 	return ret;
 
 mem_error:
@@ -996,7 +996,6 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 parse_error:
 	ret = -EINVAL;
 error:
-	trace_probe_log_clear();
 	trace_event_probe_cleanup(ep);
 	return ret;
 }
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 5cbdc423afeb..5b92376a58fc 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -156,7 +156,7 @@ static const struct fetch_type *find_fetch_type(const char *type, unsigned long
 static struct trace_probe_log trace_probe_log;
 extern struct mutex dyn_event_ops_mutex;
 
-void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
+const char *trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 {
 	lockdep_assert_held(&dyn_event_ops_mutex);
 
@@ -164,6 +164,7 @@ void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 	trace_probe_log.argc = argc;
 	trace_probe_log.argv = argv;
 	trace_probe_log.index = 0;
+	return subsystem;
 }
 
 void trace_probe_log_clear(void)
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 842383fbc03b..76bf2dee8071 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -573,11 +573,13 @@ struct trace_probe_log {
 	int		index;
 };
 
-void trace_probe_log_init(const char *subsystem, int argc, const char **argv);
+const char *trace_probe_log_init(const char *subsystem, int argc, const char **argv);
 void trace_probe_log_set_index(int index);
 void trace_probe_log_clear(void);
 void __trace_probe_log_err(int offset, int err);
 
+DEFINE_FREE(trace_probe_log_clear, const char *, if (_T) trace_probe_log_clear())
+
 #define trace_probe_log_err(offs, err)	\
 	__trace_probe_log_err(offs, TP_ERR_##err)
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8b0bcc0d8f41..722316b3dc16 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -539,6 +539,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
  */
 static int __trace_uprobe_create(int argc, const char **argv)
 {
+	const char *trlog __free(trace_probe_log_clear) = NULL;
 	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
 	char *arg, *filename, *rctr, *rctr_end, *tmp;
 	unsigned long offset, ref_ctr_offset;
@@ -565,7 +566,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	if (argc < 2)
 		return -ECANCELED;
 
-	trace_probe_log_init("trace_uprobe", argc, argv);
+	trlog = trace_probe_log_init("trace_uprobe", argc, argv);
 
 	if (argc - 2 > MAX_TRACE_ARGS) {
 		trace_probe_log_set_index(2);
@@ -597,7 +598,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	if (ret) {
 		trace_probe_log_err(0, FILE_NOT_FOUND);
 		kfree(filename);
-		trace_probe_log_clear();
 		return ret;
 	}
 	if (!d_is_reg(path.dentry)) {
@@ -728,14 +728,12 @@ static int __trace_uprobe_create(int argc, const char **argv)
 error:
 	free_trace_uprobe(tu);
 out:
-	trace_probe_log_clear();
 	return ret;
 
 fail_mem:
 	ret = -ENOMEM;
 
 fail_address_parse:
-	trace_probe_log_clear();
 	path_put(&path);
 	kfree(filename);
 

