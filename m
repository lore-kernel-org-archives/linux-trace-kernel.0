Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446812;
	b=FOd6/LoxpH8skjPHdSVO73Qbv5+aTBBpaWX+yzLqXsusylzrJlVI19ATeut/p2XoxUyM
	 ONrsTV7YVIHKhuuVKgZPgSFXo7bpGXBXRxLVeyZrRSEsapAnhf0lcZ+47GB3G4KyVwRh9
	 1s/QO6WiZ+OOCii/YIk6ZhqqiOw+eiwxM26yIMzcVwGOrR1mFNKdAD4QSS8/U6tEu1vC2
	 QOkuU1x7rZFZUxn/wjodAuDZsaNnsmAXNAlJSuFIFcx3BvxlqmLDy4c26Mknf+/iZhHIm
	 0Ihqk0X3gGSh6CQy2yKrN4t0Eccqbx/jLv1DPxH33DhX2DOgFesZZirIkBwRjB8yffw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446812;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oDBZSd2HMkUrgeR+h9U1/zObKN23+ppb2T0hvywk+YU=;
	b=RI6rWBgUpPLmN/CKtP0//6foOrHVihX8MV3IgKeEyC2lUFjc2T6U78fEG9MYmd+wmH2c
	 jY0mCSBlFM6m0V0Kk0iSeJtqMJMtfG/HBBG2r17gvWiDBGnSZxfULlS1iIvJdAL0t/81n
	 GPnQRb0jLGSu95QgsW5xk4m0S1BMUmTLUFnKkzM5klqXAevgDadGFdCjeDN/haDiCvZ/m
	 IcU4P6WZi9TWJntUW2QZCQrc9tkKMbkIAg9ufaVTyxyosrz7EsxsjuRpwrjtcvhUHciEa
	 XJhWlqOX/AG9ilVuw/9l8DwWg8rgtF67nuModEHH9Y9+C/Ojg9ksS4lVpbLbha3uCXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itkbYuAo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72876606A31C;
	Thu, 12 Nov 2026 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itkbYuAo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6E41F00A05;
	Thu, 12 Nov 2026 01:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446812;
	bh=oDBZSd2HMkUrgeR+h9U1/zObKN23+ppb2T0hvywk+YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=itkbYuAo2f6eUGLpORZdoFh/Lve+A6mRLYMke8puYIYxfyMJNmwaLceLhBbElvs5F
	 pHKFHfdWnbaiJmPNna9fb5H60+idXlHavbOdpqe7gtgKjRdo0d2lX3oXc9dwebpvTt
	 zY9xn1/eeAXxSpnpRwDE8OTsmV505PkUHzdrQwZz2nggVxRfh4XIhfDylz7NEJURjg
	 q3Ci/vPPS30bcqWc4e3wxjAjl3ktaBNUuvLCPh6EI8yA8c53APXcbofAzdWwaifzGn
	 soVrIN88Aim+YnzABoY6wvlSit8PeshWDU+lV0wQM9xrmZ278D2V/Yod4Se8+g/8uA
	 8zvc+HxzXgpog==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] tracing/probes: Check enabled and busy state before unlinking sibling probes
Date: Thu, 12 Nov 2026 10:26:48 +0900
Message-ID: <179444680826.345731.12254468152780307145.stgit@devnote2>
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

When a multiprobe event is enabled or referenced (for example, by an
eprobe, trigger, or open tracefs file) and a user attempts to delete the
event or one of its probes via dynamic_events, checking
trace_probe_has_sibling() before the enabled and busy checks allows the
first probe to be unlinked and freed while the event is still active,
only returning -EBUSY on the last sibling probe. For uprobe events,
unlinking and freeing an enabled sibling probe without unregistering its
uprobe_consumer also causes a use-after-free.

Ensure all four probe types (kprobe, fprobe, uprobe, and eprobe) verify
that the event is neither enabled nor busy before unlinking any sibling
probe.

