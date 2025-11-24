Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164A2D9EE3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763965966; cv=none; b=LMJpVnJGA5d56sFlT3ObttREhm+pLen3D+FTetBB2j/zBj2wiPwnf4q9wUfegJcBW9Y8uyP/rMW9xD+4fXyVEGCsDLQev0hsqJAEk2mOGKTSi120El/n2xcWuRSGmmEjSAn1C0ZnVEUyn4u25aD7Ng97AHObbfvOSSoGIO6PJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763965966; c=relaxed/simple;
	bh=jvhIYdmBV7WMh9lpR7C7Sy/+S3cErNUU1G3Spu735eI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=HeWDXXwTgPR1QfDQygW5TakUlmiBs+KiW1WjXKob27U+IWBKSzWdPxs+jeeqms9AjDr4lwkaZVhFPqsGIEE2hUQYkfvo4Q1FRQ3iPmUYDkY/BKXmVRnS7aO8utdkwiaVv2hS/NPhfuDKgNhApRcskn6vSY1q9PatFdaqqLhRrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nk4C8Y6v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nk4C8Y6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763965962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v5yar6OuDB0ADcv8NH2WOeZJwh0vqiudRWLgOAL+k3Y=;
	b=Nk4C8Y6veJpSgoerrC6nl4dR2JdbdaDYdviCwAejfk2iBgQoow+Cjwxko3SKlu5e/Asmde
	dAA6+/Hur0fOTQ+QlJFIUqkLYsFQAvwBElVvbcMT1VAVr1KuK7/6DhZbDK7Zt+YocAkkuH
	J4IOn7DGEZ1baxxWGQinlvL6K3txPTw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-DRgn9Ys5NqyjWXUizxRZ-g-1; Mon, 24 Nov 2025 01:32:24 -0500
X-MC-Unique: DRgn9Ys5NqyjWXUizxRZ-g-1
X-Mimecast-MFC-AGG-ID: DRgn9Ys5NqyjWXUizxRZ-g_1763965944
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477a11d9f89so19499375e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Nov 2025 22:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763965944; x=1764570744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5yar6OuDB0ADcv8NH2WOeZJwh0vqiudRWLgOAL+k3Y=;
        b=XX6FdF2SAigrhObNsFpiD9FwJE1G5rHQfLEXj9mcYCvDG2f2Ajc/DFjQJSgnoULY1i
         EKieQCGK3pb+Ri3HKeyTQ1O3zxItH4/8XChwpHhzs9+4hPSant9O/itl6/NO9psktEph
         eQSqAXZCxEyHiGhU+I9K11QsYexTV9t6kbbyEUQgaiNXWa5YCBjp28vIlifMov0tZg5H
         EOyVzuKm3kzlR+YudnmL4nhOhVuthB+/Lun9U7P3cOiiJgXlF/NajF2FYoqE61yOQIQe
         BQ5xxBQn6rD1Fl8xzvN1TFn7u5Vho7hf0Wr0VQlQEIRdOj7DbTbFm+xqLnxYcUXN1wOD
         Yhaw==
X-Forwarded-Encrypted: i=1; AJvYcCXvquptIPA8nCN8aE45Vximkq65q5Atk7DcDVEeS6lxgeA+EkBIwDRityXE4HSxVm74c7BQCyAvmNQKPEKUU+mbpKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4kG439u1/lu9zLnvmsBHc3iGzxKJgRpoux7fkfl4gYsBTPVq
	xguRHfqyt3upL8Zt6ks3+saADtAkozDeb2eR47PjzaSQHUU+ATypLNNkmee8T9bxWVqm/GJLcQw
	a390hCjYniC2lPOZ7oSQzexUwyphylDS6tvuoYIt7SnX4HGoN0Gtb+fl61yDin6nH5DoOsJaAOA
	==
X-Gm-Gg: ASbGncvpBfCCQDw7mmC0cOjp/YBzVcxqRXzZVxIMe8MZmDpuTq3lMoTpcJuUuiUtnux
	QyyufGkrcyo+4f0wEQo/9Lz80zsGR2EDpvySJSL95MIG0xBBiGJCKk5SBrtXdNjTsPz560k/81x
	rrMFv2dXMcCHoEuqyqylbO37EeXhzVMQGFqUUDa00+YJ59PefLU/hY58xlnr4CPzvJV3F7HPT0T
	YOiaShi7U8EoqFCKvE6Lf+xrN5EyRUI8ezUGDVhL8jKoVyd15lHwF3qYhhwJNPY73FdXMea95fe
	AFA8LgLo3UXwXu1gaEHLPQY3ybytkpLfUSzgmKxIzRb+Nmh4i0ydqs+kdocXyODzmqvcqN3TZ/+
	tIGsgJlng6Led0cvmeMCWriilvFc=
