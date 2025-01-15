Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7622F830;
	Wed, 15 Jan 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928803; cv=none; b=UFD00h2Cp6ms48guMXTdZXxCj3x7yzBTqleAdO2u/FdiwD+jI6UczahJlz2uUx0LzJe6aHLm9F6+ODXYvklh7N26OyyNUHdmLX0RvgJntdaKRE9EupjE3U1iRB95eSDxORSHDu+XVZthzvaF5fRjDIzV2dlteji1djA4iVsVuVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928803; c=relaxed/simple;
	bh=D/y9zuH2Rlmq6apjo2bQ5wrcWbs8JsxQDr8xYOtaoxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGrvNr8PX+gePKA7C+zKDu334jeQVf3uUF+xV8Fj4D46IKV8r2j339z6IdwnzjQE1GBp0T7BOOKluSlNxAYa/wLCeovK/c1VfnWIW/Z8NjbcUc5Y0/pMis69i/HDrFelF9OeIueietPV/9rv/tmIcWl+YSio2POZnXD0HPU6+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so72702695e9.0;
        Wed, 15 Jan 2025 00:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736928800; x=1737533600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Li7vWmsT6qrjS3sZ/pi3QQmGYu2x89PKo+IEtGpH5g=;
        b=evWNDj6ThnCciNHs/0tOAfnzkPwczwSYH6qYKym+qorFlsIkIHaFwrbouV18ipxrHz
         ISELEgeYyzWing68IymKQPGRHBlW7FV6IYQFhVaMDr/fEefpyNd181z76uvC6URwwUUU
         s90iibd5ydcs76VulU/1TeGuzXw+tGBLYdH3fGaTAXA6VfO6dMbr2jArtXJgLAKc5M+t
         MA9D+AAfOSQIRcY+bbg6AEEVPpE2v3l3wbJBMLVlpEol00qqCrhfMRdhHStwyVxVVKoS
         aSGx1hH4W3zQDGpf3jNoomBnNPI3LOYSIakxGIG0fB1bLvcbOjkPnooUDTgZRDMc8nYk
         15IA==
X-Forwarded-Encrypted: i=1; AJvYcCUnQocEd4gJD0/ez6/tvZ0y7hsXjRjjCLobO/BkrFWOL3nZkxHCdI7umznchRNQtac5nnqBJiAf79etXGA=@vger.kernel.org, AJvYcCXSn2ubOvqJQRN753xvQYyinps5L619Op9Ot/NWyUTTzd2flkfV//OVcQ48doJbCq2KeTFIIP8IONS5GgtUmo9lgAv+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72kHROcLZT+aPUDu9HwGAUwgtdQX1Dgsd0Zx+y1jCXBHcBUwQ
	6/TAZU3q9767XjWwfSoCiLymSMhpq3EurSuUHUo8JL1tnmsDZpGN
X-Gm-Gg: ASbGnctJgT46Txo/+eO2nsk9cl0sN++BGkQJghVaIL0KvqLE2n7F/cpAhMuwAo0NTg7
	EE3mQ9LrnLPrFLA8gEKoUf0LTC0n/KvwncX8u5qay3j9sBebyh6nR19GCicqtUYQvpwf32aoc65
	GwXF6HY0ZCWInFMSQ7uJ0me0nLFucV4kBQSDE+6hPdq4MGyI0z04JtfrNh9iZ78MjpnjCfDIoyO
	SkPvwn+Tabd89O7POcHJKqo+LT2qy8hrrTSfuYjp54ChqC/gD+nbg25g18yFXujKy5maSC/DQ==
X-Google-Smtp-Source: AGHT+IH+VHf6Cc5OLPR2j9MaQyECIUsSd6XIJ3Y/+AY50ntccKHJ0q3hoaAn6dB7yVIFPCqW17bWPQ==
X-Received: by 2002:a05:600c:3ba0:b0:434:a802:43d with SMTP id 5b1f17b1804b1-436e27170c7mr228003455e9.27.1736928799490;
        Wed, 15 Jan 2025 00:13:19 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c4f85sm14477905e9.18.2025.01.15.00.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 00:13:18 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v2] Fix bug and add osnoise_trace_is_off()
Date: Wed, 15 Jan 2025 10:09:56 +0200
Message-ID: <20250115081157.1274398-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of trace_is_off() contains a small and elusive
bug that requires a detailed explanation.

To expose the bug, let's modify the source code by moving the first member,
`trace`, of the `osnoise_tool` structure to the second position:

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
#1  0x0000000000407db4 in osnoise_top_main (argc=argc@entry=7, argv=argv@entry=0x7fffffffe350) at src/osnoise_top.c:804
...


The program checks if trace, which has a value of 8, is not null,
and then crashes when it attempts to dereference trace->inst.

It happens because osnoise_top_main() calls trace_is_off() as:
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

Refactor `trace_is_off` and fix to `osnoise_trace_is_off` and move it to
osnoise.c because it instead of `struct trace_instance` accesses `struct
osnoise_tool`, which is out of the scope of trace.c.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

v2:
- Refactor trace_is_off() to osnoise_trace_is_off()
- Write detailed explanation

v1:
- https://lore.kernel.org/lkml/20250109211358.2619367-1-costa.shul@redhat.com/

---
 tools/tracing/rtla/src/osnoise.c       | 19 +++++++++++++++++++
 tools/tracing/rtla/src/osnoise.h       |  1 +
 tools/tracing/rtla/src/osnoise_hist.c  |  4 ++--
 tools/tracing/rtla/src/osnoise_top.c   |  4 ++--
 tools/tracing/rtla/src/timerlat_hist.c |  4 ++--
 tools/tracing/rtla/src/timerlat_top.c  |  6 +++---
 tools/tracing/rtla/src/trace.c         | 19 -------------------
 tools/tracing/rtla/src/trace.h         |  1 -
 8 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 245e9344932bc..20275642a74cd 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1079,6 +1079,25 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer)
 	return NULL;
 }
 
+int osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record)
+{
+	/*
+	 * The tool instance is always present, it is the one used to collect
+	 * data.
+	 */
+	if (!tracefs_trace_is_on(tool->trace.inst))
+		return 1;
+
+	/*
+	 * The trace record instance is only enabled when -t is set. IOW, when the system
+	 * is tracing.
+	 */
+	if (record && !tracefs_trace_is_on(record->trace.inst))
+		return 1;
+
+	return 0;
+}
+
 static void osnoise_usage(int err)
 {
 	int i;
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 555f4f4903cc2..646ee314dbaef 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -104,6 +104,7 @@ struct osnoise_tool {
 void osnoise_destroy_tool(struct osnoise_tool *top);
 struct osnoise_tool *osnoise_init_tool(char *tool_name);
 struct osnoise_tool *osnoise_init_trace_tool(char *tracer);
+int osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
 
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

