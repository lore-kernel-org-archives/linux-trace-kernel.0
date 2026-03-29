Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E33372684
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Mar 2026 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774809794; cv=none; b=hyN+lo5TLP0tyBvGVDroWPTNXutUIBaBygmz7/3SZOtg1xa0I1jLRok/VAlyKqmGRNy/pGRme/N2deXu1CJ/v658EEyl2lyx3hmx8wchvgqM6bn8Oe/rn52KJ+S5GHrb8FjoSeHNpepX0j1w+QENcxaCG0jmvhaBpeoTVNgZwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774809794; c=relaxed/simple;
	bh=6UWCqMk6hfv/Sb3rNmm2STfdRe3UHLnafRUyU8s5Huo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnFpdkUlIdQ2/oZCnYq5C55T45l0jRAtHWOmpI8uV6xW2GvqkgzvzO5H5rqI/N945vWVczcUjo4i1Jm2GI93tlyUvhVtlhKfFZS6uuZOAuHQ8GXBtt0DJ2ljLK4GxwWB4Bxx3LC+yvjMG+rAzCW5FTvocrVtyWzK0f0OK3J7BzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBSXeItf; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBSXeItf"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6500eae6d2fso1577702d50.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Mar 2026 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774809791; x=1775414591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oawRV1kPNCTdquiPT2P1apcYXlZ+xYT3ejLGg2PfxS0=;
        b=kBSXeItfdetW1dK3tbu4lPZQvQNQcf7knmGWUjC43iRA0DTPys+D3WOByJvfCTCF96
         1CUA7B4gfwql/ya490WWtF50w+dBAIiynmCnnMxFxNvnaC8AksaR7lgqyue2tecnfatW
         gag9Esxd5drrYcn13cWhaVgm/5MkApWjSCWMG2HBBWJbH+edqzVLAAlvLrL5quPyMbAA
         z2sx2yyLN59R3Oj0J98wRnDroWECZRCCa74YqnTJjLEfkl8aUeNs9LgINh4FzdUXyeHQ
         S+EYlwnhbIQWlcVLVNj1BghN+pFbOmIP2jSlW3dkpH3lr+fbfcfA15WGnvq7Mlf4O02N
         eFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774809791; x=1775414591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oawRV1kPNCTdquiPT2P1apcYXlZ+xYT3ejLGg2PfxS0=;
        b=TlxJcSCiSS7Xkl4HQk6JuwLiDQ2NPhboxW9B6REItSRULDzhKCpjxiCBeAS6gl+pi8
         9sJBqDFrAK9Qgi1x2Pp7tVXWhijrcwdIHpwei7ssMILGCNQHFXeI8pvVsvFIN/SDfcez
         3Y+G43StYtl2N5C7fe4vx9hL47rW+rP0c1oA50/wapgxS8wI87dVVZTVe4BMdaYh36hI
         rEUkcJe51f/0ca3KKk0C5xuVskbwFtp3q1P8XZOYEBNvWq0xMy81Rsl3hb1t1WYPghNa
         gZQ8ceNUnJDRMnNVtWghVPB/XSdKgyAVFnAkhDMbWZFSbIKWT10qxk97sfmNNr4bPLmE
         c3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhvvmMGlWHbR6DAciuHra03GorwNNZFHShtPOAnnsiPPsh1Gvltq8S7+m4+ssQpyDI1zzrWxsS8Y1vb2dEvomKhLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xEk0/7nWS1i6DbZ728wJcwSOkEY4tYudXOOK4xJmkFJMa7xA
	lIWNuxkZc/b4+Hu6c5AWw3Oz0GCoVqcRlS/N/g6DNOawsboyPR+KGsgo