X-Received: by 2002:a05:600c:3b09:b0:477:a3f9:fda5 with SMTP id 5b1f17b1804b1-477c016e425mr78181435e9.9.1763965943515;
        Sun, 23 Nov 2025 22:32:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPJb4dKcAq+naHixjVdeC3U+dNG95F4YpemwqmrEUxnYdSW/kUpDzgh7GZ3Iu9BIDXr2931Q==
X-Received: by 2002:a05:600c:3b09:b0:477:a3f9:fda5 with SMTP id 5b1f17b1804b1-477c016e425mr78181255e9.9.1763965943093;
        Sun, 23 Nov 2025 22:32:23 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477aa387473sm143912575e9.4.2025.11.23.22.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 22:32:22 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Add common_usage()
Date: Mon, 24 Nov 2025 08:31:46 +0200
Message-ID: <20251124063204.845425-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jdpRoDHvDbWnux1BLpxA2RhQ7kxZN3b3Pk_NNlYdhX8_1763965944
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The rtla tools have significant code quadruplication in their usage
functions. Each tool implements its own version of the same help text
formatting and option descriptions, leading to maintenance overhead and
inconsistencies.  Documentation/tools/rtla/common_options.rst lists 14
common options.

Add common_usage() infrastructure to consolidate help formatting.
Subsequent patches will extend this to handle other common options.

The refactored output is almost identical to the original, with the
following changes:
- add square brackets to specify optionality: `usage: [rtla] ...`
- remove `-q` from timerlat hist because hist tools don't support it
- minor spacing

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 39 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/common.h        |  3 ++
 tools/tracing/rtla/src/osnoise_hist.c  | 22 ++++++---------
 tools/tracing/rtla/src/osnoise_top.c   | 37 ++++++++++--------------
 tools/tracing/rtla/src/timerlat_hist.c | 22 ++++++---------
 tools/tracing/rtla/src/timerlat_top.c  | 22 ++++++---------
 6 files changed, 81 insertions(+), 64 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index b197037fc58b..18b92c5e4b1a 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -4,6 +4,7 @@
 #include <pthread.h>
 #include <signal.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include "common.h"
 
@@ -348,3 +349,41 @@ int hist_main_loop(struct osnoise_tool *tool)
 
 	return retval;
 }
+
+static void print_msg_array(const char * const *msgs)
+{
+	if (!msgs)
+		return;
+
+	for (int i = 0; msgs[i]; i++)
+		fprintf(stderr, "%s\n", msgs[i]);
+}
+
+/*
+ * common_usage - print complete usage information
+ */
+void common_usage(const char *tool, const char *mode,
+		  const char *desc, const char * const *start_msgs, const char * const *opt_msgs)
+{
+	static const char * const common_options[] = {
+		"	  -h/--help: print this menu",
+		NULL
+	};
+	fprintf(stderr, "rtla %s", tool);
+	if (strcmp(mode, ""))
+		fprintf(stderr, " %s", mode);
+	fprintf(stderr, ": %s (version %s)\n\n", desc, VERSION);
+	fprintf(stderr, "  usage: [rtla] %s ", tool);
+
+	if (strcmp(mode, "top") == 0)
+		fprintf(stderr, "[top] [-h] ");
+	else
+		fprintf(stderr, "%s [-h] ", mode);
+
+	print_msg_array(start_msgs);
+	fprintf(stderr, "\n");
+	print_msg_array(common_options);
+	print_msg_array(opt_msgs);
+
+	exit(EXIT_SUCCESS);
+}
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 9ec2b7632c37..b44e910ba72c 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -156,3 +156,6 @@ bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record
 int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
 int top_main_loop(struct osnoise_tool *tool);
 int hist_main_loop(struct osnoise_tool *tool);
