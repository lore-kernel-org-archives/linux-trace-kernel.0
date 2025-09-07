Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1E1A9B58
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Sep 2025 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757211837; cv=none; b=rXPDLWeISI0UP9G+o4gaohK7G3lftW52Qn7DZpnVo7dVwV/laRahEgyUAVFnBnB97IBhlue21TPizPBdKfWj9QW/Q95FDMg17EAxWbIOulDKxbhuOiQ3LEjUdMEUqestz3tTaka+4PJGoVtbbulGWMTAWM2OdApZ+O90Iz39aNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757211837; c=relaxed/simple;
	bh=IdEg6KVqBtGxLw7yxDzmKOK+DGGt9VNUT1+hk9qd3h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=spiwf5EbdF0cnLUtVIksVkSaabHXBmzryhAbjrusNMLW0Mcj67DMzijR9ymaiiaXrUOMUM59oX/4l5uaKiPfA+Prek53TcnCqvIF8xp3dfJfpf4/E0cufDA1zk12a641R94loYabygUCQ62OeGHavygQpySxAuOYHRMh3Xrld4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCQEUJqt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCQEUJqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757211834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9ocPo60TgXirQAeWkxeIVtYi02uBi/zlByXUvZ2pLg=;
	b=aCQEUJqti3AVrRw+C20G0TMEUSy8Hb/dJW9CSTPEvyfgnaqdhMvcqBA6Fnd5e1O3sTuURP
	vK8u02HDjRQtNgx7AsWljSO61T9/P0Cj81caLGMXXFYAhhcms8sNjPR5lhSJtRARt6cN5c
	b1mJ1SLRd4MkqTjToXNNU0FIBoU/Gq4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-KwxGpswhN5-byX9iyXIFwA-1; Sat, 06 Sep 2025 22:23:53 -0400
X-MC-Unique: KwxGpswhN5-byX9iyXIFwA-1
X-Mimecast-MFC-AGG-ID: KwxGpswhN5-byX9iyXIFwA_1757211833
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-718c2590e94so100629186d6.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Sep 2025 19:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757211832; x=1757816632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9ocPo60TgXirQAeWkxeIVtYi02uBi/zlByXUvZ2pLg=;
        b=qwUKc8Mea5qx3Vet29RDbqOJrF1+0q9DNDO+hW+nseTUa9D2mp8pURz9eP9MVV/K9g
         3eH/wKwXGwRxI5kHgeAGHzDkjZIfHgY6Wj4GGI/4x09ujcON7luxB4YJiBSkdaTo3tAL
         ANr/FSap+p3PgnBJyv9Aas6jF+93gKYDUVOnAaNVz/Lzj2fTBTdO934qu0S7agKmyiqM
         bAbK/qMDbqF+YXrpkx1SWWkq43I9NAuwYxitiyIO+dKyPs2ui95tvCOhpTaA0zKjXQy7
         RrrQS92ZB/ZOkoak8LR08r/iF+n/ubyRyensLMni92ovmrhr6WVlw2KHWjt+2Qbv1NYQ
         sIPQ==
X-Gm-Message-State: AOJu0YwemkRPjW1t6o5EKd+xIq330iFRJyQnDfoe67RfP8nPSHZvmY99
	1oHl/6b8JPrmse0pfTC7JA7k2OmIVkoLJx5HwSp5dFepsB/hWBSI2rS6DGNwPgLxKXGr9XpsA9w
	b7wQpMIU6EBccJxMU1ellVcVZNcjfVgnPzwY+dVWlrZIZRhrGfJNEuU9BBzOgHbubcZJUQFOBHw
	==
