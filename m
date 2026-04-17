Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC430AD1C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Apr 2026 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407931; cv=none; b=LhfM0EV7b3hK8qLRG+cMTl9FdiWXgl0TETjdFr2lh+EsSLaq28EUBBOptErTmqeDZKBzBxiKCQFLBJPZSMOR9ZyuDBd1ryhMo7i+WZFk2FOA46RPUht7jhP+02uTF9P4xiieY2HjR0EgiK4FWPgI8OjuZ4WBf/WEd3ghXCCDVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407931; c=relaxed/simple;
	bh=f5oqitUIQrt2M+mmPgU0A6645I51E8opziGXOs2VFDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Us1MUaNktgxMuwkVdMCkR5onrWL1823DY/4uR5Aww34tmM5vZCZsbdJrsF5jFy2IUt+b/2eaOy0bqkwf9QdzZiOCM0FgR2g2lLlPSN7M23tUzGgCGTioSBRIFgpbKR1jbpFsVyqM6i5ZYURI0QidRWPrkSblbN0UkNDFgJqXCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUCJ6inx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUCJ6inx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so358972a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776407929; x=1777012729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeLoXs/kp4SRiwBGi0Dd0BwkKG+nfa4yOd58cWcEb7U=;
        b=TUCJ6inxZuuZsB/xge2sw8/4kP43/i4b4jnTBm5j25X5N6L6WreB0JKlIYE/BKv5SD
         SQS/cubqPdH+1+RYx6M/gNAOp+3ZcE2n933+WMVEZrfZl+0QRdlndglmH5N5wOfJmKc1
         OjGopzkFMHqtFZvFhkoZD9l0nE1S4rT1ptElxLYVj/CKUkPMMo2rMhDn/QaarcLHOfED
         32I1zsx6YNcCbhY9n5+co/3fr656DOC2CWDM/7qHq7w23FJsHlz8Q9YKum3ajnHQX1lv
         VqErwzhmuifIy1c9s5WDWF/9rEGPj3LGAzCMy0hFKcd4QVI1yHHCVik63tjZ3T4+guBj
         rqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776407929; x=1777012729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeLoXs/kp4SRiwBGi0Dd0BwkKG+nfa4yOd58cWcEb7U=;
        b=tGQ49Tz6EXVvk+L80PMpGDOVTz0NdbpF4p6JBw/tz8eHhcFiUlILtq017ZQNNj4YQf
         miNGCDp/GQo7lpqI1YWxN72BYWUOSLleZt6M7w3207Q7Q6ZKoxm3h3dWE63Abp20F/C/
         A3gIWLVL+LKYOTEhy76YJmaTAohgVZANm+tzArYDkA/LoVaq89KB0ACyqloWcFhkun02
         MGUKtkidrI9vlui3lof7l1xPkC/SKJWBiSCq8YopG2TI+sa3Ji61nX/hIoY/IHzQ/lxY
         n2rxaj3TLjZZTDSYIU1/2J55DTLpy6fgnq3gahKEGP0QNt5yQsJW3hddrVJmxXrgH0Is
         e9Fg==
X-Forwarded-Encrypted: i=1; AFNElJ/1nFOjptFq4xGsoe9kty1pUvuglg6pDc0C/W1mpyz2ergzENDDDqEQEBeIhbNKMno9POzQcNK9IxwwvhXYvXO5Dj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFat0z/BipdYASBIp4J+WimnQdpgEF9DX/JCJAP0A4ITF7iS1n
	XS6M+BVXfwnDTXka9d27ddU2DnDd1dSAHWQJcjSnyEF0yk+o30gf5Euo
X-Gm-Gg: AeBDievcLe+aK3Az3/QjsSDtj5h1niPDtuGDNM2TBTso5WyV33qv8UPDn8eiVj8ZzZe
	393B4p6hDljGE2NBOKpBAesuRzylWkYWwvO7MIDaCumwySGsT+VP3cWbD0X/peQF3yraoRHHNGK
	wFQgaY4C8YZ1OEoGxuwVHzu9co1jODdJ8MugYaOGtT3bQ8zQIWH0YwIx0XlrtKLzA3/Eurt0l6n
	BtpXBiAjnT4oEQoXtQoHnoQaZDLsWS5s2fJqCcDZYGz3dEfVz8HDsiBin64Pt/YH+dYNJ75YoFA
	iMXE9OdNwK98Tjzk76RaLsgY+lwZ1ZVYm3VLHU/aXc+ZhlPjouCdV1s0Vb+leMWEzKMjKLIe/lQ
	Kn5ZnpHd6CIW3vxDhfaybYJSivLdSmxZG0l5WHv4S1XqUtFdBSCgy1k2mFmpAuSblMcPKB7wtPr
	WCi7JyUWiMwRtjJJp/UhEZJjPJl5EjTXn7I6nTaCvEsah5ib3jpyJwiow=
