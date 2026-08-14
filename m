Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6163093A6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715758; cv=none; b=R+BzLqWJqgpUyW6FsJwJGwdEwigvc6zF2XAF6WGnphYYJOaLw8xfmAlVcT87tqrMSMdztOYKTPoHW+NTh2t0V1cTPf31G5EVdixzLeVvMnd1du+K39viaBt0pStS0PX7M9Pw0cLWok+uHSC+7gZOyFJmYRnlIrFF/whp3vwThy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715758; c=relaxed/simple;
	bh=IRWyeDss8AzJXYcxQwjh6lwDI9oTvVnsq1azhn6lRHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=c94p65TT54Zqn00NzLuiFPOTcSHfHJxiovLHvqRGyGgzkukTQKsoPBiAT/NeUzZBQgC683oGUwUmxHFoBfbdrv6W0VWmYU629wisfteXZBlCC/EU8F8o8i8X3uNLCH2YOn+oOeA1gLpu5yBlnfNT0LTml9bPEXHUBzFvwIrHAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTQeHlCh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTQeHlCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786715750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQVggIH8ORhajW5nD23gxwpj3+1PtrZ19MQ1dN70VbM=;
	b=VTQeHlChsSzUfsJUEM4Lf6a+HuTDA/B0FZpqoDhiutSmub7aJqOv0dwGQmoFXPEW2MnkSj
	bVbg5UueiuiHopZgnFCxNxsl+V61b3NtOqRxZ1wVn07jljenyjSvSgyOYrLCuIS4aMjdrQ
	Q/Z7fBW7zG99UTG+R37oAy1YsR1Eq+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-obtwRG-YPByfmqNbpuynIQ-1; Fri,
 14 Aug 2026 09:55:41 -0400
X-MC-Unique: obtwRG-YPByfmqNbpuynIQ-1
X-Mimecast-MFC-AGG-ID: obtwRG-YPByfmqNbpuynIQ_1786715740
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C710195605E;
	Fri, 14 Aug 2026 13:55:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 887671800347;
	Fri, 14 Aug 2026 13:55:37 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 2/5] rtla: Discard trace entries with cpu >= nr_cpus
Date: Fri, 14 Aug 2026 15:55:08 +0200
Message-ID: <20260814135511.2207190-3-tglozar@redhat.com>
In-Reply-To: <20260814135511.2207190-1-tglozar@redhat.com>
References: <20260814135511.2207190-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: tgS1_xN_ncjiPbyrD_tYfaDpebfilrtv2P4tUjq0zA8_1786715740
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The "cpu" field of trace entries processed by rtla in tracefs mode is
used as an index into an array of size nr_cpus. In case the cpu numbers
mismatch because either the kernel or rtla reporting the number
incorrectly, out-of-bounds read/write may occur.

Guard against this by dropping trace entries with cpu >= nr_cpus in
collect_registered_events(). A new counter, "invalid_events", is added
to struct trace_instance, and printed (if non zero) next to the
pre-existing missed events counter.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/common.h        |  2 --
 tools/tracing/rtla/src/osnoise.c       | 26 +++++++++++++++++++++++++-
 tools/tracing/rtla/src/osnoise.h       |  2 ++
 tools/tracing/rtla/src/osnoise_hist.c  |  1 +
 tools/tracing/rtla/src/osnoise_top.c   |  1 +
 tools/tracing/rtla/src/timerlat_hist.c |  1 +
 tools/tracing/rtla/src/timerlat_top.c  |  1 +
 tools/tracing/rtla/src/trace.c         |  7 +++++++
 tools/tracing/rtla/src/trace.h         |  1 +
 tools/tracing/rtla/src/utils.h         |  2 ++
 10 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 04b287a03f6d4..051d56182276b 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -114,8 +114,6 @@ struct common_params {
 	struct timerlat_u_params user;
 };
 
-extern int nr_cpus;
-
 #define for_each_monitored_cpu(cpu, common) \
 	for (cpu = 0; cpu < nr_cpus; cpu++) \
 		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 4ff5dad013b10..b9bcbf9ee430c 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1224,6 +1224,29 @@ bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record
 	return record && !tracefs_trace_is_on(record->trace.inst);
 }
 
