Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED628223304
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212260; cv=none; b=S5LrBP9/YGtxKbHnQUGka0rvgoMxnt84dkw8p7c608SQQm1OPr7qx8B36LQZ3JXxn1G/KEGVGFqZugNkRc7Xg0YSmhEVb4+p2lXv33j+UoSvHTnU19101Hyevn6KIa0BYD+9RlwqNLyQ/1vqqJK7bS2af8b2cEQtkN5z67fOw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212260; c=relaxed/simple;
	bh=KqaMQEPSNBso+XyHfCeSq3fyp64JTOCX+YZLT1f3lhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO575kRMQo2WA+pdpxVtdTUlS8xCT10nlbCVAfsq+DtSsY1dahoeNq+Spx71Iu+SXzkkVmfU58XxKHTap5FNdhxhTSltY94UoNMHZxwLKDpsBHDnGMDqzhe5dcKoxWcR8Px1ZWSuUNq7XpRqQ6DxtRYzVamjuDNB8MzqowKaxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMn4lZwI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMn4lZwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747212257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Z+XXf3nfcsL32lUalEpYO8BXUHAI1HsKF79TuLYRZo=;
	b=KMn4lZwIByKB+B2Ko38BiOtbPhXpPDryYqoXdnox+c71i3o66sipPcfpio1wBfLvd6+2TV
	dHOcaUQjnhy8MRGnoE4tH3SfnKn8JZ7EUMYO2qRTd02i6Jj3LUie52P7dH5nf6lo7980NL
	n9E3f/vG3o63dvS8jdEP7WBRb/kDK1A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-OSYUDRpWPSK0scfz1JbKCQ-1; Wed,
 14 May 2025 04:44:14 -0400
X-MC-Unique: OSYUDRpWPSK0scfz1JbKCQ-1
X-Mimecast-MFC-AGG-ID: OSYUDRpWPSK0scfz1JbKCQ_1747212253
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 593EC19541B4;
	Wed, 14 May 2025 08:44:12 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.189])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F0AB1953B80;
	Wed, 14 May 2025 08:44:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH v2 08/12] rv: Extend and adapt snroc model
Date: Wed, 14 May 2025 10:43:10 +0200
Message-ID: <20250514084314.57976-9-gmonaco@redhat.com>
In-Reply-To: <20250514084314.57976-1-gmonaco@redhat.com>
References: <20250514084314.57976-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The snroc monitor ensures changes in a task state happens only in the
respective task's context. This is the only monitor enforcing a task
is to be switched in after being switched out, and vice-versa.
Although this is a trivial claim, it is useful to complete other claims
on when scheduling is possible while keeping models simple.

Add the sched_switch_vain event to the model, enforcing that a vain
switch doesn't change the context but can only occur while a task is
running (e.g. a call to schedule that re-selects the current task).

Also adapt the set_state handler prototypes to the tracepoint change.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst  | 32 ++++++++++++-----------
 kernel/trace/rv/monitors/snroc/snroc.c    | 12 ++++++++-
 kernel/trace/rv/monitors/snroc/snroc.h    |  8 +++---
 tools/verification/models/sched/snroc.dot |  2 +-
 4 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 6f76bba94d9f..5cb58ac441d8 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -89,21 +89,23 @@ Monitor snroc
 
 The set non runnable on its own context (snroc) monitor ensures changes in a
 task state happens only in the respective task's context. This is a per-task
-monitor::
-
-                        |
-                        |
-                        v
-                      +------------------+
-                      |  other_context   | <+
-                      +------------------+  |
-                        |                   |
-                        | sched_switch_in   | sched_switch_out
-                        v                   |
-    sched_set_state                         |
-  +------------------                       |
-  |                       own_context       |
-  +----------------->                      -+
+monitor. A task is in its own context after switching in and leaves the context
+when switched out, a vain switch maintains the context::
+
+                          |
+                          |
+                          v
+                        +------------------+
+                        |  other_context   | <+
+                        +------------------+  |
+                          |                   |
+                          | sched_switch_in   | sched_switch_out
+                          v                   |
+    sched_set_state                           |
+    sched_switch_vain                         |
+  +--------------------     own_context       |
+  |                                           |
+  +------------------->                      -+
 
 Monitor scpd
 ~~~~~~~~~~~~
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
index 540e686e699f..11a56b58665e 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -19,7 +19,8 @@
 static struct rv_monitor rv_snroc;
 DECLARE_DA_MON_PER_TASK(snroc, unsigned char);
 
-static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
+static void handle_sched_set_state(void *data, struct task_struct *tsk,
+				   int state, bool from_signal)
 {
 	da_handle_event_snroc(tsk, sched_set_state_snroc);
 }
@@ -33,6 +34,13 @@ static void handle_sched_switch(void *data, bool preempt,
 	da_handle_event_snroc(next, sched_switch_in_snroc);
 }
 
+static void handle_sched_switch_vain(void *data, bool preempt,
+				     struct task_struct *tsk,
+				     unsigned int tsk_state)
+{
+	da_handle_event_snroc(tsk, sched_switch_vain_snroc);
+}
+
 static int enable_snroc(void)
 {
 	int retval;
@@ -43,6 +51,7 @@ static int enable_snroc(void)
 
 	rv_attach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
 	rv_attach_trace_probe("snroc", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("snroc", sched_switch_vain_tp, handle_sched_switch_vain);
 
 	return 0;
 }
@@ -53,6 +62,7 @@ static void disable_snroc(void)
 
 	rv_detach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
 	rv_detach_trace_probe("snroc", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("snroc", sched_switch_vain_tp, handle_sched_switch_vain);
 
 	da_monitor_destroy_snroc();
 }
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
index c3650a2b1b10..d6de40e15ae1 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.h
+++ b/kernel/trace/rv/monitors/snroc/snroc.h
@@ -17,6 +17,7 @@ enum events_snroc {
 	sched_set_state_snroc = 0,
 	sched_switch_in_snroc,
 	sched_switch_out_snroc,
+	sched_switch_vain_snroc,
 	event_max_snroc
 };
 
@@ -36,11 +37,12 @@ static const struct automaton_snroc automaton_snroc = {
 	.event_names = {
 		"sched_set_state",
 		"sched_switch_in",
-		"sched_switch_out"
+		"sched_switch_out",
+		"sched_switch_vain"
 	},
 	.function = {
-		{      INVALID_STATE,  own_context_snroc,       INVALID_STATE },
-		{  own_context_snroc,      INVALID_STATE, other_context_snroc },
+		{       INVALID_STATE,   own_context_snroc,       INVALID_STATE,       INVALID_STATE },
+		{   own_context_snroc,       INVALID_STATE, other_context_snroc,   own_context_snroc },
 	},
 	.initial_state = other_context_snroc,
 	.final_states = { 1, 0 },
diff --git a/tools/verification/models/sched/snroc.dot b/tools/verification/models/sched/snroc.dot
index 8b71c32d4dca..5b1a787d0350 100644
--- a/tools/verification/models/sched/snroc.dot
+++ b/tools/verification/models/sched/snroc.dot
@@ -10,7 +10,7 @@ digraph state_automaton {
 	"other_context" -> "own_context" [ label = "sched_switch_in" ];
 	"own_context" [label = "own_context"];
 	"own_context" -> "other_context" [ label = "sched_switch_out" ];
-	"own_context" -> "own_context" [ label = "sched_set_state" ];
+	"own_context" -> "own_context" [ label = "sched_set_state\nsched_switch_vain" ];
 	{ rank = min ;
 		"__init_other_context";
 		"other_context";
-- 
2.49.0