X-Gm-Gg: ATEYQzzXG80bDb3W0T6BYmTwYEbeIkzhVbClSfE/frq1dFoXZgizhglKY3gzAcLT+mQ
	R+KsN4aSoalDcLZ0/IqN+GKga+lAYx/BEngtgHtSHIgXr7OiTh73gCYlGIEkaNiphFJWYB9KZ3Y
	6XHeRHegWXlV0WDTXRXdI4RVVgKNRAMulcqgc2oPPXewTOEQwT0jgADbvIIId5Jqjql7nFj4koj
	0qvCrYb+jOgQ9Uk1Jg2U/a+aj4UNRuyyXJTkh6AqWogJzclerC2dVNgmTNBOKMUWd8xy0JozdfX
	ITm0kysJKcghtL0WuSzEYCazCRep5JxvXkSUxFL9C/e7ASEtJyTOf8Gnp/U78YlF07mZnP30EnQ
	+IUd48JOjB0LZVlTsRTKD2k6HGMNKnHGpxcrFWtpH0ciNqChvq9AseRBGtXrNgu8z/fJgCOJHkV
	2Ebz3cQwCeLG5LOyLl3SfCE8X0q+bS+zMFk6cBWyQJPcl9wojcGLKHk8r1cX6oje+2x2HM37YWU
	4uys63Z+xqEkVQaIL5DwMd0K5fuo+dorzwt4T1B1Q==
X-Received: by 2002:a05:690c:660a:b0:79a:b46c:e621 with SMTP id 00721157ae682-79bddcd7583mr103431687b3.2.1774809790936;
        Sun, 29 Mar 2026 11:43:10 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7816752sm25431267b3.13.2026.03.29.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 11:43:10 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v6] tracing: Preserve repeated boot-time tracing parameters
Date: Sun, 29 Mar 2026 12:42:54 -0600
Message-ID: <20260329184254.1813273-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328201842.1782806-1-atwellwea@gmail.com>
References: <20260328201842.1782806-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some tracing boot parameters already accept delimited value lists, but
their __setup() handlers keep only the last instance seen at boot.
Make repeated instances append to the same boot-time buffer in the
format each parser already consumes.

Use a shared trace_append_boot_param() helper for the ftrace filters,
trace_options, and kprobe_event boot parameters. trace_trigger=
still tokenizes a temporary parse buffer in place, but now copies each
parsed event/trigger pair into boot-time storage so repeated instances
do not overwrite earlier ones.

This also lets Bootconfig array values work naturally when they expand
to repeated param=value entries.

