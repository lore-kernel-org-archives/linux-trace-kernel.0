Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0272773D8
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Nov 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763835093; cv=none; b=W9uSTvqrdeNCxCr8yCmqQYnWQSYt/8ZP8qn9SK1gEJA8hll4bx4nvbXej3QCvmFZSllWcQOml2iWSDL8BBeumNfuHyMFGryXigC8Q4XfMmyRolKYW62mH/iHqiO9VNTyx2coHVLPL0OvYiExz/gk2UItU3xeHYCfgx4mjAVMSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763835093; c=relaxed/simple;
	bh=hNRkJszpmONpH7M+H648/cMwW8E8Ceo7gW4GD7VBLoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=eJqIE2Wl30yVlY1acL6MaFkN1yneJehLxAQCIpPR0+vV8MG0oSXL/WKvMX1VCoF9t9QgqxpO6IRiWScAyvthlfNBjcr+C9ErloAY7Yz0tsXdN5bGglYE4bInQSw1QYAIvO9srj8US8d0HNQskn88fWouYyhOKn6VNb+cI9YW/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDRBJpvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDRBJpvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763835089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=64FDk5QPM+r1304yXPnboc9hDTs3kZ1joofpjnZosCw=;
	b=GDRBJpvN0vt/TYMk8Myl+3QYF+a2JcvmKgUSGHCbheZ9erWyAyVDIhel4EsfcDUnKNDmnp
	3NpURMSTRqebfY6Qw+xOIS5GNEQaK4Jkrkx7k5sy0ymqtzGeF7BrbOSrBcJPfXUQ/NSoAW
	W7SN3Ftyo9akh/1wa87aRmI1rdH5jFM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Gdxq3SgkOVW2gr5caTBV5w-1; Sat, 22 Nov 2025 13:11:28 -0500
X-MC-Unique: Gdxq3SgkOVW2gr5caTBV5w-1
X-Mimecast-MFC-AGG-ID: Gdxq3SgkOVW2gr5caTBV5w_1763835086
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2ffbba05so1557142f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Nov 2025 10:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763835086; x=1764439886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64FDk5QPM+r1304yXPnboc9hDTs3kZ1joofpjnZosCw=;
        b=GtgXviMNy7bJzECoUSagQcJL1zL/mizpvquvXAotjK01iBwKQclRiLFbivA7pNwrRj
         T+5Tq5uxwt3ddAR88Id8CVbdDqOAtjQqu/wHRjrvglOy8y3jzNevh/mg+8VJN8V9FyMd
         tpsw2CZdzezJTbIxz4vjdX8GoKg0EhROufKNqkb/5kIuZV8iygLXFQH913LXrQw288PE
         Jz33wKeT+3jtMT/RLrCWuveazHOpEFP0m9GcORT2ujwbwACePQkWgmpCnSyjdVkSmEx7
         JlWTG30VKRhD9TIvuYYoufRChUcQ4NUDvmMaCZTeDbCSfwLv30GjdeLOd3qKpCOzeo35
         a4aw==
X-Forwarded-Encrypted: i=1; AJvYcCXNVajemFlRv94uYo3B0u2H4a5plyXQdLGZ5maNW9DhhzMo3eXvjUm+wIb9mtEw9PvK9qOQCJpF5JOybONDPIogQNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/yDG2FgybySJgnmmthmejqncWucBzOcWbZP0ttf1e/2b5I4s
	RfzUTs6YJ2ie4Pt30I4Pxe15CgtUQNDo8UXkBBq3t+6ygHgQuN2L81Lq9q5RD2jZJPff3NQQqKg
	75g/Y1vyP7RHRUko+Gf31y/XxkMIxSZH7JNFEXtJQokUgsuIqro68kT9XmToNGpZLoY4yfQAYbg
	==
X-Gm-Gg: ASbGncuIc/XlrXmWNPy/cTAoeT57ztGC8O/gJ1FP+6upbIV42F3FhlHQ70ctxwW0j2Z
	UMYYlRTXZGloLiG1L8tX9v7cmTaVIgPgjvsRkZudfGiqQ/T6DwV3PCwzvqwAxmkOCuh04+bJwTM
	ClHdEnwN0Q59C+G7cRaeHKeGv51omQyv/NoRL+nDJ9jwPM3ITkOjAY2N6Kw8JzJuOx2mrtyrTb+
	rxIOg+u+vo6MwfIQlH8WSpTIG1SdFxV3gQLioOudrRVtUBMRj5gVH7heQCYJ3y9bKT2wFYggWUR
	lbUtCUyYKca/FIeTGJF+AqdKyz03u2+YZKeIUjkcSg1Xj8phF9CWMlCIEgUHx3GeKMmulFQMw+y
	ekEGSExx5L7OucRBp15aR95Nz
X-Received: by 2002:a5d:5f48:0:b0:427:6c6:4e31 with SMTP id ffacd0b85a97d-42cc1cc0a61mr6832674f8f.22.1763835086343;
        Sat, 22 Nov 2025 10:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+Jtt9QEkPgTduqChbJfYqpEOz9bvWcy5YTNoYq4/C8oY0Sor3oPk9GYBsHdCI9lYIMy3Sng==
X-Received: by 2002:a5d:5f48:0:b0:427:6c6:4e31 with SMTP id ffacd0b85a97d-42cc1cc0a61mr6832651f8f.22.1763835085864;
        Sat, 22 Nov 2025 10:11:25 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8d97sm17583651f8f.42.2025.11.22.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 10:11:25 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Add common_usage()
Date: Sat, 22 Nov 2025 20:09:57 +0200
Message-ID: <20251122181058.656668-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z7VItGKonrBm3K2Vy2JNluixN6U2ZSursvRcdim6x0E_1763835086
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The rtla tools (osnoise and timerlat, both hist and top) have
significant code duplication in their usage() functions. Each tool
implements its own version of the same help text formatting and option
descriptions, leading to maintenance overhead and inconsistencies.
Documentation/tools/rtla/common_options.rst lists 14 common options.

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

