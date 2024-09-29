Received: from yyz.mikelr.com (yyz.mikelr.com [170.75.163.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1118EAB;
	Sun, 29 Sep 2024 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.75.163.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727641004; cv=none; b=hcfMoDoMX9f+1Z6A2sIGJ22rugV4r1fWTuXQj6ms+405tTMfhsYfQ7EEjYMOrAXAey+l3bxIubAvOP/nvPwHQPTh9rKeIQSPtWrjnufnyDE6IozMp9m9TdjSdotMvUKvWTxbhJPCn1nDFTrQJitk8IyKSPbCSyDEHLc5VfFReAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727641004; c=relaxed/simple;
	bh=tredQinZXruqSuQ7IrvoqP1PQHlHvSY4FpRmlPpn8dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxjt8alQCvg1SuGN8ak/hxm0QH9fnLSlcBnGOqYyifD4aB8OjVeSNh6XumPelxWktv7xfWRrvEl1MoZNsVKvOZIAdU+Q2kgAjNSQcN8y76UDA9DJTLAc5EWW2WjFb88+Fj615FVb+ImBVg8HzBQaGwsvr2Dl2z+BHBJJZPkKfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com; spf=pass smtp.mailfrom=mikelr.com; arc=none smtp.client-ip=170.75.163.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikelr.com
Received: from basin.ykf.mikelr.com (unknown [IPv6:2607:f2c0:e554:1200:4b8f:795f:f483:85bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by yyz.mikelr.com (Postfix) with ESMTPSA id 0791271753;
	Sun, 29 Sep 2024 16:09:56 -0400 (EDT)
From: Mikel Rychliski <mikel@mikelr.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mikel Rychliski <mikel@mikelr.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/probes: Fix MAX_TRACE_ARGS limit handling
Date: Sun, 29 Sep 2024 16:09:37 -0400
Message-ID: <20240929200939.162524-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a trace_probe we would set nr_args prior to truncating the
arguments to MAX_TRACE_ARGS. However, we would only initialize arguments
up to the limit.

This caused invalid memory access when attempting to set up probes with
more than 128 fetchargs.

  BUG: kernel NULL pointer dereference, address: 0000000000000020
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
  CPU: 0 UID: 0 PID: 1769 Comm: cat Not tainted 6.11.0-rc7+ #8
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
  RIP: 0010:__set_print_fmt+0x134/0x330

Resolve the issue by applying the MAX_TRACE_ARGS limit earlier. This
restores the prior behaviour of silently ignoring excess arguments.

Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
 kernel/trace/trace_eprobe.c | 5 +++--
 kernel/trace/trace_fprobe.c | 3 ++-
 kernel/trace/trace_kprobe.c | 3 ++-
 kernel/trace/trace_uprobe.c | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index b0e0ec85912e..62c1a1fba403 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -914,7 +914,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	mutex_lock(&event_mutex);
 	event_call = find_and_get_event(sys_name, sys_event);
-	ep = alloc_event_probe(group, event, event_call, argc - 2);
+	ep = alloc_event_probe(group, event, event_call, min(argc - 2, MAX_TRACE_ARGS));
 	mutex_unlock(&event_mutex);
 
 	if (IS_ERR(ep)) {
@@ -936,8 +936,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		ep->filter_str = NULL;
 
 	argc -= 2; argv += 2;
+	argc = min(argc, MAX_TRACE_ARGS);
 	/* parse arguments */
-	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
 		ret = trace_eprobe_tp_update_arg(ep, argv, i);
 		if (ret)
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index a079abd8955b..ca72fe8a04e7 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1187,6 +1187,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		argc = new_argc;
 		argv = new_argv;
 	}
+	argc = min(argc, MAX_TRACE_ARGS);
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
@@ -1203,7 +1204,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	}
 
 	/* parse arguments */
-	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
 		ctx.offset = 0;
 		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], &ctx);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 61a6da808203..10d16b574db5 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1013,6 +1013,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		argc = new_argc;
 		argv = new_argv;
 	}
+	argc = min(argc, MAX_TRACE_ARGS);
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
@@ -1029,7 +1030,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	}
 
 	/* parse arguments */
-	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
 		ctx.offset = 0;
 		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c3df411a2684..985d23d57702 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -676,6 +676,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	argc -= 2;
 	argv += 2;
+	argc = min(argc, MAX_TRACE_ARGS);
 
 	tu = alloc_trace_uprobe(group, event, argc, is_return);
 	if (IS_ERR(tu)) {
@@ -690,7 +691,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	tu->filename = filename;
 
 	/* parse arguments */
-	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+	for (i = 0; i < argc; i++) {
 		struct traceprobe_parse_context ctx = {
 			.flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER,
 		};

base-commit: 886f3732878dc92fb0ad6d8b6740b66410d1d50a
-- 
2.46.1