Before this change, only the last instance from each repeated
parameter survived boot.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
Changes since v5: https://lore.kernel.org/all/20260328201842.1782806-1-atwellwea@gmail.com/
- add the separator accounting comment in trace_append_boot_param()
- keep the existing trace_trigger= temporary buffer and copy each
  parsed event/trigger pair into boot-time storage instead of tracking
  a running offset inside that buffer

 kernel/trace/ftrace.c       | 12 ++++++++----
 kernel/trace/trace.c        | 30 +++++++++++++++++++++++++++++-
 kernel/trace/trace.h        |  2 ++
 kernel/trace/trace_events.c | 24 +++++++++++++++++++++---
 kernel/trace/trace_kprobe.c |  3 ++-
 5 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 413310912609..8bd3dd1d549c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6841,7 +6841,8 @@ bool ftrace_filter_param __initdata;
 static int __init set_ftrace_notrace(char *str)
 {
 	ftrace_filter_param = true;
-	strscpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
+	trace_append_boot_param(ftrace_notrace_buf, str, ',',
+				FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_notrace=", set_ftrace_notrace);
@@ -6849,7 +6850,8 @@ __setup("ftrace_notrace=", set_ftrace_notrace);
 static int __init set_ftrace_filter(char *str)
 {
 	ftrace_filter_param = true;
-	strscpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
+	trace_append_boot_param(ftrace_filter_buf, str, ',',
+				FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_filter=", set_ftrace_filter);
@@ -6861,14 +6863,16 @@ static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
 
 static int __init set_graph_function(char *str)
 {
-	strscpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
+	trace_append_boot_param(ftrace_graph_buf, str, ',',
+				FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_graph_filter=", set_graph_function);
 
 static int __init set_graph_notrace_function(char *str)
 {
-	strscpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
+	trace_append_boot_param(ftrace_graph_notrace_buf, str, ',',
+				FTRACE_FILTER_SIZE);
 	return 1;
 }
 __setup("ftrace_graph_notrace=", set_graph_notrace_function);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a626211ceb9a..2fbfcb506b24 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -228,6 +228,33 @@ static int boot_instance_index;
 static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;
 static int boot_snapshot_index;
 
+/*
+ * Repeated boot parameters, including Bootconfig array expansions, need
+ * to stay in the delimiter form that the existing parser consumes.
+ */
+void __init trace_append_boot_param(char *buf, const char *str, char sep,
+				    int size)
+{
+	int len, needed, str_len;
+
+	if (!*str)
+		return;
+
+	len = strlen(buf);
+	str_len = strlen(str);
+	needed = len + str_len + 1;
+	/* For continuation, account for the separator. */
+	if (len)
+		needed++;
+	if (needed > size)
+		return;
+
+	if (len)
+		buf[len++] = sep;
+
+	strscpy(buf + len, str, size - len);
+}
+
 static int __init set_cmdline_ftrace(char *str)
 {
 	strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
@@ -329,7 +356,8 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
 
 static int __init set_trace_boot_options(char *str)
 {
-	strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
+	trace_append_boot_param(trace_boot_options_buf, str, ',',
+				MAX_TRACER_SIZE);
 	return 1;
 }
 __setup("trace_options=", set_trace_boot_options);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b8f3804586a0..237a0417de1c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -863,6 +863,8 @@ extern int DYN_FTRACE_TEST_NAME(void);
 extern int DYN_FTRACE_TEST_NAME2(void);
 
 extern void trace_set_ring_buffer_expanded(struct trace_array *tr);
+void __init trace_append_boot_param(char *buf, const char *str,
+				    char sep, int size);
 extern bool tracing_selftest_disabled;
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 249d1cba72c0..1c4a4a46169e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -17,6 +17,7 @@
 #include <linux/kthread.h>
 #include <linux/tracefs.h>
 #include <linux/uaccess.h>
+#include <linux/memblock.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/sort.h>
@@ -3674,7 +3675,7 @@ trace_create_new_event(struct trace_event_call *call,
 #define MAX_BOOT_TRIGGERS 32
 
 static struct boot_triggers {
-	const char		*event;
+	char			*event;
 	char			*trigger;
 } bootup_triggers[MAX_BOOT_TRIGGERS];
 
@@ -3683,6 +3684,7 @@ static int nr_boot_triggers;
 
 static __init int setup_trace_triggers(char *str)
 {
+	char *event;
 	char *trigger;
 	char *buf;
 	int i;
@@ -3692,14 +3694,30 @@ static __init int setup_trace_triggers(char *str)
 	disable_tracing_selftest("running event triggers");
 
 	buf = bootup_trigger_buf;
-	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
+	for (i = nr_boot_triggers; i < MAX_BOOT_TRIGGERS; i++) {
 		trigger = strsep(&buf, ",");
 		if (!trigger)
 			break;
-		bootup_triggers[i].event = strsep(&trigger, ".");
+		event = strsep(&trigger, ".");
 		bootup_triggers[i].trigger = trigger;
 		if (!bootup_triggers[i].trigger)
 			break;
+
+		/*
+		 * Keep each parsed trigger outside the temporary setup
+		 * buffer so repeated trace_trigger= entries do not
+		 * overwrite earlier ones.
+		 */
+		bootup_triggers[i].event =
+			memblock_alloc_or_panic(strlen(event) + 1,
+						SMP_CACHE_BYTES);
+		strscpy(bootup_triggers[i].event, event,
+			strlen(event) + 1);
+		bootup_triggers[i].trigger =
+			memblock_alloc_or_panic(strlen(trigger) + 1,
+						SMP_CACHE_BYTES);
+		strscpy(bootup_triggers[i].trigger, trigger,
+			strlen(trigger) + 1);
 	}
 
 	nr_boot_triggers = i;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a5dbb72528e0..e9f1c55aea64 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -31,7 +31,8 @@ static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
 
 static int __init set_kprobe_boot_events(char *str)
 {
-	strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
+	trace_append_boot_param(kprobe_boot_events_buf, str, ';',
+				COMMAND_LINE_SIZE);
 	disable_tracing_selftest("running kprobe events");
 
 	return 1;
-- 
2.43.0
