Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E486376478
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097393; cv=none; b=AqzQPgYTAdnEdW/aNwLgoKaG5SqbC4r0S75rOtSO9GWk5TsZbo5CtOXhXUD2dZftnBjxRJJdczYa1gtrB/Ml3xSvg7hjGL7vFeRzIMS8/t4p4kvCPItA7TsKYav7vWqhzwcvKXsnlYkR1a5/fqabBuoWHUItUVo2D9LNh/eJE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097393; c=relaxed/simple;
	bh=RhPHfKDm0oGl1S2+0DrnK5IezrXtna+1V4LIOFyEyZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC+jKVub8C3QFRjBI05jVKr7/E9xYb0oQjsTyY2965QuW3iW62QEEsdlgAucqEoEWN1cKlt6Huq3j+Om8ZKtT0awmfGIZ45UWc++Q6ltF0vZfgfT+qTL2T87Q5/85EtUCW+CRyloQSmGYR5M44rfPm6c6+HoX6G7Ge9UD6SaHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNvsmKRX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNvsmKRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769097378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLPd5+GnCQcV5/ZdDudxK6xPWoyTLOfgIflkpaGoDIg=;
	b=hNvsmKRXFkwPTekMGw4WluzLjCaMSlQ3XzhDGTZwSKIumb8ZDUJX7mdvblhyj0flcj8XD4
	yHSFc/NVLLSZSjpqxuyZFs8akfxwlNGKu0SRIJwbamKcaiER9HalQhvvO+wtMTkMiObo+V
	HTYhyX8IjOBKhm1c81IluF6TNePeaW8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-hvrdKgFWPYW0EaUuna6RBw-1; Thu,
 22 Jan 2026 10:56:13 -0500
X-MC-Unique: hvrdKgFWPYW0EaUuna6RBw-1
X-Mimecast-MFC-AGG-ID: hvrdKgFWPYW0EaUuna6RBw_1769097371
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5BF518005B0;
	Thu, 22 Jan 2026 15:56:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E49B8180049F;
	Thu, 22 Jan 2026 15:56:06 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 10/15] rv: Add enqueue/dequeue to snroc monitor
Date: Thu, 22 Jan 2026 16:54:55 +0100
Message-ID: <20260122155500.362683-11-gmonaco@redhat.com>
In-Reply-To: <20260122155500.362683-1-gmonaco@redhat.com>
References: <20260122155500.362683-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The snroc monitor is a simple monitor that validates set_state occurs
only when a task is running. This implicitly validates switch in and out
follow one another.

Add enqueue/dequeue to validate they also follow one another without
duplicated events. Although they are not necessary to define the
task context, adding the check here saves from adding another simple
per-task monitor, which would require another slot in the task struct.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_sched.rst  | 39 ++++++++++++-------
 kernel/trace/rv/monitors/snroc/snroc.c    | 18 ++++++++-
 kernel/trace/rv/monitors/snroc/snroc.h    | 46 ++++++++++++++++++++---
 tools/verification/models/sched/snroc.dot | 30 ++++++++++-----
 4 files changed, 101 insertions(+), 32 deletions(-)

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 0b96d6e147c6..d88ef856f89f 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -66,21 +66,32 @@ Monitor snroc
 
 The set non runnable on its own context (snroc) monitor ensures changes in a
 task state happens only in the respective task's context. This is a per-task
-monitor::
+monitor.
+The monitor also includes enqueue/dequeue events to validate they alternate
+each other without duplication. Although they are not necessary to define the
+context, adding the check here saves from adding another simple per-task monitor::
+
+              |
+              |
+              v
+         #===============================================================#
+ +------ H                           enqueued                            H <--+
+ |       #===============================================================#    |
+ |         |                  ^                       sched_set_state         |
+ |  sched_switch_in   sched_switch_out                +--------------+        |
+ |         v                  |                       v              |        |
+ |      +-----------------------+   sched_dequeue    +-------------------+    |
+ |      |                       | -----------------> |                   |    |
+ |      |     own_context       |                    | dequeued_running  |    |
+ |      |                       | <----------------- |                   |    |
+ |      +-----------------------+   sched_enqueue    +-------------------+    |
+ |          ^   |           |                                                 |
+ |          +---+           | sched_switch_out                                |
+ |    sched_set_state       v                                                 |
+ |                      +-------------------------------------+               |
+ +--------------------> |              dequeued               | --------------+
+       sched_dequeue    +-------------------------------------+  sched_enqueue
 
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
 
 Monitor scpd
 ~~~~~~~~~~~~
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
index f168b1a4b12c..87f87f479d18 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -17,6 +17,16 @@
 #include "snroc.h"
 #include <rv/da_monitor.h>
 
