Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446821;
	b=QCGXRf4ZSkYZrHPmpYPGEwBjLYFsXuGKuj44FN0lrPs6gqorAy4ZSpQfItQIiWSVhELU
	 Jq+cO87TYhHu3QWJ7f8ujimY2XuFCqLeZX99oA1GuIsro1EY2jmjU+jnOb+fp8Pm+bCKY
	 q1lTwFuR21oAwbD8R1gj5mumWd+hV4Wchp3/Xp2OwQpErWMp7Q9RL2jNLpV5h5OuJgEj+
	 0MZtCFTNINnt+le3s5m9ZKUrUyhcrnmcwSGYySD7/B/DJgjx3Gp53ghOcNEurhwvPothm
	 FeL0F8Xj933dCujV7b2k5RhWhET1o5tiHoyBC/5k6dnjeup/BgA+GRmuCDXu9P8UJag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5jglcQFJC9C0X33JDWPhDFdh4yOjWn4U5A67CJ3/7pE=;
	b=gO++k1/l6a5XcJZrSIKg3BVcxCRARbL+A7oYoRRRLhxQv8M4BnaRzsxT5B7bSBXjlW24
	 4bUcRCdR6oV1lfCY0oYaH74Q6j7HbxC4hasbQiMZ/eHQvs1ElCf9lw44KkNX64880ypKI
	 gFdZ1mOvLS6fA/g7IoIBTVPog8wta6UZGe4Ws3IfeG/fpFxowaeR9MOSsucuA7228qsw8
	 DJnj7wrWA9KVyXS3Eyq+uj7nUUA7+vBm7rTcdOfKBorIMrXoiKOk+/UP8Cp2IpUKIi2E4
	 aOfTL83aRQ3B7D9D7m4N1yhNwYDB5oLFkJ7MZFeZrq0ilVd0DAVjo/nIghL21g3ah9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpBO6Y2a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2514606A31C;
	Thu, 12 Nov 2026 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpBO6Y2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A963B1F00A05;
	Thu, 12 Nov 2026 01:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446821;
	bh=5jglcQFJC9C0X33JDWPhDFdh4yOjWn4U5A67CJ3/7pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CpBO6Y2aC63x8G3TLlt5L9B134o9vBxRH+Oxv1RwYbVRHBqTmUXsFtHRsAegYqVpd
	 5Ngjgw5BSdbjSIj6KYAdzTGQmtVjd8cX1Rv/exlrQ0C5zsNCVI95PJZX5EVWxdqX93
	 LNQP92DzLpoxPmgQNc7gAJFsTOpnb8W8VMYtn8FsFYFIncuCrLPcdP0eIpFS+sC6/Q
	 oPx/ftVpP2GpJZCSuAvWZxdDam3L6NxJxnr6AsgmQo0Y4GHBtgKiUaT9/zgWU3BXem
	 iruxSswJe3rL3va8bRQY9oc4Bf6rGhClfwoDAllHy6WWN1loyKC8GlAIPl0hW+qOiz
	 A1ZusqEc4jAJg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] tracing/probes: Enable newly appended probe when target event is enabled
Date: Thu, 12 Nov 2026 10:26:57 +0900
Message-ID: <179444681738.345731.16552746027049016745.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179444679892.345731.5271591537517106679.stgit@devnote2>
References: <179444679892.345731.5271591537517106679.stgit@devnote2>
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

