Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672CE221F21
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212255; cv=none; b=ijG1AvSNg7mPLFwcZaAhVidK8wmEWm4faDBzymlduZJKdePdqllpKFf3tYxNMKAuBosrRx4gA6TRn04+4nSblD9RsputPUmAcl+l9T7w1K0z+JpMPu2ZLaRP3tfY0SnxCJT01N5zbDrvIjZXWuuStB+lU/x03GG2eo/iP4xshXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212255; c=relaxed/simple;
	bh=rMiJWGXqHnsezz2jyGTm+qtPAB7e+eI542LlREgSQtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj07ntkPV/NT+avw7pugLL0NQvo0cSgNYuhOB0/tp93+BS5W1QYIM9P+47bI0GKi8Obrfc4xD+Ek8N5oCNSH8IYIsICvCWGAHdaGlLku2mYZPH4OygWUjea11ftrNjFyzUDo5QDObAjenA1k82g9JLW9T96Yy26R6RG6rr6KkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yy+EWGuS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy+EWGuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747212249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EV3dsS91MpBaNr38Ap9wP8gXKQqOlLCmuruk3UUAUPk=;
	b=Yy+EWGuS64aw3f5fEmgxiz4XUXM7NjeT0efOijUukwzYgJmWLCzDPiK5RyKRFgsJp/L74g
	QWmYk6F+314RH+FMK/jNa8m1goYa+VsXVjNsNl52MVmEsZa/AfIJEBYKEL/0osHS2gK0H3
	HXpQJWm/GkTKL+1GkpVyYm+i9uWrJPI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-ngRI4SVOP_iw3zxZVv_8xA-1; Wed,
 14 May 2025 04:44:06 -0400
X-MC-Unique: ngRI4SVOP_iw3zxZVv_8xA-1
X-Mimecast-MFC-AGG-ID: ngRI4SVOP_iw3zxZVv_8xA_1747212245
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED1FB180036F;
	Wed, 14 May 2025 08:44:04 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.189])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4D7D1953B80;
	Wed, 14 May 2025 08:43:59 +0000 (UTC)
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
Subject: [RFC PATCH v2 07/12] rv: Adapt the sco monitor to the new set_state
Date: Wed, 14 May 2025 10:43:09 +0200
Message-ID: <20250514084314.57976-8-gmonaco@redhat.com>
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

The sched_set_state tracepoint changed prototype adding a new argument,
this argument can differentiate between an explicit set_state called by
a task and a set state to runnable by the scheduler due to a pending
signal.

Adapt the handlers prototypes for the sco monitor.
Expand the model to handle the new set_state flavour, the monitor was
making sure set state happens only outside of the scheduler, if the
event occurs with the new argument (from_signal) set to true, we instead
expect it to be inside the scheduler.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst | 35 +++++++++++++-----------
 kernel/trace/rv/monitors/sco/sco.c       |  8 ++++--
 kernel/trace/rv/monitors/sco/sco.h       |  6 ++--
 tools/verification/models/sched/sco.dot  |  1 +
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 24b2c62a3bc2..6f76bba94d9f 100644
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
index 66f4639d46ac..6457ff2469d0 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -19,9 +19,13 @@
 static struct rv_monitor rv_sco;
 DECLARE_DA_MON_PER_CPU(sco, unsigned char);
 
-static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
+static void handle_sched_set_state(void *data, struct task_struct *tsk,
+				   int state, bool from_signal)
 {
-	da_handle_start_event_sco(sched_set_state_sco);
+	if (from_signal)
+		da_handle_event_sco(sched_set_state_runnable_signal_sco);
+	else
+		da_handle_start_event_sco(sched_set_state_sco);
 }
 
 static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
diff --git a/kernel/trace/rv/monitors/sco/sco.h b/kernel/trace/rv/monitors/sco/sco.h
index 7a4c1f2d5ca1..302750687f9c 100644
--- a/kernel/trace/rv/monitors/sco/sco.h
+++ b/kernel/trace/rv/monitors/sco/sco.h
@@ -15,6 +15,7 @@ enum states_sco {
 
 enum events_sco {
 	sched_set_state_sco = 0,
+	sched_set_state_runnable_signal_sco,
 	schedule_entry_sco,
 	schedule_exit_sco,
 	event_max_sco
@@ -35,12 +36,13 @@ static const struct automaton_sco automaton_sco = {
 	},
 	.event_names = {
 		"sched_set_state",
+		"sched_set_state_runnable_signal",
 		"schedule_entry",
 		"schedule_exit"
 	},
 	.function = {
-		{     thread_context_sco, scheduling_context_sco,          INVALID_STATE },
-		{          INVALID_STATE,          INVALID_STATE,     thread_context_sco },
+		{     thread_context_sco,          INVALID_STATE, scheduling_context_sco,          INVALID_STATE },
+		{          INVALID_STATE, scheduling_context_sco,          INVALID_STATE,     thread_context_sco },
 	},
 	.initial_state = thread_context_sco,
 	.final_states = { 1, 0 },
diff --git a/tools/verification/models/sched/sco.dot b/tools/verification/models/sched/sco.dot
index 20b0e3b449a6..4e44ed58c62a 100644
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
2.49.0