+/*
+ * osnoise_report_invalid_events - report number of invalid events
+ */
+void
+osnoise_report_invalid_events(struct osnoise_tool *tool)
+{
+	unsigned long long total_events;
+
+	if (tool->trace.invalid_events > 0) {
+		if (tool->trace.missed_events != UINT64_MAX) {
+			total_events = tool->trace.processed_events + tool->trace.invalid_events +
+				tool->trace.missed_events;
+
+			printf("%lld (%.2f%%) invalid events, results might not be accurate\n",
+				tool->trace.invalid_events,
+				(double) tool->trace.invalid_events / total_events * 100.0);
+		} else {
+			printf("%lld invalid events, results might not be accurate\n",
+				tool->trace.invalid_events);
+		}
+	}
+}
+
 /*
  * osnoise_report_missed_events - report number of events dropped by trace
  * buffer
@@ -1236,7 +1259,8 @@ osnoise_report_missed_events(struct osnoise_tool *tool)
 	if (tool->trace.missed_events == UINT64_MAX)
 		printf("unknown number of events missed, results might not be accurate\n");
 	else if (tool->trace.missed_events > 0) {
-		total_events = tool->trace.processed_events + tool->trace.missed_events;
+		total_events = tool->trace.processed_events + tool->trace.invalid_events +
+			tool->trace.missed_events;
 
 		printf("%lld (%.2f%%) events missed, results might not be accurate\n",
 		       tool->trace.missed_events,
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 340ff5a64e6e4..b54e9ebef7f27 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -56,6 +56,8 @@ void osnoise_restore_timerlat_align_us(struct osnoise_context *context);
 int osnoise_set_timerlat_align(struct osnoise_context *context, bool onoff);
 
 int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
+
+void osnoise_report_invalid_events(struct osnoise_tool *tool);
 void osnoise_report_missed_events(struct osnoise_tool *tool);
 int osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params);
 
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index dfa91d0681f8f..bad0b8958ddb2 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -397,6 +397,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 	trace_seq_reset(trace->seq);
 
 	osnoise_print_summary(params, trace, data);
+	osnoise_report_invalid_events(tool);
 	osnoise_report_missed_events(tool);
 }
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 512a6299cb018..3c0ff82a4b5c8 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -242,6 +242,7 @@ osnoise_print_stats(struct osnoise_tool *top)
 
 	trace_seq_do_printf(trace->seq);
 	trace_seq_reset(trace->seq);
+	osnoise_report_invalid_events(top);
 	osnoise_report_missed_events(top);
 }
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index df7b1398a966d..b6af5ba11340d 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -682,6 +682,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 
 	timerlat_print_summary(params, trace, data);
 	timerlat_print_stats_all(params, trace, data);
+	osnoise_report_invalid_events(tool);
 	osnoise_report_missed_events(tool);
 }
 
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 6206a0a565ad3..2afd619c16059 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -456,6 +456,7 @@ timerlat_print_stats(struct osnoise_tool *top)
 
 	trace_seq_do_printf(trace->seq);
 	trace_seq_reset(trace->seq);
+	osnoise_report_invalid_events(top);
 	osnoise_report_missed_events(top);
 }
 
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index e407447773d04..1c3e2b098ba81 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -138,6 +138,12 @@ collect_registered_events(struct tep_event *event, struct tep_record *record,
 	struct trace_instance *trace = context;
 	struct trace_seq *s = trace->seq;
 
+	if (cpu >= nr_cpus) {
+		/* Kernel reports event on CPU we don't see, corrupt data? */
+		trace->invalid_events++;
+		return 0;
+	}
+
 	trace->processed_events++;
 
 	if (!event->handler)
@@ -236,6 +242,7 @@ int trace_instance_init(struct trace_instance *trace, char *tool_name)
 				     trace);
 
 	trace->processed_events = 0;
+	trace->invalid_events = 0;
 
 	return 0;
 
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 95b911a2228b2..715a3616fe45a 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -18,6 +18,7 @@ struct trace_instance {
 	struct tep_handle		*tep;
 	struct trace_seq		*seq;
 	unsigned long long		missed_events;
+	unsigned long long		invalid_events;
 	unsigned long long		processed_events;
 };
 
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index c26ba8827947a..2579e7fa08be6 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -40,6 +40,8 @@ static inline bool str_has_prefix(const char *str, const char *prefix)
 }
 
 extern bool config_debug;
+extern int nr_cpus;
+
 void debug_msg(const char *fmt, ...);
 void err_msg(const char *fmt, ...);
 void fatal(const char *fmt, ...);
-- 
2.55.0

