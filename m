Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEDC1A9FAA;
	Tue, 24 Feb 2026 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900605; cv=none; b=SJG6To7moO5sebBX0RliRNZ6HUnxVEfYXRrOIXu9CTy6dK8RQXJby85s3oZIAzq37cWviYQRfGiz1Te6129r+WNYp6tg+t6j+xDTdRq2CPc5EFdwYgR3boBdW3eKzAlGoAGrvFgCClGT7dMJ0mqumxtqyuP44aCPefEzU+TSDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900605; c=relaxed/simple;
	bh=P5QC17lOf8A+a8R9MGZmCnujwSKtmz5Lp1NSKCwPMGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E//iYFFuNOhwIhQXp3NLFwUmjXey2ExQXgO60grSQJIxNi6SAkPD6nZXcsv5HiHE6UvZb85saWuAcq8vFLeGEkt3Mb0U9kyyu37hLmeQCirMypsIMOWebDWLFKAoY4rI6t43ZJd4tNGfDlmf2UV1XZ6GU7LnrgmEWyz7enAb0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a1b3ad84112911f1a21c59e7364eecb8-20260224
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:dab9deb9-1e85-47ac-a21d-3728104d46b7,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.11,REQID:dab9deb9-1e85-47ac-a21d-3728104d46b7,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:89c9d04,CLOUDID:a5bf074b2a72d9d1a02245aab28f4249,BulkI
	D:260224103635R6J3HTTG,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a1b3ad84112911f1a21c59e7364eecb8-20260224
X-User: hehuiwen@kylinos.cn
Received: from localhost.localdomain [(119.39.76.224)] by mailgw.kylinos.cn
	(envelope-from <hehuiwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1545000973; Tue, 24 Feb 2026 10:36:32 +0800
From: Huiwen He <hehuiwen@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: [PATCH] tracing: Fix syscall events activation by ensuring refcount hits zero
Date: Tue, 24 Feb 2026 10:35:44 +0800
Message-ID: <20260224023544.1250787-1-hehuiwen@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiple syscall events are specified in the kernel command line
(e.g., trace_event=syscalls:sys_enter_openat,syscalls:sys_enter_close),
they are often not captured after boot, even though they appear enabled
in the tracing/set_event file.

The issue stems from how syscall events are initialized. Syscall
tracepoints require the global reference count (sys_tracepoint_refcount)
to transition from 0 to 1 to trigger the registration of the syscall
work (TIF_SYSCALL_TRACEPOINT) for tasks, including the init process (pid 1).

The current implementation of early_enable_events() with disable_first=true
used an interleaved sequence of "Disable A -> Enable A -> Disable B -> Enable B".
If multiple syscalls are enabled, the refcount never drops to zero,
preventing the 0->1 transition that triggers actual registration.

Fix this by splitting early_enable_events() into two distinct phases:
1. Disable all events specified in the buffer.
2. Enable all events specified in the buffer.

This ensures the refcount hits zero before re-enabling, allowing syscall
events to be properly activated during early boot.

The code is also refactored to use a helper function to avoid logic
duplication between the disable and enable phases.

Fixes: ce1039bd3a89 ("tracing: Fix enabling of syscall events on the command line")
Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
---
 kernel/trace/trace_events.c | 52 ++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 137b4d9bb116..879ed8b0cc78 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4514,26 +4514,22 @@ static __init int event_trace_memsetup(void)
 	return 0;
 }
 
-__init void
-early_enable_events(struct trace_array *tr, char *buf, bool disable_first)
+/*
+ * Helper function to enable or disable a comma-separated list of events
+ * from the bootup buffer.
+ */
+static __init void __early_set_events(struct trace_array *tr, char *buf, bool enable)
 {
 	char *token;
-	int ret;
-
-	while (true) {
-		token = strsep(&buf, ",");
-
-		if (!token)
-			break;
 
+	while ((token = strsep(&buf, ","))) {
 		if (*token) {
-			/* Restarting syscalls requires that we stop them first */
-			if (disable_first)
+			if (enable) {
+				if (ftrace_set_clr_event(tr, token, 1))
+					pr_warn("Failed to enable trace event: %s\n", token);
+			} else {
 				ftrace_set_clr_event(tr, token, 0);
-
-			ret = ftrace_set_clr_event(tr, token, 1);
-			if (ret)
-				pr_warn("Failed to enable trace event: %s\n", token);
+			}
 		}
 
 		/* Put back the comma to allow this to be called again */
@@ -4542,6 +4538,32 @@ early_enable_events(struct trace_array *tr, char *buf, bool disable_first)
 	}
 }
 
+/**
+ * early_enable_events - enable events from the bootup buffer
+ * @tr: The trace array to enable the events in
+ * @buf: The buffer containing the comma separated list of events
+ * @disable_first: If true, disable all events in @buf before enabling them
+ *
+ * This function enables events from the bootup buffer. If @disable_first
+ * is true, it will first disable all events in the buffer before enabling
+ * them.
+ *
+ * For syscall events, which rely on a global refcount to register the
+ * SYSCALL_WORK_SYSCALL_TRACEPOINT flag (especially for pid 1), we must
+ * ensure the refcount hits zero before re-enabling them. A simple
+ * "disable then enable" per-event is not enough if multiple syscalls are
+ * used, as the refcount will stay above zero. Thus, we need a two-phase
+ * approach: disable all, then enable all.
+ */
+__init void
+early_enable_events(struct trace_array *tr, char *buf, bool disable_first)
+{
+	if (disable_first)
+		__early_set_events(tr, buf, false);
+
+	__early_set_events(tr, buf, true);
+}
+
 static __init int event_trace_enable(void)
 {
 	struct trace_array *tr = top_trace_array();
-- 
2.43.0