Fixes: ca89bc071d5e ("tracing/kprobe: Add multi-probe per event support")
Fixes: 41af3cf587f4 ("tracing/uprobe: Add multi-probe per uprobe event support")
Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |   12 ++++++++----
 kernel/trace/trace_fprobe.c |    8 ++++----
 kernel/trace/trace_kprobe.c |    8 ++++----
 kernel/trace/trace_uprobe.c |    8 ++++++--
 4 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 474be2f5ccd9..f1590c9af6b2 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -94,14 +94,18 @@ static int eprobe_dyn_event_show(struct seq_file *m, struct dyn_event *ev)
 
 static int unregister_trace_eprobe(struct trace_eprobe *ep)
 {
-	/* If other probes are on the event, just unregister eprobe */
-	if (trace_probe_has_sibling(&ep->tp))
-		goto unreg;
-
 	/* Enabled event can not be unregistered */
 	if (trace_probe_is_enabled(&ep->tp))
 		return -EBUSY;
 
+	/* If there's a reference to the dynamic event */
+	if (trace_event_dyn_busy(trace_probe_event_call(&ep->tp)))
+		return -EBUSY;
+
+	/* If other probes are on the event, just unregister eprobe */
+	if (trace_probe_has_sibling(&ep->tp))
+		goto unreg;
+
 	/* Will fail if probe is being used by ftrace or perf */
 	if (trace_probe_unregister_event_call(&ep->tp))
 		return -EBUSY;
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 4e9034ebc3fb..77f2228d44ba 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -853,10 +853,6 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
 /* Unregister a trace_probe and probe_event */
 static int unregister_trace_fprobe(struct trace_fprobe *tf)
 {
-	/* If other probes are on the event, just unregister fprobe */
-	if (trace_probe_has_sibling(&tf->tp))
-		goto unreg;
-
 	/* Enabled event can not be unregistered */
 	if (trace_probe_is_enabled(&tf->tp))
 		return -EBUSY;
@@ -865,6 +861,10 @@ static int unregister_trace_fprobe(struct trace_fprobe *tf)
 	if (trace_event_dyn_busy(trace_probe_event_call(&tf->tp)))
 		return -EBUSY;
 
+	/* If other probes are on the event, just unregister fprobe */
+	if (trace_probe_has_sibling(&tf->tp))
+		goto unreg;
+
 	/* Will fail if probe is being used by ftrace or perf */
 	if (unregister_fprobe_event(tf))
 		return -EBUSY;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e41a7c113646..a42af0e66009 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -548,10 +548,6 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
 /* Unregister a trace_probe and probe_event */
 static int unregister_trace_kprobe(struct trace_kprobe *tk)
 {
-	/* If other probes are on the event, just unregister kprobe */
-	if (trace_probe_has_sibling(&tk->tp))
-		goto unreg;
-
 	/* Enabled event can not be unregistered */
 	if (trace_probe_is_enabled(&tk->tp))
 		return -EBUSY;
@@ -560,6 +556,10 @@ static int unregister_trace_kprobe(struct trace_kprobe *tk)
 	if (trace_event_dyn_busy(trace_probe_event_call(&tk->tp)))
 		return -EBUSY;
 
+	/* If other probes are on the event, just unregister kprobe */
+	if (trace_probe_has_sibling(&tk->tp))
+		goto unreg;
+
 	/* Will fail if probe is being used by ftrace or perf */
 	if (unregister_kprobe_event(tk))
 		return -EBUSY;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 22cc3c8181b8..146da04b93a8 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -396,13 +396,17 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 {
 	int ret;
 
-	if (trace_probe_has_sibling(&tu->tp))
-		goto unreg;
+	/* Enabled event can not be unregistered */
+	if (trace_probe_is_enabled(&tu->tp))
+		return -EBUSY;
 
 	/* If there's a reference to the dynamic event */
 	if (trace_event_dyn_busy(trace_probe_event_call(&tu->tp)))
 		return -EBUSY;
 
+	if (trace_probe_has_sibling(&tu->tp))
+		goto unreg;
+
 	ret = unregister_uprobe_event(tu);
 	if (ret)
 		return ret;

