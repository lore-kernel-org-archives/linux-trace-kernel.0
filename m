Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51B12B169;
	Wed, 15 Jan 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961308; cv=none; b=babnYaxrew9T4+aKKcW6csCrK1Jc3ui0tPd2zpp2QJCl+Dd4BMkOi2S/bsBiGrpl6Tk0HtbjlpFXFx5hl5SNRXE6woNBUpa2pF9c6imeqBOBJlShGbX3GBZ8x/jQpsO/AVepVjHHzvvSIcHmJ1uEtpmbCDMWUhW7hXNUUyMIsNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961308; c=relaxed/simple;
	bh=hkFLaWRrvsVN53axst8p8285GAB3f0X9U7VVvI/9BXg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IXPqkrwFzSCb6y9vzdcTQGXL03OEcuiS14BJ/q1vPRnFn4wG9mECJ1vP0KSMBP9s6LVqp1knPyZzAnUbCxA5CQqOooInH6AqIOfHiAzudHh9RPl73pq9XzmFPnVLs58EqxjQ10vWn3ppOMgeK7TOTrezMLVHerSd2JACiSoj/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43621d27adeso48782995e9.2;
        Wed, 15 Jan 2025 09:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736961304; x=1737566104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPFebYnOBSViEnM854dgdS1aPPXkXbHEI8dfgHx5Kp0=;
        b=iaB65o7Cc0HuqPEixUBCituE/AzE+t9h1pRgxCRwFezFfeBw9Us+vakoyKMpeANslb
         WeADNh6KFEvjA22Wmi7JsekW7//LDCD0XoVyM9HwIC8WwMYP2iM0HfF9E2ywGjFstdoJ
         nMo2oDK5S8HQcKAVm388OgMUpeEgeDImbuFWdk0SIG6xzuxZFS3gFZx2+iTGx7phuN6Z
         2r8jHt7eNve9FNRjjEUtO4796PsAAHCKIfUUNyR4R+oImHgYE17Gslqvb0C+KQVVZ+GM
         YYM07t7nrXVkGDk1JYpFm1JglJ8CaJidDEnwbs6HgdvpftoPfhlAg9yif3Ce7S11gkZA
         XT6w==
X-Forwarded-Encrypted: i=1; AJvYcCUTYCh/xN+SQxZjO719kiLdKSrQYshpE9QaUpvdcoPU3URhy0X4O6Y9J4cr46SN1JCE00fPpSTYtbbsK7oRipUEu5Pi@vger.kernel.org, AJvYcCWh4YpgoaQKT3XEDJf5UA42HTjDx/6ymg165Yf/VpFtyA6MMdwRyZyKdwJFgSJm8XCLpsh7SLhpsNp27U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6YZnwFEIYUGHb/Hz8dSQ6mf1QozVFO//b4DFJQxuxAFZitzcy
	rA13q8l9tyGNWMv7nyH0C58SaYBc1eRfoU+YCKdg5W+KIa/z1Mo3
X-Gm-Gg: ASbGncv8+YXIq1xoPEes32efwmqv9uAjmSbAyC5Bxp3FbotkNyFQmUgFd8Om4XuRu7h
	C35058leN/a4F9AsiMsmGYQNVoS2fYw0NZt9Vsl4u++mDDWGb50YjFv5aXubrKf9TMRzN8a5liX
	yjt1FDxudEVX3gGkXA6IJ8j+Muj4VGxBZT0Ki2gdiKuTAXuSGM7YDpI67Z5gpa4ImoQh6jVBZCk
	ZiwZo+GGSK67xLZeiinaOO8FKNDFIkx7stdqV9VQhbZktoJKDGbXrKTKF9DPKg/DWt+rcDeoA==
