Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC126FA6E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563783; cv=none; b=pdNcL8dCPcwhbZ/B+i7WjWyJcbD1DpqLEhpknS0OnAueMqLUNiw8hbk8gFyM54AI2C1Zzhv0DokbNTdr5WAjQ5DDQ8huWq7QTRjhS9dn6DYn8QX+rxVmA0Bp/q1QLs3YRfm1eKosmFng5rf+6/t8UxiddVakd87+OzateUCeMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563783; c=relaxed/simple;
	bh=oKCxdtiHaXrLusltoZ/no3IOGFVOIaODLMIw1eJKc5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQJPEnGcYjt/lbszSQCrXwgXQyhpKX1nAHShoqImm7O82C3e8G4/iVkwLgLw74wuVeIhbw37yVHOfOh3faggzoqMjLQFyCPOFeePfgcgdHrZsCck/VaG3PPgPunj7KBVuzomZGMl4KHbRdoXiO3pRIBRal7bzlAmRhPyTTYmKVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6EEERe2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6EEERe2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voQS/lp53ISUhbNDO53K37fCMrXCmD3XHPGgWIewhl0=;
	b=V6EEERe21YbKvlXLJUmYrHoovBFZ+1COmEnZtFPmYDejXJ9Tqkiz98JbREcV5jBA6r3bn1
	z94awhBrDGlLM2DA9h66JKDcqpbN4Sjcf4ZHQVGFhffZyiDJiXhzSKk44H89YA+a4PGSLk
	UCHJH7F4yp8c5e82SpnNM7jS+vpKlJ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-BLjZ0EkBMAWKpN_3HYsVig-1; Tue,
 15 Jul 2025 03:16:16 -0400
X-MC-Unique: BLjZ0EkBMAWKpN_3HYsVig-1
X-Mimecast-MFC-AGG-ID: BLjZ0EkBMAWKpN_3HYsVig_1752563773
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97C231800289;
	Tue, 15 Jul 2025 07:16:13 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43CA8180035E;
	Tue, 15 Jul 2025 07:16:07 +0000 (UTC)
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
Subject: [PATCH v3 13/17] rv: Adapt the sco monitor to the new set_state
Date: Tue, 15 Jul 2025 09:14:30 +0200
Message-ID: <20250715071434.22508-14-gmonaco@redhat.com>
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

The sched_set_state tracepoint changed prototype adding a new argument,
this argument can differentiate between an explicit set_state called by
a task and a set state to runnable by the scheduler due to a pending
signal.

Expand the model to handle the new set_state flavour, the monitor was
making sure set state happens only outside of the scheduler, if the
event occurs with the new argument (from_signal) set to true, we instead
expect it to be inside the scheduler.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst | 35 +++++++++++++-----------
 kernel/trace/rv/monitors/sco/sco.c       |  5 +++-
 kernel/trace/rv/monitors/sco/sco.h       |  4 +++
 tools/verification/models/sched/sco.dot  |  1 +
 4 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 24b2c62a3bc26..6f76bba94d9fb 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -64,22 +64,25 @@ Monitor sco
 ~~~~~~~~~~~
 
 The scheduling context operations (sco) monitor ensures changes in a task state
-happen only in thread context::
-
-
-                        |
-                        |
-                        v
-    sched_set_state   +------------------+
-  +------------------ |                  |
-  |                   |  thread_context  |
-  +-----------------> |                  | <+
-                      +------------------+  |
-                        |                   |
-                        | schedule_entry    | schedule_exit
-                        v                   |
-                                            |
-                       scheduling_context  -+
+happen only in thread context, the only exception is a special kind of set
+state that occurs if a task about to sleep has a pending signal. This set state
+is not called by the thread but by the scheduler itself::
+
+                                        |
+                                        |
+                                        v
+    sched_set_state                   +------------------+
+  +---------------------------------- |                  |
+  |                                   |  thread_context  |
+  +---------------------------------> |                  | <+
+                                      +------------------+  |
+                                        |                   |
+                                        | schedule_entry    | schedule_exit
+                                        v                   |
+    sched_set_state_runnable_signal                         |
+  +----------------------------------                       |
+  |                                    scheduling_context   |
+  +--------------------------------->                      -+
 
 Monitor snroc
 ~~~~~~~~~~~~~
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index c9206aa12c319..6457ff2469d08 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -22,7 +22,10 @@ DECLARE_DA_MON_PER_CPU(sco, unsigned char);
 static void handle_sched_set_state(void *data, struct task_struct *tsk,
 				   int state, bool from_signal)
 {
-	da_handle_start_event_sco(sched_set_state_sco);
+	if (from_signal)
+		da_handle_event_sco(sched_set_state_runnable_signal_sco);
+	else
+		da_handle_start_event_sco(sched_set_state_sco);
 }
 
 static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
diff --git a/kernel/trace/rv/monitors/sco/sco.h b/kernel/trace/rv/monitors/sco/sco.h
index 83ca9a03331af..2d05ab882b2a6 100644
--- a/kernel/trace/rv/monitors/sco/sco.h
+++ b/kernel/trace/rv/monitors/sco/sco.h
@@ -15,6 +15,7 @@ enum states_sco {
 
 enum events_sco {
 	sched_set_state_sco = 0,
+	sched_set_state_runnable_signal_sco,
 	schedule_entry_sco,
 	schedule_exit_sco,
 	event_max_sco
@@ -35,17 +36,20 @@ static const struct automaton_sco automaton_sco = {
 	},
 	.event_names = {
 		"sched_set_state",
+		"sched_set_state_runnable_signal",
 		"schedule_entry",
 		"schedule_exit"
 	},
 	.function = {
 		{
 			thread_context_sco,
+			INVALID_STATE,
 			scheduling_context_sco,
 			INVALID_STATE
 		},
 		{
 			INVALID_STATE,
+			scheduling_context_sco,
 			INVALID_STATE,
 			thread_context_sco
 		},
diff --git a/tools/verification/models/sched/sco.dot b/tools/verification/models/sched/sco.dot
index 20b0e3b449a6b..4e44ed58c62a3 100644
--- a/tools/verification/models/sched/sco.dot
+++ b/tools/verification/models/sched/sco.dot
@@ -7,6 +7,7 @@ digraph state_automaton {
 	{node [shape = plaintext] "thread_context"};
 	"__init_thread_context" -> "thread_context";
 	"scheduling_context" [label = "scheduling_context"];
+	"scheduling_context" -> "scheduling_context" [ label = "sched_set_state_runnable_signal" ];
 	"scheduling_context" -> "thread_context" [ label = "schedule_exit" ];
 	"thread_context" [label = "thread_context", color = green3];
 	"thread_context" -> "scheduling_context" [ label = "schedule_entry" ];
-- 
2.50.1