+static void handle_sched_dequeue(void *data, struct task_struct *tsk, int cpu)
+{
+	da_handle_event(tsk, sched_dequeue_snroc);
+}
+
+static void handle_sched_enqueue(void *data, struct task_struct *tsk, int cpu)
+{
+	da_handle_event(tsk, sched_enqueue_snroc);
+}
+
 static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
 {
 	da_handle_event(tsk, sched_set_state_snroc);
@@ -27,8 +37,8 @@ static void handle_sched_switch(void *data, bool preempt,
 				struct task_struct *next,
 				unsigned int prev_state)
 {
-	da_handle_start_event(prev, sched_switch_out_snroc);
-	da_handle_event(next, sched_switch_in_snroc);
+	da_handle_event(prev, sched_switch_out_snroc);
+	da_handle_start_run_event(next, sched_switch_in_snroc);
 }
 
 static int enable_snroc(void)
@@ -39,6 +49,8 @@ static int enable_snroc(void)
 	if (retval)
 		return retval;
 
+	rv_attach_trace_probe("snroc", sched_dequeue_tp, handle_sched_dequeue);
+	rv_attach_trace_probe("snroc", sched_enqueue_tp, handle_sched_enqueue);
 	rv_attach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
 	rv_attach_trace_probe("snroc", sched_switch, handle_sched_switch);
 
@@ -49,6 +61,8 @@ static void disable_snroc(void)
 {
 	rv_this.enabled = 0;
 
+	rv_detach_trace_probe("snroc", sched_dequeue_tp, handle_sched_dequeue);
+	rv_detach_trace_probe("snroc", sched_enqueue_tp, handle_sched_enqueue);
 	rv_detach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
 	rv_detach_trace_probe("snroc", sched_switch, handle_sched_switch);
 
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
index 88b7328ad31a..b5b8c508cd11 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.h
+++ b/kernel/trace/rv/monitors/snroc/snroc.h
@@ -8,7 +8,9 @@
 #define MONITOR_NAME snroc
 
 enum states_snroc {
-	other_context_snroc,
+	enqueued_snroc,
+	dequeued_snroc,
+	dequeued_running_snroc,
 	own_context_snroc,
 	state_max_snroc,
 };
@@ -16,6 +18,8 @@ enum states_snroc {
 #define INVALID_STATE state_max_snroc
 
 enum events_snroc {
+	sched_dequeue_snroc,
+	sched_enqueue_snroc,
 	sched_set_state_snroc,
 	sched_switch_in_snroc,
 	sched_switch_out_snroc,
@@ -32,18 +36,48 @@ struct automaton_snroc {
 
 static const struct automaton_snroc automaton_snroc = {
 	.state_names = {
-		"other_context",
+		"enqueued",
+		"dequeued",
+		"dequeued_running",
 		"own_context",
 	},
 	.event_names = {
+		"sched_dequeue",
+		"sched_enqueue",
 		"sched_set_state",
 		"sched_switch_in",
 		"sched_switch_out",
 	},
 	.function = {
-		{      INVALID_STATE,  own_context_snroc,       INVALID_STATE },
-		{  own_context_snroc,      INVALID_STATE, other_context_snroc },
+		{
+			dequeued_snroc,
+			INVALID_STATE,
+			INVALID_STATE,
+			own_context_snroc,
+			INVALID_STATE,
+		},
+		{
+			INVALID_STATE,
+			enqueued_snroc,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			INVALID_STATE,
+			own_context_snroc,
+			dequeued_running_snroc,
+			INVALID_STATE,
+			dequeued_snroc,
+		},
+		{
+			dequeued_running_snroc,
+			INVALID_STATE,
+			own_context_snroc,
+			INVALID_STATE,
+			enqueued_snroc,
+		},
 	},
-	.initial_state = other_context_snroc,
-	.final_states = { 1, 0 },
+	.initial_state = enqueued_snroc,
+	.final_states = { 1, 0, 0, 0 },
 };
diff --git a/tools/verification/models/sched/snroc.dot b/tools/verification/models/sched/snroc.dot
index 8b71c32d4dca..b32e9adfb383 100644
--- a/tools/verification/models/sched/snroc.dot
+++ b/tools/verification/models/sched/snroc.dot
@@ -1,18 +1,28 @@
 digraph state_automaton {
 	center = true;
 	size = "7,11";
-	{node [shape = plaintext, style=invis, label=""] "__init_other_context"};
-	{node [shape = ellipse] "other_context"};
-	{node [shape = plaintext] "other_context"};
-	{node [shape = plaintext] "own_context"};
-	"__init_other_context" -> "other_context";
-	"other_context" [label = "other_context", color = green3];
-	"other_context" -> "own_context" [ label = "sched_switch_in" ];
+	{node [shape = circle] "dequeued"};
+	{node [shape = circle] "dequeued_running"};
+	{node [shape = plaintext, style=invis, label=""] "__init_enqueued"};
+	{node [shape = doublecircle] "enqueued"};
+	{node [shape = circle] "enqueued"};
+	{node [shape = circle] "own_context"};
+	"__init_enqueued" -> "enqueued";
+	"dequeued" [label = "dequeued"];
+	"dequeued" -> "enqueued" [ label = "sched_enqueue" ];
+	"dequeued_running" [label = "dequeued_running"];
+	"dequeued_running" -> "dequeued" [ label = "sched_switch_out" ];
+	"dequeued_running" -> "dequeued_running" [ label = "sched_set_state" ];
+	"dequeued_running" -> "own_context" [ label = "sched_enqueue" ];
+	"enqueued" [label = "enqueued", color = green3];
+	"enqueued" -> "dequeued" [ label = "sched_dequeue" ];
+	"enqueued" -> "own_context" [ label = "sched_switch_in" ];
 	"own_context" [label = "own_context"];
-	"own_context" -> "other_context" [ label = "sched_switch_out" ];
+	"own_context" -> "dequeued_running" [ label = "sched_dequeue" ];
+	"own_context" -> "enqueued" [ label = "sched_switch_out" ];
 	"own_context" -> "own_context" [ label = "sched_set_state" ];
 	{ rank = min ;
-		"__init_other_context";
-		"other_context";
+		"__init_enqueued";
+		"enqueued";
 	}
 }
-- 
2.52.0