X-Google-Smtp-Source: AGHT+IF4AlZwXm9BWJXSlctEIhHeGLJPCdnuQGP8Ik0trRL6nxcoSoMSuWakm8+BaB4LWucwnzp73w==
X-Received: by 2002:a05:600c:4eca:b0:434:ea21:e14f with SMTP id 5b1f17b1804b1-436e26937afmr265444195e9.13.1736961303997;
        Wed, 15 Jan 2025 09:15:03 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c475csm30710955e9.20.2025.01.15.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:15:03 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Add osnoise_trace_is_off()
Date: Wed, 15 Jan 2025 19:11:59 +0200
Message-ID: <20250115171359.1954533-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of trace_is_off() confusing, which requires a detailed
explanation.

Let's modify the source code by moving the first
member, `trace`, of the `osnoise_tool` structure to the second position:

 struct osnoise_tool {
-       struct trace_instance           trace;
        struct osnoise_context          *context;
+       struct trace_instance           trace;

A correct program would work properly after this change,
but this one does not.

Then, run the program under gdb to observe the behavior.

gdb -q --args ./rtla osnoise -D -d 2 -T 10000 -q

Program received signal SIGSEGV, Segmentation fault.
0x000000000040298f in trace_is_off (tool=tool@entry=0x418458, trace=trace@entry=0x8) at src/trace.c:538
538             if (trace && !tracefs_trace_is_on(trace->inst))
...

The program checks if trace, which has a value of 8, is not null,
and then crashes when it attempts to dereference trace->inst.

It happens because trace_is_off() is called as:
	trace_is_off(&tool->trace, &record->trace)

Where `record` is NULL. Expression `&record->trace` returns offset of
member `trace`, which is 8. The original code accidentally works because
offset of `record->trace` is zero.

Expanded wrong instructions are:
	record = NULL;
	if (&record->trace && !tracefs_trace_is_on(record->trace.inst))
		return 1;

The correct instructions are:
	record = NULL;
	if (record && !tracefs_trace_is_on(record->trace.inst))
		return 1;

Refactor `trace_is_off` to `osnoise_trace_is_off` and move it to
osnoise.c because it instead of `struct trace_instance` accesses `struct
osnoise_tool`, which is out of the scope of trace.c.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

v3:
- Dot't call a bug
- return boolean expression

v2:
- Refactor trace_is_off() to osnoise_trace_is_off()
- Write detailed explanation

---
 tools/tracing/rtla/src/osnoise.c       | 16 ++++++++++++++++
 tools/tracing/rtla/src/osnoise.h       |  1 +
 tools/tracing/rtla/src/osnoise_hist.c  |  4 ++--
 tools/tracing/rtla/src/osnoise_top.c   |  4 ++--
 tools/tracing/rtla/src/timerlat_hist.c |  4 ++--
 tools/tracing/rtla/src/timerlat_top.c  |  6 +++---
 tools/tracing/rtla/src/trace.c         | 19 -------------------
 tools/tracing/rtla/src/trace.h         |  1 -
 8 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 245e9344932bc..fcfaaff6ea164 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1079,6 +1079,22 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer)
 	return NULL;
 }
 
+bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record)
+{
+	/*
+	 * The tool instance is always present, it is the one used to collect
+	 * data.
+	 */
+	if (!tracefs_trace_is_on(tool->trace.inst))
+		return true;
+
+	/*
+	 * The trace record instance is only enabled when -t is set. IOW, when the system
+	 * is tracing.
+	 */
+	return record && !tracefs_trace_is_on(record->trace.inst);
+}
+
 static void osnoise_usage(int err)
 {
 	int i;
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 555f4f4903cc2..1dc188baddef9 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -104,6 +104,7 @@ struct osnoise_tool {
 void osnoise_destroy_tool(struct osnoise_tool *top);
 struct osnoise_tool *osnoise_init_tool(char *tool_name);
 struct osnoise_tool *osnoise_init_trace_tool(char *tracer);
+bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
 
 int osnoise_hist_main(int argc, char *argv[]);
 int osnoise_top_main(int argc, char **argv);
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 214e2c93fde01..f250f999a4eee 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -970,7 +970,7 @@ int osnoise_hist_main(int argc, char *argv[])
 			goto out_hist;
 		}
 
-		if (trace_is_off(&tool->trace, &record->trace))
+		if (osnoise_trace_is_off(tool, record))
 			break;
 	}
 