X-Gm-Gg: ASbGnctrBCkn1y1Ikhg2SxaERsmMHGRvw7Nb5qi97ylktmxmlxW2QTE8sBaDZJEm/mx
	GVnZpIdRuhOzpmTRHDmw9cK4mhliG5UIH5dxsogK8JQECtt+Ag0kcgIJ2qEwOXNtz0vgZUgx6ih
	h46Sqme1Zrgt3nUEdbALvTaJuQhEt1amXA6IGRlqPiarwB8QnbXUiFF1DB0SL/ef4orEYEvcnKM
	tGMpHzjj4ZOaeDF3sDJ0TAucnNTFGVBjvKQfp7P6Lv+kOl3m0enJoriAAwbufAe981m41SC8yNx
	yRWoB8zKr6e0LJFGNgcvlr8sFAMXazOBlf0a7MZc15B+NYltyC58bioaKcOdp3+jLHShr8M=
X-Received: by 2002:a05:622a:1887:b0:4b3:d3f2:a42d with SMTP id d75a77b69052e-4b5f845ccfcmr36628081cf.30.1757211832237;
        Sat, 06 Sep 2025 19:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgQcnokWFBhpg3sEQqH5ljiR+AlUUX2l4dJDo2YzOyORRd+SRknm9oxCLqUuR/jDv4obnRxw==
X-Received: by 2002:a05:622a:1887:b0:4b3:d3f2:a42d with SMTP id d75a77b69052e-4b5f845ccfcmr36627951cf.30.1757211831708;
        Sat, 06 Sep 2025 19:23:51 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f673fecsm71105401cf.21.2025.09.06.19.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 19:23:51 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 7/7] tools/rtla: Add remaining support for osnoise actions
Date: Sat,  6 Sep 2025 21:23:25 -0500
Message-ID: <20250907022325.243930-8-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250907022325.243930-1-crwood@redhat.com>
References: <20250907022325.243930-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LOQWVUrrvEoQUKRPQ2tGoICWYOp8Bo9bMqIn2GwCyIo_1757211833
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The basic functionality came with the consolidation; now hook up the
command line options, and add documentation and tests.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: Changed osnoise --on-threshold performance note as requested by Tomas
---
 Documentation/tools/rtla/common_options.rst   | 61 +++++++++++++++
 .../tools/rtla/common_osnoise_options.rst     |  8 ++
 .../tools/rtla/common_timerlat_options.rst    | 74 +++----------------
 Documentation/tools/rtla/rtla-hwnoise.rst     |  2 +
 .../tools/rtla/rtla-osnoise-hist.rst          |  2 +
 Documentation/tools/rtla/rtla-osnoise-top.rst |  2 +
 .../tools/rtla/rtla-timerlat-hist.rst         |  2 +
 .../tools/rtla/rtla-timerlat-top.rst          |  2 +
 tools/tracing/rtla/src/actions.c              |  8 +-
 tools/tracing/rtla/src/actions.h              |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c         | 20 +++++
 tools/tracing/rtla/src/osnoise_top.c          | 20 +++++
 tools/tracing/rtla/src/timerlat_hist.c        |  6 +-
 tools/tracing/rtla/src/timerlat_top.c         |  6 +-
 tools/tracing/rtla/tests/osnoise.t            | 27 ++++++-
 15 files changed, 168 insertions(+), 74 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index 2dc1575210aa..77ef35d3f831 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -53,6 +53,67 @@
 **--trace-buffer-size** *kB*
         Set the per-cpu trace buffer size in kB for the tracing output.
 
