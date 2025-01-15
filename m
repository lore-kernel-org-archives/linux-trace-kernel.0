Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95624A7EB;
	Wed, 15 Jan 2025 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736964243; cv=none; b=gGD8BahvcvnqKdIr3kNGWarfKt6vB7PsxRYTvFiytt0bzS6jh1Mr5C0S/tjSDKSEu3IVkIbtxJomxwQXpw4v/iNTd2ThT6DU/bf/xTjWmKrMKEWGVV6tUW45ziTUQbomZm3DWGkiqoR/UHtQ/Va104FlxtXQvqADNgpG6ug8QGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736964243; c=relaxed/simple;
	bh=AEHafNGjSqXJskXmrjbBVUcm5zhjEDn1SvAkgmEonT4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K8oz+poomYGyr0NK7PVBSdZ/nIPhIv7Pr44lGg7Vdirwm9F152fzIoZ0iCi07on8GW+A4dw7Qrzph4MgeI//Uks1+2kmVsTwB1SJC8Ms0TU5kkOmINubBYEZv6n61TzSDuTStAWUtus0/pOkr0oQRQdQXtdJ5OoNynrilpT3zbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43621d27adeso49134285e9.2;
        Wed, 15 Jan 2025 10:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736964240; x=1737569040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hRQaiZRg0HDSdfP5/r9LSNCjwxft6Ztf5T8LAR7WT4=;
        b=XQ+DbYABn0fcHQoz4ogrIcj0Ji5s+rd4zWdiMShDLfN3pRN8E5g2+rLCbPSN+9xNJy
         oOEHSbmoq084tJV6MC6mSw1OKcfwswE5Ts6X4BR2d1arS6qW1L41MI5gcFn2uAaV1jKO
         mZGY6EjAiAc/j/0uq6ZM7tsewn+b1ti7b/sWKfYr8ihenQLqZ+liTsUplStqwpsZ3D4V
         v8lJ7kWdMYcfkZFU4ir64qulim4pCvq9ySJP80XbW6mjri/TUg97I06aM/ZwXN3jvVOa
         NJm5cEhxb97DaDKVYOYM0wsHTLAjO03jAkQujpOd7igKoTtzxlzhylDi9jC4XO1T1ZCm
         dsEw==
X-Forwarded-Encrypted: i=1; AJvYcCUNOc0kcXRdnAYAcNzeVA2dWs/yzMcMAkZvAWjY9VOm9vXAIQALMjhPqswfex8KYOMXTzcveFpaolIA81I=@vger.kernel.org, AJvYcCVSw+/0paCC7cv3TQQgs+kjCuvKLNwJIOVvuQQrX9Vc7eY3c/h+lBNUYiZ/a0oxGhEDhrhN3KAcY9J0uUv5zUYaD/Dw@vger.kernel.org
X-Gm-Message-State: AOJu0Yylqa2/MJXAelT7PooGU5kfLoWuXqTHcSphsV4zQNSIsy7vcLsH
	NE/yEeipaPD/etbm1AyG/qULcdPua1srDByrXr6rn47QGX8Pii6/
X-Gm-Gg: ASbGncumTNPOHYWKVe9Sx/ACobH9VeLeWAIQC5lZ7p3db7vhuqWHtrtiU3o0CwDzPrF
	QpE91Ag4wgoLaQ7E0dXTudubSmXTJA3xumCXiGW6XbFe3+sopyysT1GZ1hWXsSSPtKtvlHkQ1DW
	ibEnB3uP3XGYTopb35LxPQlDWMSpNSuZC12fZvI+6whe+1Owsl9Ex370pTw/UgAdQqlIrcldF0C
	A06js+Q2HScs10He144ZXjhl6B16h/5qm8hepvgKp/DUhGMdMP95U0OlUfUG4796r409fwOMw==
X-Google-Smtp-Source: AGHT+IGmmsmGMwtI4p7OJIws5LXxTd7mfzSv5QhLRXHXlKOCwC0/Dk8y6DPeFjsq6h/alfkABAN+Yg==
X-Received: by 2002:a5d:59a3:0:b0:38a:9ed4:9fff with SMTP id ffacd0b85a97d-38a9ed4b538mr16391549f8f.51.1736964239651;
        Wed, 15 Jan 2025 10:03:59 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38332asm18019233f8f.23.2025.01.15.10.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 10:03:59 -0800 (PST)
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
Subject: [PATCH v4] tools/rtla: Add osnoise_trace_is_off()
Date: Wed, 15 Jan 2025 19:58:30 +0200
Message-ID: <20250115180055.2136815-1-costa.shul@redhat.com>
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
v4:
- Add prefix to the subject

v3:
- Dot't call a bug
- return boolean expression

v2:
- Refactor trace_is_off() to osnoise_trace_is_off()
- Write detailed explanation

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
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

