Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAF271473
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563790; cv=none; b=S4Dwgy0rZ5jTDxnTrBlZ6XDUl0Tcwkqt/VyFaeG6N5+GJA+qNmu7i0SF/oa2OFL6TpJWOk3D25oDngUWpDdfNz5l+GZ398ozNhzpo7GBIYVbm0gCR8Z4jpkkAlx6/1WjbrMIQtLg7WSky/AfpSQ7lGPw6DK9gtZ4FX7kariMu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563790; c=relaxed/simple;
	bh=BTgI+Wy5Ozi9V0326b7yhYZ4X5Ra5vXM3Agpg4yUc2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJTlKKWk7XEwCwAki6Olp8geHcigy3gZNJG4/2mT1IxRVLZxzAfUHwSPnD2qxyr9Mr3sNjTC7KzBtqaw9qVQLA/e2Evnxz3sO3RPZXWB1mPdlFsUFePeUaHOtc4e3IyC/pGblX/4yvIxA12J+bk+TZ+/UGo3m0Y//p06AiX0DZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGGcB4bd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGGcB4bd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDb9L2a6bpB5aISgROYQAwEqouf8IV6Xr1GlNkbjo0I=;
	b=jGGcB4bd+nlezxlUpUSyc0RpFU06GbSM2E6jEVOmQZYnckQHtRkCRyYVTMkF7p8ZY/lQcg
	W1/bgZeepMaERVlRjR9Xc7MDRQ0Rcrrob4feBqaS+90zfwFXIq+fQiZavHqgodOTVJAxZ7
	1EeS06dKBxkBS2HRJmhytjzAAXFyZIY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-tnAs1Y5rP6yfgWDw3bbPvw-1; Tue,
 15 Jul 2025 03:16:23 -0400
X-MC-Unique: tnAs1Y5rP6yfgWDw3bbPvw-1
X-Mimecast-MFC-AGG-ID: tnAs1Y5rP6yfgWDw3bbPvw_1752563782
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 061551956089;
	Tue, 15 Jul 2025 07:16:22 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00AF5180045B;
	Tue, 15 Jul 2025 07:16:14 +0000 (UTC)
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
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 14/17] rv: Extend snroc model
Date: Tue, 15 Jul 2025 09:14:31 +0200
Message-ID: <20250715071434.22508-15-gmonaco@redhat.com>
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>
References: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The snroc monitor ensures changes in a task state happens only in the
respective task's context. This is the only monitor enforcing a task
is to be switched in after being switched out, and vice-versa.
Although this is a trivial claim, it is useful to complete other claims
on when scheduling is possible while keeping models simple.

Add the sched_switch_vain event to the model, enforcing that a vain
switch doesn't change the context but can only occur while a task is
running (e.g. a call to schedule that re-selects the current task).

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst  | 32 ++++++++++++-----------
 kernel/trace/rv/monitors/snroc/snroc.c    |  9 +++++++
 kernel/trace/rv/monitors/snroc/snroc.h    |  8 ++++--
 tools/verification/models/sched/snroc.dot |  2 +-
 4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 6f76bba94d9fb..5cb58ac441d83 100644
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
index 2651f589d1554..11a56b58665e7 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -34,6 +34,13 @@ static void handle_sched_switch(void *data, bool preempt,
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
@@ -44,6 +51,7 @@ static int enable_snroc(void)
 
 	rv_attach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
 	rv_attach_trace_probe("snroc", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("snroc", sched_switch_vain_tp, handle_sched_switch_vain);
 
 	return 0;
 }
@@ -54,6 +62,7 @@ static void disable_snroc(void)
 
 	rv_detach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
 	rv_detach_trace_probe("snroc", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("snroc", sched_switch_vain_tp, handle_sched_switch_vain);
 
 	da_monitor_destroy_snroc();
 }
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
index be46f7b9ebb87..064d98fb9796d 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.h
+++ b/kernel/trace/rv/monitors/snroc/snroc.h
@@ -17,6 +17,7 @@ enum events_snroc {
 	sched_set_state_snroc = 0,
 	sched_switch_in_snroc,
 	sched_switch_out_snroc,
+	sched_switch_vain_snroc,
 	event_max_snroc
 };
 
@@ -36,18 +37,21 @@ static const struct automaton_snroc automaton_snroc = {
 	.event_names = {
 		"sched_set_state",
 		"sched_switch_in",
-		"sched_switch_out"
+		"sched_switch_out",
+		"sched_switch_vain"
 	},
 	.function = {
 		{
 			INVALID_STATE,
 			own_context_snroc,
+			INVALID_STATE,
 			INVALID_STATE
 		},
 		{
 			own_context_snroc,
 			INVALID_STATE,
-			other_context_snroc
+			other_context_snroc,
+			own_context_snroc
 		},
 	},
 	.initial_state = other_context_snroc,
diff --git a/tools/verification/models/sched/snroc.dot b/tools/verification/models/sched/snroc.dot
index 8b71c32d4dca4..5b1a787d0350b 100644
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
2.50.1

