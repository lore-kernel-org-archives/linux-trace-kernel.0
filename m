Received: from yyz.mikelr.com (yyz.mikelr.com [170.75.163.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EF1A2630;
	Mon, 30 Sep 2024 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.75.163.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728043; cv=none; b=Fzdr9lqkNThYDxELjc8ALS9QXSdDDZAn8Q3qT4lsDrBJNsjcg3je+HTm230lTUZMzQ3jmkVgkQOR1sgZuKD2Bn+ZG/uzcQcW+tTShs/Qy4dDxuLVOo5Ge/k9LePmvpOK8ZrR9DFlA132PYMvBpZURpHp7oIRJa22lTrXd4PZS6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728043; c=relaxed/simple;
	bh=FB5ejiCeqMx4hVSNvmttGMnB9ZH/sG0BcVm9jqkcWEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ohi5O6Y5bFFURu+SRIUhL3uU4Gt8qD/We0an5L59Y0AuNVWnC1bVSMf4bBLgWyJ9/3t6mk67rZMYH7grK/Wb+v2wXo2zIpRJj7jtEQD7qgp1BdY27Sb2I6YhokEvIU9uLwTh9XI9JovPXb8Q5g0tUgzuwwUs32eubMUkNTxvQk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com; spf=pass smtp.mailfrom=mikelr.com; arc=none smtp.client-ip=170.75.163.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikelr.com
Received: from basin.ykf.mikelr.com (unknown [IPv6:2607:f2c0:e554:1200:4b8f:795f:f483:85bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by yyz.mikelr.com (Postfix) with ESMTPSA id B50E471841;
	Mon, 30 Sep 2024 16:27:13 -0400 (EDT)
From: Mikel Rychliski <mikel@mikelr.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mikel Rychliski <mikel@mikelr.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing/probes: Fix MAX_TRACE_ARGS limit handling
Date: Mon, 30 Sep 2024 16:26:54 -0400
Message-ID: <20240930202656.292869-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001004050.972e999c644d0e45fd2a94f8@kernel.org>
References: <20241001004050.972e999c644d0e45fd2a94f8@kernel.org>
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

Resolve the issue by applying the MAX_TRACE_ARGS limit earlier. Return
an error when there are too many arguments instead of silently
truncating.

Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
V1 -> V2: Return error instead of dropping excessive arguments

 kernel/trace/trace_eprobe.c | 7 ++++++-
 kernel/trace/trace_fprobe.c | 6 +++++-
 kernel/trace/trace_kprobe.c | 6 +++++-
 kernel/trace/trace_uprobe.c | 4 +++-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index b0e0ec85912e..ebda68ee9abf 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -912,6 +912,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		}
 	}
 
+	if (argc - 2 > MAX_TRACE_ARGS) {
+		ret = -E2BIG;
+		goto error;
+	}
+
 	mutex_lock(&event_mutex);
 	event_call = find_and_get_event(sys_name, sys_event);
 	ep = alloc_event_probe(group, event, event_call, argc - 2);
@@ -937,7 +942,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	argc -= 2; argv += 2;
 	/* parse arguments */
-	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
 		ret = trace_eprobe_tp_update_arg(ep, argv, i);
 		if (ret)
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index a079abd8955b..c62d1629cffe 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1187,6 +1187,10 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 		argc = new_argc;
 		argv = new_argv;
 	}
+	if (argc > MAX_TRACE_ARGS) {
+		ret = -E2BIG;
+		goto out;
+	}
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
@@ -1203,7 +1207,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	}
 
 	/* parse arguments */
-	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
 		ctx.offset = 0;
 		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], &ctx);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 61a6da808203..263fac44d3ca 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1013,6 +1013,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		argc = new_argc;
 		argv = new_argv;
 	}
+	if (argc > MAX_TRACE_ARGS) {
+		ret = -E2BIG;
+		goto out;
+	}
 
 	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
 	if (ret)
@@ -1029,7 +1033,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 	}
 
 	/* parse arguments */
-	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+	for (i = 0; i < argc; i++) {
 		trace_probe_log_set_index(i + 2);
 		ctx.offset = 0;
 		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c3df411a2684..f0273b4d4a7b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -565,6 +565,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
 
 	if (argc < 2)
 		return -ECANCELED;
+	if (argc - 2 > MAX_TRACE_ARGS)
+		return -E2BIG;
 
 	if (argv[0][1] == ':')
 		event = &argv[0][2];
@@ -690,7 +692,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
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