+**--on-threshold** *action*
+
+        Defines an action to be executed when tracing is stopped on a latency threshold
+        specified by |threshold|.
+
+        Multiple --on-threshold actions may be specified, and they will be executed in
+        the order they are provided. If any action fails, subsequent actions in the list
+        will not be executed.
+
+        Supported actions are:
+
+        - *trace[,file=<filename>]*
+
+          Saves trace output, optionally taking a filename. Alternative to -t/--trace.
+          Note that nlike -t/--trace, specifying this multiple times will result in
+          the trace being saved multiple times.
+
+        - *signal,num=<sig>,pid=<pid>*
+
+          Sends signal to process. "parent" might be specified in place of pid to target
+          the parent process of rtla.
+
+        - *shell,command=<command>*
+
+          Execute shell command.
+
+        - *continue*
+
+          Continue tracing after actions are executed instead of stopping.
+
+        Example:
+
+        $ rtla |tool| |thresharg| 20 --on-threshold trace
+        --on-threshold shell,command="grep ipi_send |tracer|\_trace.txt"
+        --on-threshold signal,num=2,pid=parent
+
+        This will save a trace with the default filename "|tracer|\_trace.txt", print its
+        lines that contain the text "ipi_send" on standard output, and send signal 2
+        (SIGINT) to the parent process.
+
+        Performance Considerations:
+
+        |actionsperf|
+
+**--on-end** *action*
+
+        Defines an action to be executed at the end of tracing.
+
+        Multiple --on-end actions can be specified, and they will be executed in the order
+        they are provided. If any action fails, subsequent actions in the list will not be
+        executed.
+
+        See the documentation for **--on-threshold** for the list of supported actions, with
+        the exception that *continue* has no effect.
+
+        Example:
+
+        $ rtla |tool| -d 5s --on-end trace
+
+        This runs rtla with the default options, and saves trace output at the end.
+
 **-h**, **--help**
 
         Print help menu.
diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.rst
index d73de2d58f5f..bd3c4f499193 100644
--- a/Documentation/tools/rtla/common_osnoise_options.rst
+++ b/Documentation/tools/rtla/common_osnoise_options.rst
@@ -1,3 +1,11 @@
+.. |threshold|  replace:: **-a/--auto**, **-s/--stop**, or **-S/--stop-total**
+.. |thresharg|  replace:: -s
+.. |tracer|     replace:: osnoise
+
+.. |actionsperf| replace::
+        Due to implementational limitations, actions might be delayed
+        up to one second after tracing is stopped.
+
 **-a**, **--auto** *us*
 
         Set the automatic trace mode. This mode sets some commonly used options
diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 7854368f1827..1f5d024b53aa 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -1,3 +1,13 @@
+.. |threshold|  replace:: **-a/--auto**, **-i/--irq**, or **-T/--thread**
+.. |thresharg|  replace:: -T
+.. |tracer|     replace:: timerlat
+
+.. |actionsperf| replace::
+        For time-sensitive actions, it is recommended to run **rtla timerlat** with BPF
+        support and RT priority. Note that due to implementational limitations, actions
+        might be delayed up to one second after tracing is stopped if BPF mode is not
+        available or disabled.
+
 **-a**, **--auto** *us*
 
         Set the automatic trace mode. This mode sets some commonly used options
@@ -55,67 +65,3 @@
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
         See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
-
-**--on-threshold** *action*
-
-        Defines an action to be executed when tracing is stopped on a latency threshold
-        specified by **-i/--irq** or **-T/--thread**.
-
-        Multiple --on-threshold actions may be specified, and they will be executed in
-        the order they are provided. If any action fails, subsequent actions in the list
-        will not be executed.
-
-        Supported actions are:
-
-        - *trace[,file=<filename>]*
-
-          Saves trace output, optionally taking a filename. Alternative to -t/--trace.
-          Note that nlike -t/--trace, specifying this multiple times will result in
-          the trace being saved multiple times.
-
-        - *signal,num=<sig>,pid=<pid>*
-
-          Sends signal to process. "parent" might be specified in place of pid to target
-          the parent process of rtla.
-
-        - *shell,command=<command>*
-
-          Execute shell command.
-
-        - *continue*
-
-          Continue tracing after actions are executed instead of stopping.
-
-        Example:
-
-        $ rtla timerlat -T 20 --on-threshold trace
-        --on-threshold shell,command="grep ipi_send timerlat_trace.txt"
-        --on-threshold signal,num=2,pid=parent
-
-        This will save a trace with the default filename "timerlat_trace.txt", print its
-        lines that contain the text "ipi_send" on standard output, and send signal 2
-        (SIGINT) to the parent process.
-
-        Performance Considerations:
-
-        For time-sensitive actions, it is recommended to run **rtla timerlat** with BPF
-        support and RT priority. Note that due to implementational limitations, actions
-        might be delayed up to one second after tracing is stopped if BPF mode is not
-        available or disabled.
-
-**--on-end** *action*
-
-        Defines an action to be executed at the end of **rtla timerlat** tracing.
-
-        Multiple --on-end actions can be specified, and they will be executed in the order
-        they are provided. If any action fails, subsequent actions in the list will not be
-        executed.
-
-        See the documentation for **--on-threshold** for the list of supported actions, with
-        the exception that *continue* has no effect.
-
-        Example:
-
-        $ rtla timerlat -d 5s --on-end trace
-
-        This runs rtla timerlat with default options and save trace output at the end.
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index fb1c52bbc00b..3a7163c02ac8 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. |tool| replace:: hwnoise
+
 ============
 rtla-hwnoise
 ============
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index f2e79d22c4c4..1fc60ef26106 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -1,3 +1,5 @@
+.. |tool| replace:: osnoise hist
+
 ===================
 rtla-osnoise-hist
 ===================
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index 5d75d1394516..b1cbd7bcd4ae 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -1,3 +1,5 @@
+.. |tool| replace:: osnoise top
+
 ===================
 rtla-osnoise-top
 ===================
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index b2d8726271b3..4923a362129b 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -1,3 +1,5 @@
+.. |tool| replace:: timerlat hist
+
 =====================
 rtla-timerlat-hist
 =====================
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index ab6cb60c9083..50968cdd2095 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -1,3 +1,5 @@
+.. |tool| replace:: timerlat top
+
 ====================
 rtla-timerlat-top
 ====================
diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index aaf0808125d7..991139f9069f 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -127,17 +127,17 @@ actions_add_continue(struct actions *self)
  * actions_parse - add an action based on text specification
  */
 int
-actions_parse(struct actions *self, const char *trigger)
+actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 {
 	enum action_type type = ACTION_NONE;
-	char *token;
+	const char *token;
 	char trigger_c[strlen(trigger)];
 
 	/* For ACTION_SIGNAL */
 	int signal = 0, pid = 0;
 
 	/* For ACTION_TRACE_OUTPUT */
-	char *trace_output;
+	const char *trace_output;
 
 	strcpy(trigger_c, trigger);
 	token = strtok(trigger_c, ",");
@@ -160,7 +160,7 @@ actions_parse(struct actions *self, const char *trigger)
 	case ACTION_TRACE_OUTPUT:
 		/* Takes no argument */
 		if (token == NULL)
-			trace_output = "timerlat_trace.txt";
+			trace_output = tracefn;
 		else {
 			if (strlen(token) > 5 && strncmp(token, "file=", 5) == 0) {
 				trace_output = token + 5;
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index b10a19d55c49..a4f9b570775b 100644
--- a/tools/tracing/rtla/src/actions.h
+++ b/tools/tracing/rtla/src/actions.h
@@ -48,5 +48,5 @@ int actions_add_trace_output(struct actions *self, const char *trace_output);
 int actions_add_signal(struct actions *self, int signal, int pid);
 int actions_add_shell(struct actions *self, const char *command);
 int actions_add_continue(struct actions *self);
-int actions_parse(struct actions *self, const char *trigger);
+int actions_parse(struct actions *self, const char *trigger, const char *tracefn);
 int actions_perform(struct actions *self);
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 2c2cdd467a67..dffb6d0a98d7 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -462,6 +462,8 @@ static void osnoise_hist_usage(char *usage)
 		"						       in nanoseconds",
 		"	     --warm-up: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
+		"	     --on-threshold <action>: define action to be executed at stop-total threshold, multiple are allowed",
+		"	     --on-end <action>: define action to be executed at measurement end, multiple are allowed",
 		NULL,
 	};
 
@@ -531,6 +533,8 @@ static struct common_params
 			{"filter",		required_argument,	0, '5'},
 			{"warm-up",		required_argument,	0, '6'},
 			{"trace-buffer-size",	required_argument,	0, '7'},
+			{"on-threshold",	required_argument,	0, '8'},
+			{"on-end",		required_argument,	0, '9'},
 			{0, 0, 0, 0}
 		};
 
@@ -692,6 +696,22 @@ static struct common_params
 		case '7':
 			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
+		case '8':
+			retval = actions_parse(&params->common.threshold_actions, optarg,
+					       "osnoise_trace.txt");
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case '9':
+			retval = actions_parse(&params->common.end_actions, optarg,
+					       "osnoise_trace.txt");
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
 		default:
 			osnoise_hist_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 5a56c276f9da..95418f7ecc96 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -291,6 +291,8 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 		"						       in nanoseconds",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
+		"	     --on-threshold <action>: define action to be executed at stop-total threshold, multiple are allowed",
+		"	     --on-end: define action to be executed at measurement end, multiple are allowed",
 		NULL,
 	};
 