X-Received: by 2002:a17:90b:1dc2:b0:35f:b306:5d47 with SMTP id 98e67ed59e1d1-361403af9c4mr1809940a91.1.1776407929109;
        Thu, 16 Apr 2026 23:38:49 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20c4fsm11619825ad.59.2026.04.16.23.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:38:48 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	Yash Suthar <yashsuthar983@gmail.com>,
	syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com
Subject: [PATCH] trace: propagate registration failure from tracing_start_*_record()
Date: Fri, 17 Apr 2026 12:08:27 +0530
Message-ID: <20260417063827.84146-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a WARN in tracepoint_probe_unregister():

tracing_start_sched_switch() increments sched_cmdline_ref /
sched_tgid_ref before calling tracing_sched_register(), and its
return value is discarded because the API is void. When the first
register_trace_sched_*() fails (e.g. kmalloc under memory pressure
or failslab), the function's fail_deprobe* labels roll back any
partial probe registration, but the caller's refcount has already
been bumped. The state is now desynced: refs > 0 but no probes in
tp->funcs.

Later, when the caller pairs the start with a stop, the refcount
walks back to 0 and tracing_sched_unregister() calls
unregister_trace_sched_*() against an empty tp->funcs.
func_remove() returns -ENOENT and the
WARN_ON_ONCE(IS_ERR(old)) in tracepoint_remove_func() fires.

Fix: make tracing_start_sched_switch() and the two exported
wrappers, tracing_start_cmdline_record() and
tracing_start_tgid_record(), return int; register the probes
before bumping the refcount; and propagate the error to callers
so refs are only held on behalf of a caller whose registration
actually succeeded.

Fixes: d914ba37d714 ("tracing: Add support for recording tgid of tasks")
Reported-by: syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=f93e97cd824071a2577a40cde9ecd957f59f87eb

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 kernel/trace/trace.c                 |  6 +++---
 kernel/trace/trace.h                 |  4 ++--
 kernel/trace/trace_events.c          | 28 +++++++++++++++++++--------
 kernel/trace/trace_functions.c       |  8 +++++++-
 kernel/trace/trace_functions_graph.c |  6 +++++-
 kernel/trace/trace_sched_switch.c    | 29 ++++++++++++++++++----------
 kernel/trace/trace_selftest.c        |  7 ++++++-
 7 files changed, 62 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8bd4ec08fb36..e936eed99b27 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3320,7 +3320,7 @@ void trace_printk_init_buffers(void)
 	 * allocated here, then this was called by module code.
 	 */
 	if (global_trace.array_buffer.buffer)
-		tracing_start_cmdline_record();
+		(void)tracing_start_cmdline_record();
 }
 EXPORT_SYMBOL_GPL(trace_printk_init_buffers);
 
@@ -3329,7 +3329,7 @@ void trace_printk_start_comm(void)
 	/* Start tracing comms if trace printk is set */
 	if (!buffers_allocated)
 		return;
-	tracing_start_cmdline_record();
+	(void)tracing_start_cmdline_record();
 }
 
 static void trace_printk_start_stop_comm(int enabled)
@@ -3338,7 +3338,7 @@ static void trace_printk_start_stop_comm(int enabled)
 		return;
 
 	if (enabled)
-		tracing_start_cmdline_record();
+		(void)tracing_start_cmdline_record();
 	else
 		tracing_stop_cmdline_record();
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b6d42fe06115..6fe2c8429560 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -751,9 +751,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
 int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		      struct ftrace_regs *fregs);
 
-void tracing_start_cmdline_record(void);
+int tracing_start_cmdline_record(void);
 void tracing_stop_cmdline_record(void);
-void tracing_start_tgid_record(void);
+int tracing_start_tgid_record(void);
 void tracing_stop_tgid_record(void);
 
 int register_tracer(struct tracer *type);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 137b4d9bb116..e6713aa80a03 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -734,9 +734,9 @@ void trace_event_enable_cmd_record(bool enable)
 			continue;
 
 		if (enable) {
-			tracing_start_cmdline_record();
-			set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
-		} else {
+			if (!tracing_start_cmdline_record())
+				set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
+		} else if (file->flags & EVENT_FILE_FL_RECORDED_CMD) {
 			tracing_stop_cmdline_record();
 			clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
 		}
@@ -755,9 +755,9 @@ void trace_event_enable_tgid_record(bool enable)
 			continue;
 
 		if (enable) {
-			tracing_start_tgid_record();
-			set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
-		} else {
+			if (!tracing_start_tgid_record())
+				set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
+		} else if (file->flags & EVENT_FILE_FL_RECORDED_TGID) {
 			tracing_stop_tgid_record();
 			clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT,
 				  &file->flags);
