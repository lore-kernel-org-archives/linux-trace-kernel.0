Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184107;
	b=XRjjvuqHVN7jgEn/5K4QwX+Jq6Y5jI7dZaa3bRIvFCC9NCythocFH9eFw0SbwPCuwK2g
	 xRdGPkijiEHFqJwH/w6cZaeKx2JIFuN3hEm2jR27hdcDQxRZWiuvl2mMrnvqmW6BmhnFw
	 v+fXWl1Wau5ybE4JoBFoZv0f7gUSR06mF15stzCdKbVOgY1aHgDeI+qkgr136hwOHzYqT
	 +n7jVdlJhNUP12b/mA/LZv2YbfkqT8lX/ZDaWFqJSwZp4Y1MYjbqO7nOAVenz4+tdkImH
	 bYqUsT6v2lVaW5D1JjXd6PoR01fkwHP+xsmUOPNtLCSYsEL+y1hVLGIo8ablarvTBAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5jglcQFJC9C0X33JDWPhDFdh4yOjWn4U5A67CJ3/7pE=;
	b=MAvQd6tG+cYfOW6BUPo1Hifm5IhIYlJ9N0v9etvrBUL/W0u7Ldnl5vJ+ELVfOva5oR97
	 tv2o6e3CgvYMgwjvtflGLGvrozGgk4fmoNZj44PvGbm972TNR0tUjX0gXKaaNk+9iVV7i
	 skviPEEdD5AoIHGafj+kr75Zb2LCq4gWimepq3YsPtZgbhCNc77f8UDrS8Kka6fs42TEH
	 XjqNFFq7fKynrM7pgCFgcHB4ULlI/K2UgYqWRAIVmQ42Z3xDJlcBraKUPKwOe25fuTpI1
	 xj6Y1jbyJBKmY4wKMLLrRtShUGxYpJGyCkeASPOx3wdMhWO2urXzgu2VZuFOZ2v8Vtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjXB8bh2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C618606A320;
	Mon,  9 Nov 2026 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjXB8bh2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8911F0089F;
	Mon,  9 Nov 2026 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184106;
	bh=5jglcQFJC9C0X33JDWPhDFdh4yOjWn4U5A67CJ3/7pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NjXB8bh28imVPk9dn13llwKt1Md2AyGIUPphhBfTI/Gbj48MOW31HQMoui6m1UHP7
	 6pLRggR5hNoyUOiLgfdsHIQ4Ru4vNy2Gj97uprOnCWsVmnqo97TQnIs+h+HwROnxGf
	 CmcLx6v1LEYXzE/9x4D1MnWEuf5YBIx45Rej/rbSpy+l295MgtqN+iQqRxfi1hpXMA
	 ortk7sIfJJivZQF5fSyMLWFEuT5xK6nPGFa3LjlxGV/jWffpHr5ugejbnm9eNkwqNO
	 BKk6JCDoHPUu6K19wtXiSosEs1L+iFiGQesB9qK2ZrQrIraZaVXLvp2Ojtv7BkHJWS
	 UjWdbELYbQj8w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 02/12] tracing/probes: Enable newly appended probe when target event is enabled
Date: Mon,  9 Nov 2026 09:28:22 +0900
Message-ID: <179418410275.227715.13708246295382818574.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179418408457.227715.1485179201014819821.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Unlike kprobe events, fprobe and uprobe events only register their
underlying probes when the trace event is enabled. When a new probe is
appended to an existing multiprobe fprobe or uprobe event that is
already enabled, the appended probe is linked into the event's probe
list without being registered.

As a result, the newly appended probe never fires until the event is
disabled and re-enabled. Moreover, disabling an fprobe event calls
unregister_fprobe() on the unregistered fprobe, and opening or closing a
perf event on an enabled uprobe event dereferences a NULL tu->uprobe in
uprobe_apply().

Register and enable the newly appended fprobe or uprobe immediately when
the target event is already enabled.

Fixes: 41af3cf587f4 ("tracing/uprobe: Add multi-probe per uprobe event support")
Fixes: 2db832ec9090 ("tracing: fprobe-events: Register fprobe-events only when it is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |   14 +++++------
 kernel/trace/trace_uprobe.c |   56 ++++++++++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 77f2228d44ba..9ab0871a6461 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -933,7 +933,10 @@ static int append_trace_fprobe_event(struct trace_fprobe *tf, struct trace_fprob
 	if (ret)
 		return ret;
 
-	ret = trace_fprobe_verify_target(tf);
+	if (trace_probe_is_enabled(&tf->tp))
+		ret = __register_trace_fprobe(tf);
+	else
+		ret = trace_fprobe_verify_target(tf);
 	if (ret)
 		trace_probe_unlink(&tf->tp);
 	else
@@ -1520,13 +1523,8 @@ static int disable_trace_fprobe(struct trace_event_call *call,
 		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
 	if (!trace_probe_is_enabled(tp)) {
-		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
-			unregister_fprobe(&tf->fp);
-			if (tf->tuser) {
-				tracepoint_user_put(tf->tuser);
-				tf->tuser = NULL;
-			}
-		}
+		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list)
+			__unregister_trace_fprobe(tf);
 	}
 
  out:
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 146da04b93a8..14ac52aebe34 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -447,6 +447,28 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
 	return false;
 }
 
+typedef bool (*filter_func_t)(struct uprobe_consumer *self, struct mm_struct *mm);
+
+#ifdef CONFIG_PERF_EVENTS
+static bool uprobe_perf_filter(struct uprobe_consumer *uc, struct mm_struct *mm);
+#else
+#define uprobe_perf_filter NULL
+#endif
+
+static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
+{
+	struct inode *inode = d_real_inode(tu->path.dentry);
+	struct uprobe *uprobe;
+
+	tu->consumer.filter = filter;
+	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
+
+	tu->uprobe = uprobe;
+	return 0;
+}
+
 static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 {
 	int ret;
@@ -466,10 +488,22 @@ static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 
 	/* Append to existing event */
 	ret = trace_probe_append(&tu->tp, &to->tp);
-	if (!ret)
-		dyn_event_add(&tu->devent, trace_probe_event_call(&tu->tp));
+	if (ret)
+		return ret;
 
-	return ret;
+	if (trace_probe_is_enabled(&tu->tp)) {
+		ret = trace_uprobe_enable(tu,
+			trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE) ?
+			uprobe_perf_filter : NULL);
+		if (ret) {
+			trace_probe_unlink(&tu->tp);
+			return ret;
+		}
+	}
+
+	dyn_event_add(&tu->devent, trace_probe_event_call(&tu->tp));
+
+	return 0;
 }
 
 /*
@@ -1105,22 +1139,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	return trace_handle_return(s);
 }
 
-typedef bool (*filter_func_t)(struct uprobe_consumer *self, struct mm_struct *mm);
-
-static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
-{
-	struct inode *inode = d_real_inode(tu->path.dentry);
-	struct uprobe *uprobe;
-
-	tu->consumer.filter = filter;
-	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
-	if (IS_ERR(uprobe))
-		return PTR_ERR(uprobe);
-
-	tu->uprobe = uprobe;
-	return 0;
-}
-
 static void __probe_event_disable(struct trace_probe *tp)
 {
 	struct trace_uprobe *tu;