@@ -371,6 +373,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			{"filter",		required_argument,	0, '1'},
 			{"warm-up",		required_argument,	0, '2'},
 			{"trace-buffer-size",	required_argument,	0, '3'},
+			{"on-threshold",	required_argument,	0, '4'},
+			{"on-end",		required_argument,	0, '5'},
 			{0, 0, 0, 0}
 		};
 
@@ -511,6 +515,22 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case '3':
 			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
+		case '4':
+			retval = actions_parse(&params->common.threshold_actions, optarg,
+					       "osnoise_trace.txt");
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case '5':
+			retval = actions_parse(&params->common.end_actions, optarg,
+					       "osnoise_trace.txt");
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
 		default:
 			osnoise_top_usage(params, "Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a9154f83f1a9..606c1688057b 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1047,14 +1047,16 @@ static struct common_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '\5':
-			retval = actions_parse(&params->common.threshold_actions, optarg);
+			retval = actions_parse(&params->common.threshold_actions, optarg,
+					       "timerlat_trace.txt");
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case '\6':
-			retval = actions_parse(&params->common.end_actions, optarg);
+			retval = actions_parse(&params->common.end_actions, optarg,
+					       "timerlat_trace.txt");
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 4f1ce72d6a05..fc479a0dcb59 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -783,14 +783,16 @@ static struct common_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '9':
-			retval = actions_parse(&params->common.threshold_actions, optarg);
+			retval = actions_parse(&params->common.threshold_actions, optarg,
+					       "timerlat_trace.txt");
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case '\1':
-			retval = actions_parse(&params->common.end_actions, optarg);
+			retval = actions_parse(&params->common.end_actions, optarg,
+					       "timerlat_trace.txt");
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 7574ec6a5a53..e3c89d45a6bb 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -8,7 +8,8 @@ set_timeout 2m
 check "verify help page" \
 	"osnoise --help" 0 "osnoise version"
 check "verify the --priority/-P param" \
-	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q"
+	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh osnoise/ SCHED_FIFO 1\"" \
+	2 "Priorities are set correctly"
 check "verify the --stop/-s param" \
 	"osnoise top -s 30 -T 1" 2 "osnoise hit stop tracing"
 check "verify the  --trace param" \
@@ -22,4 +23,28 @@ check "verify the --entries/-E param" \
 check_with_osnoise_options "apply default period" \
 	"osnoise hist -s 1" 2 period_us=600000000
 
+# Actions tests
+check "trace output through -t with custom filename" \
+	"osnoise hist -S 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check "trace output through --on-threshold trace" \
+	"osnoise hist -S 2 --on-threshold trace" 2 "^  Saving trace to osnoise_trace.txt$"
+check "trace output through --on-threshold trace with custom filename" \
+	"osnoise hist -S 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check "exec command" \
+	"osnoise hist -S 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
+check "multiple actions" \
+	"osnoise hist -S 2 --on-threshold shell,command='echo -n 1' --on-threshold shell,command='echo 2'" 2 "^12$"
+check "hist stop at failed action" \
+	"osnoise hist -S 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA osnoise histogram$"
+check "top stop at failed action" \
+	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
+check "hist with continue" \
+	"osnoise hist -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check "top with continue" \
+	"osnoise top -q -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check "hist with trace output at end" \
+	"osnoise hist -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
+check "top with trace output at end" \
+	"osnoise top -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
+
 test_end
-- 
2.48.1