+
+void common_usage(const char *tool, const char *mode,
+		  const char *desc, const char * const *start_msgs, const char * const *opt_msgs);
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index ff8c231e47c4..372128db9e4a 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -409,16 +409,15 @@ osnoise_print_stats(struct osnoise_tool *tool)
  */
 static void osnoise_hist_usage(void)
 {
-	int i;
-
-	static const char * const msg[] = {
-		"",
-		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
+	static const char * const msg_start[] = {
+		"[-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
 		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] \\",
 		"	  [--no-index] [--with-zeros] [-C [cgroup_name]] [--warm-up]",
-		"",
-		"	  -h/--help: print this menu",
+		NULL,
+	};
+
+	static const char * const msg_opts[] = {
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
 		"	  -p/--period us: osnoise period in us",
 		"	  -r/--runtime us: osnoise runtime in us",
@@ -453,13 +452,8 @@ static void osnoise_hist_usage(void)
 		NULL,
 	};
 
-	fprintf(stderr, "rtla osnoise hist: a per-cpu histogram of the OS noise (version %s)\n",
-			VERSION);
-
-	for (i = 0; msg[i]; i++)
-		fprintf(stderr, "%s\n", msg[i]);
-
-	exit(EXIT_SUCCESS);
+	common_usage("osnoise", "hist", "a per-cpu histogram of the OS noise",
+		     msg_start, msg_opts);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 04c699bdd736..1db1d946b600 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -257,14 +257,16 @@ osnoise_print_stats(struct osnoise_tool *top)
  */
 static void osnoise_top_usage(struct osnoise_params *params)
 {
-	int i;
+	const char *tool, *mode, *desc;
 
-	static const char * const msg[] = {
-		" [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
+	static const char * const msg_start[] = {
+		"[-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
 		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-C [cgroup_name]] [--warm-up s]",
-		"",
-		"	  -h/--help: print this menu",
+		NULL,
+	};
+
+	static const char * const msg_opts[] = {
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
 		"	  -p/--period us: osnoise period in us",
 		"	  -r/--runtime us: osnoise runtime in us",
@@ -295,25 +297,16 @@ static void osnoise_top_usage(struct osnoise_params *params)
 	};
 
 	if (params->mode == MODE_OSNOISE) {
-		fprintf(stderr,
-			"rtla osnoise top: a per-cpu summary of the OS noise (version %s)\n",
-			VERSION);
-
-		fprintf(stderr, "  usage: rtla osnoise [top]");
+		tool = "osnoise";
+		mode = "top";
+		desc = "a per-cpu summary of the OS noise";
+	} else {
+		tool = "hwnoise";
+		mode = "";
+		desc = "a summary of hardware-related noise";
 	}
 
-	if (params->mode == MODE_HWNOISE) {
-		fprintf(stderr,
-			"rtla hwnoise: a summary of hardware-related noise (version %s)\n",
-			VERSION);
-
-		fprintf(stderr, "  usage: rtla hwnoise");
-	}
-
-	for (i = 0; msg[i]; i++)
-		fprintf(stderr, "%s\n", msg[i]);
-
-	exit(EXIT_SUCCESS);
+	common_usage(tool, mode, desc, msg_start, msg_opts);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 1fb471a787b7..2a5c543217ba 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -696,17 +696,16 @@ timerlat_print_stats(struct osnoise_tool *tool)
  */
 static void timerlat_hist_usage(void)
 {
-	int i;
-
-	char *msg[] = {
-		"",
-		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
+	static const char * const msg_start[] = {
+		"[-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
 		"         [-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
 		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C [cgroup_name]] [--no-aa] [--dump-task] [-u|-k]",
 		"	  [--warm-up s] [--deepest-idle-state n]",
-		"",
-		"	  -h/--help: print this menu",
+		NULL,
+	};
+
+	static const char * const msg_opts[] = {
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
 		"	  -p/--period us: timerlat period in us",
 		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
@@ -750,13 +749,8 @@ static void timerlat_hist_usage(void)
 		NULL,
 	};
 
-	fprintf(stderr, "rtla timerlat hist: a per-cpu histogram of the timer latency (version %s)\n",
-			VERSION);
-
-	for (i = 0; msg[i]; i++)
-		fprintf(stderr, "%s\n", msg[i]);
-
-	exit(EXIT_SUCCESS);
+	common_usage("timerlat", "hist", "a per-cpu histogram of the timer latency",
+		     msg_start, msg_opts);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 29c2c1f717ed..9ed8b931552f 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -476,15 +476,14 @@ timerlat_print_stats(struct osnoise_tool *top)
  */
 static void timerlat_top_usage(void)
 {
-	int i;
-
-	static const char *const msg[] = {
-		"",
-		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
+	static const char *const msg_start[] = {
+		"[-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C [cgroup_name]] [-u|-k] [--warm-up s] [--deepest-idle-state n]",
-		"",
-		"	  -h/--help: print this menu",
+		NULL,
+	};
+
+	static const char *const msg_opts[] = {
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
 		"	     --aa-only us: stop if <us> latency is hit, only printing the auto analysis (reduces CPU usage)",
 		"	  -p/--period us: timerlat period in us",
@@ -522,13 +521,8 @@ static void timerlat_top_usage(void)
 		NULL,
 	};
 
-	fprintf(stderr, "rtla timerlat top: a per-cpu summary of the timer latency (version %s)\n",
-			VERSION);
-
-	for (i = 0; msg[i]; i++)
-		fprintf(stderr, "%s\n", msg[i]);
-
-	exit(EXIT_SUCCESS);
+	common_usage("timerlat", "top", "a per-cpu summary of the timer latency",
+		     msg_start, msg_opts);
 }
 
 /*
-- 
2.51.1