@@ -980,7 +980,7 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&tool->trace, &record->trace)) {
+	if (osnoise_trace_is_off(tool, record)) {
 		printf("rtla osnoise hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 45647495ce3bd..6d50653ae224c 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -801,7 +801,7 @@ int osnoise_top_main(int argc, char **argv)
 		if (!params->quiet)
 			osnoise_print_stats(params, tool);
 
-		if (trace_is_off(&tool->trace, &record->trace))
+		if (osnoise_trace_is_off(tool, record))
 			break;
 
 	}
@@ -810,7 +810,7 @@ int osnoise_top_main(int argc, char **argv)
 
 	return_value = 0;
 
-	if (trace_is_off(&tool->trace, &record->trace)) {
+	if (osnoise_trace_is_off(tool, record)) {
 		printf("osnoise hit stop tracing\n");
 		if (params->trace_output) {
 			printf("  Saving trace to %s\n", params->trace_output);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4403cc4eba302..ddb833ce89d01 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1342,7 +1342,7 @@ int timerlat_hist_main(int argc, char *argv[])
 			goto out_hist;
 		}
 
-		if (trace_is_off(&tool->trace, &record->trace))
+		if (osnoise_trace_is_off(tool, record))
 			break;
 
 		/* is there still any user-threads ? */
@@ -1363,7 +1363,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&tool->trace, &record->trace)) {
+	if (osnoise_trace_is_off(tool, record)) {
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 059b468981e4d..9a707c42bb1ac 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -1093,7 +1093,7 @@ int timerlat_top_main(int argc, char *argv[])
 	while (!stop_tracing) {
 		sleep(params->sleep_time);
 
-		if (params->aa_only && !trace_is_off(&top->trace, &record->trace))
+		if (params->aa_only && !osnoise_trace_is_off(top, record))
 			continue;
 
 		retval = tracefs_iterate_raw_events(trace->tep,
@@ -1110,7 +1110,7 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->quiet)
 			timerlat_print_stats(params, top);
 
-		if (trace_is_off(&top->trace, &record->trace))
+		if (osnoise_trace_is_off(top, record))
 			break;
 
 		/* is there still any user-threads ? */
@@ -1131,7 +1131,7 @@ int timerlat_top_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&top->trace, &record->trace)) {
+	if (osnoise_trace_is_off(top, record)) {
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 170a706248abf..6e24649857dd8 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -522,25 +522,6 @@ void trace_events_destroy(struct trace_instance *instance,
 	trace_events_free(events);
 }
 
-int trace_is_off(struct trace_instance *tool, struct trace_instance *trace)
-{
-	/*
-	 * The tool instance is always present, it is the one used to collect
-	 * data.
-	 */
-	if (!tracefs_trace_is_on(tool->inst))
-		return 1;
-
-	/*
-	 * The trace instance is only enabled when -t is set. IOW, when the system
-	 * is tracing.
-	 */
-	if (trace && !tracefs_trace_is_on(trace->inst))
-		return 1;
-
-	return 0;
-}
-
 /*
  * trace_set_buffer_size - set the per-cpu tracing buffer size.
  */
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index c7c92dc9a18a6..1ddb51cdaf97c 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -47,5 +47,4 @@ int trace_events_enable(struct trace_instance *instance,
 
 int trace_event_add_filter(struct trace_events *event, char *filter);
 int trace_event_add_trigger(struct trace_events *event, char *trigger);
-int trace_is_off(struct trace_instance *tool, struct trace_instance *trace);
 int trace_set_buffer_size(struct trace_instance *trace, int size);
-- 
2.47.0

