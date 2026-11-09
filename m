Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184097;
	b=W7k35m+x6nFHERGdCO+sCuCQQQYtt8QvfepFu8ucXIKYKdpRs27BSME1zBBqk4jDablR
	 +4tlrTkX179KaSU+FzZjIk+xpZOQ1p/OwzdKwSKq1w4660m731ry0gAU2PbbnT+FX1Y9B
	 H/5k3PcEWVIKBtYVKuaA1j+Qq59uX8+KLzxoF4C2iaeOVA1VZNQwXV3lEpfrSqO1W+v+n
	 BRtcxJxEY5itXRWkVR8Un9O/d/eHi8Q9WtboslDTFJ43IWzhACPglhat4Y9rDZZVkRmRa
	 sxx5c/pINrGtQRrpGUf00AFji1+T44QA+bFdlElsqOkRf9yc97QUkYr2z8430gtE2FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184097;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oDBZSd2HMkUrgeR+h9U1/zObKN23+ppb2T0hvywk+YU=;
	b=zNI5f+e/d54kwd2dhWMPUr1Yo+xek+GE+w5pWnJj+qQ//eDTgG69kX9opFKU4UKZ5ft3
	 +HcuLIyozzM28W9Btr8JthQu282DL8/Rq19UpINj0pC9WFDYSnUmVHRC6+GMPys0nntVM
	 vnNrjP4F1dMpECBWFsKEMALQ7c6pku2VbuKw+jHcULILMBJeFR6BGusvHDrDSsBw04Wxt
	 GTdek207Dt55uXOF40CPybkwspd6SZG4wX8AueKjCLWwGYfkuRAf2S5nGXF6SjeG/9tVo
	 x9Oo6ZDzN5qDRsqcDSV9WCa+JtXF5umDARqbOdrQImAyUiNJVfoa6WpeYajPRv51Q2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUCtxfYw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2A606A31C;
	Mon,  9 Nov 2026 00:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUCtxfYw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2372A1F0089F;
	Mon,  9 Nov 2026 00:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184097;
	bh=oDBZSd2HMkUrgeR+h9U1/zObKN23+ppb2T0hvywk+YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUCtxfYwFdnnoYYkMqu52LIZaWglNmAoNj/o4b+AYvIsPjFsDEuQzNy3h9Sr8NGpN
	 4/Z06RjEHMRINTQYp0PA8p1UwVGKBUPp+62oM62/vTHc1Yi7Z+Q8wePJhupXRGBjGb
	 7FAuMng2vMz0OvxD7z1TU+gVLyvuIvoqGlgIf/q5xcSelIHI6t5SHoX7LHct3fINRV
	 9pjklU7W+8LExkcrgZE1TX4rs6n2LbGdOAPh0t5V38a1Kn/W+HOJxlNBrI046gO2Vf
	 WsHHz/DrDLMFnKWD1jUskoQW6KkZUjJrT7YqYwG5TSfC18C7I1H2N/lz53qmASgnYg
	 R3nGI0xQO/1Cw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 01/12] tracing/probes: Check enabled and busy state before unlinking sibling probes
Date: Mon,  9 Nov 2026 09:28:14 +0900
Message-ID: <179418409398.227715.11396070214186733215.stgit@devnote2>
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