@@ -847,14 +847,26 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
 
 			if (tr->trace_flags & TRACE_ITER(RECORD_CMD)) {
+				ret = tracing_start_cmdline_record();
+				if (ret) {
+					pr_info("event trace: Could not enable event %s\n",
+						trace_event_name(call));
+					break;
+				}
 				cmd = true;
-				tracing_start_cmdline_record();
 				set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
 			}
 
 			if (tr->trace_flags & TRACE_ITER(RECORD_TGID)) {
+				ret = tracing_start_tgid_record();
+				if (ret) {
+					if (cmd)
+						tracing_stop_cmdline_record();
+					pr_info("event trace: Could not enable event %s\n",
+						trace_event_name(call));
+					break;
+				}
 				tgid = true;
-				tracing_start_tgid_record();
 				set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index c12795c2fb39..14d099734345 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -146,6 +146,8 @@ static bool handle_func_repeats(struct trace_array *tr, u32 flags_val)
 static int function_trace_init(struct trace_array *tr)
 {
 	ftrace_func_t func;
+	int ret;
+
 	/*
 	 * Instance trace_arrays get their ops allocated
 	 * at instance creation. Unless it failed
@@ -165,7 +167,11 @@ static int function_trace_init(struct trace_array *tr)
 
 	tr->array_buffer.cpu = raw_smp_processor_id();
 
-	tracing_start_cmdline_record();
+	ret = tracing_start_cmdline_record();
+	if (ret) {
+		ftrace_reset_array_ops(tr);
+		return ret;
+	}
 	tracing_start_function_trace(tr);
 	return 0;
 }
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 1de6f1573621..6b27ed62fee8 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -487,7 +487,11 @@ static int graph_trace_init(struct trace_array *tr)
 	ret = register_ftrace_graph(tr->gops);
 	if (ret)
 		return ret;
-	tracing_start_cmdline_record();
+	ret = tracing_start_cmdline_record();
+	if (ret) {
+		unregister_ftrace_graph(tr->gops);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index c46d584ded3b..683ea4ca1498 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -89,12 +89,22 @@ static void tracing_sched_unregister(void)
 	unregister_trace_sched_wakeup(probe_sched_wakeup, NULL);
 }
 
-static void tracing_start_sched_switch(int ops)
+static int tracing_start_sched_switch(int ops)
 {
-	bool sched_register;
+	int ret = 0;
 
 	mutex_lock(&sched_register_mutex);
-	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
+
+	/*
+	 * If the registration fails, do not bump the reference count : the
+	 * caller must observe the failure so it can avoid a later matching
+	 * stop that would otherwise unregister probes that were never added.
+	 */
+	if (!sched_cmdline_ref && !sched_tgid_ref) {
+		ret = tracing_sched_register();
+		if (ret)
+			goto out;
+	}
 
 	switch (ops) {
 	case RECORD_CMDLINE:
@@ -105,10 +115,9 @@ static void tracing_start_sched_switch(int ops)
 		sched_tgid_ref++;
 		break;
 	}
-
-	if (sched_register && (sched_cmdline_ref || sched_tgid_ref))
-		tracing_sched_register();
+out:
 	mutex_unlock(&sched_register_mutex);
+	return ret;
 }
 
 static void tracing_stop_sched_switch(int ops)
@@ -130,9 +139,9 @@ static void tracing_stop_sched_switch(int ops)
 	mutex_unlock(&sched_register_mutex);
 }
 
-void tracing_start_cmdline_record(void)
+int tracing_start_cmdline_record(void)
 {
-	tracing_start_sched_switch(RECORD_CMDLINE);
+	return tracing_start_sched_switch(RECORD_CMDLINE);
 }
 
 void tracing_stop_cmdline_record(void)
@@ -140,9 +149,9 @@ void tracing_stop_cmdline_record(void)
 	tracing_stop_sched_switch(RECORD_CMDLINE);
 }
 
-void tracing_start_tgid_record(void)
+int tracing_start_tgid_record(void)
 {
-	tracing_start_sched_switch(RECORD_TGID);
+	return tracing_start_sched_switch(RECORD_TGID);
 }
 
 void tracing_stop_tgid_record(void)
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index d88c44f1dfa5..238e7451f8e4 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -1084,7 +1084,12 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		warn_failed_init_tracer(trace, ret);
 		goto out;
 	}
-	tracing_start_cmdline_record();
+	ret = tracing_start_cmdline_record();
+	if (ret) {
+		unregister_ftrace_graph(&fgraph_ops);
+		warn_failed_init_tracer(trace, ret);
+		goto out;
+	}
 
 	/* Sleep for a 1/10 of a second */
 	msleep(100);
-- 
2.43.0

