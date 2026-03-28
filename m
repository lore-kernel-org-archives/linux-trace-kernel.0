Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3922BEC2B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Mar 2026 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774729142; cv=none; b=paBntfvLYK8dTGHisoPj1/12GcQ6slra8oOn0CiZzDK4yP82eUeBGLLJyFukKT+r2zevZ3pAKabB/2S3hCM6DAUetZAdgQWExapTos1OcPvFxRz0IiXuLllrjlIB+mf4cEnvgHhrnrlEhEmXafWhCBy2mAfCnT9RudNV2I2lCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774729142; c=relaxed/simple;
	bh=MSBDgzeNH16ZaZSPq7lwNNBddx+MssjnW9g6J+QSieI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1f7ww9BWBGvl8f5T3EvLL2ymhaAShWUGzdxj8KRBzWM7yN1Ev6XFMNydAEgMi3aG0u/YnCSgWuieDq1e4mxrwfU/WgPMz3xV5WXyneyj/JmhzmMiNzZ2OwmpZipGKpZjtiuFehEs8xh7Rr4GHzahod/MalH7AbiTi8DwqnweLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0sOEEL7; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0sOEEL7"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-46703fb602fso1077400b6e.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Mar 2026 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774729139; x=1775333939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0YifVqa+mcHb6bTjfMGuRietc0v8qhsQxvrWBI0V5A=;
        b=M0sOEEL7jtpBKSa4RRT8qRJmh8rE8RWFhGJd3qomLfiA9phR2ietI7BrJkrkAbo9Yf
         VZ9TnUpLiXXd5u/0IsZ4i8XY/bNW34o0l1ex/FpQP8Eo36dFq8JadbY0vNLgiURLzRQU
         XXZsyhdFXKMUkLapob+QrtdkmMIZa+8fLt25QKhmbbXIssXF1gzfRJGNwmTMSFsau1jP
         9xhWt7dgp+dj7hAEc4T++YvIK5BmEWwUueRWNRBv06dpHbl6ZbBKyf/8Qqo8KvWs5oUP
         jvMSuqkWL3qOV4vHlkMbWkHxihsklRXSwQFnYxq4olx/Usw8JpGfSRERHitJbwIaWO7c
         1OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774729139; x=1775333939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0YifVqa+mcHb6bTjfMGuRietc0v8qhsQxvrWBI0V5A=;
        b=SYLCtGEGctM3OzjDk50IJ/Iq6xuOMjTjdQBgIlYfc29C8jfERj7+lob9bZ8Bhg7+/A
         LtI5BqvYvHHb/YJaPsmlo+UZyLwrfdo80SAxGcOBqFY9qIXgOLLTGUp64J5AdxAJuM07
         aGDe2+Jcr4JLVD/qWFCD3aU9lqa0OOjKTAxEQ5eEvc1toL7M2CqIBwSnihZEor3ypN1s
         Mcs7CCPIQXijKYucnzIwaZSD2awQAIt5Gtxkxn1xhQYj1ArGaZX5BSk3OgwXGl4jZLc9
         50Yf4BiDVAFYmXbvEGnBuMhb1KpFntHMWatAJTa7YsBT4KPQbAFxgv5/DJfsaRLDOCY0
         w5rA==
X-Forwarded-Encrypted: i=1; AJvYcCW5CwyNFeXGwVsBw+51um/Y73UWOrhO7HzSI/tFNMcyJnmSp9U1AZpP1ivMJwwbCorEpUXHRWZAt0+YU38Xva63sic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDkd6QGa8nMrglIECucGw3iygDYhMm2usXZjhEenbhE080eAVK
	JnsHon+QxS/+LEIgdH9pXHXt0iDpRkfD4HBp2kzYszfDJIdKnSGJ981+
X-Gm-Gg: ATEYQzwX2tMRYgjgNxmfNvZATcLf32X0nKHKvOkLD7zYGOvjfiJs1XGhETh2LC+BgnV
	EqqO+EM/rOzVCGcP1xuoP4KABTfi4NdVuUJUB4wlcXijcQw/fxVKpUjeo7hhyjDkCdiFW3/ypCo
	hozo1jKKhOMrYPrl6HUyP0e0YJFN0O+bazBebI+YDjKf6J1jc8j93ydNVw7UnAXzE2Em8e1de+h
	7wvUVhbIGjZL4ZJ194q4rv9naoi24QO8+VdnL0uiWwEMDu9XKuX/3ALYEhTnDdr7SnUe0Fo3XNr
	cPWi7mzp4iYEqQeJOBGsvaYElB8IOS17b/kCymxhgdFAkywJTIw4cwwlY+voAHNcsN1RwYubve8
	AZvuAhsqFc5er9tnvwEmStrpy/ESynE+CUKFG0sfBJVZPBSTSm4D0sCyJIckC7FZkunceGM7Zrc
	vIqozR3/BUHbnwXjQiV3Wt2E4stPwr7AOBXJlSOTDnn11GIKQjf3ET7mYp09j0+9j/5B1eyBELO
	+F0sSCS8b6Yc58NCigaw84cgHIpNmy4wRXY3ZPp0g==
X-Received: by 2002:a05:6808:c008:10b0:467:14e:6bef with SMTP id 5614622812f47-46a8a55392emr2666173b6e.33.1774729138991;
        Sat, 28 Mar 2026 13:18:58 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a7edb42sm2408813a34.20.2026.03.28.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:18:58 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v5] tracing: Preserve repeated boot-time tracing parameters
Date: Sat, 28 Mar 2026 14:18:42 -0600
Message-ID: <20260328201842.1782806-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324221326.1395799-2-atwellwea@gmail.com>
References: <20260324221326.1395799-2-atwellwea@gmail.com>
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
tokenizes its backing storage in place, so keep a running offset and
only parse the newly appended chunk into bootup_triggers[].

This also lets Bootconfig array values work naturally when they expand
to repeated param=value entries.

Validated by booting with repeated ftrace_filter=, ftrace_notrace=,
ftrace_graph_filter=, ftrace_graph_notrace=, trace_options=,
kprobe_event=, and trace_trigger= parameters and confirming that the
resulting tracefs state preserved every requested entry. Before this
change, only the last instance from each repeated parameter survived
boot.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
v5:
- use int sizes in the shared append helper and trace_trigger bookkeeping
- keep a single bounded append path that only inserts the separator after
  the first entry
- only advance the trace_trigger buffer offset after a successful append

 kernel/trace/ftrace.c       | 12 ++++++++----
 kernel/trace/trace.c        | 29 ++++++++++++++++++++++++++++-
 kernel/trace/trace.h        |  2 ++
 kernel/trace/trace_events.c | 23 ++++++++++++++++++++---
 kernel/trace/trace_kprobe.c |  3 ++-
 5 files changed, 60 insertions(+), 9 deletions(-)

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
index a626211ceb9a..c8cf45dc4152 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -228,6 +228,32 @@ static int boot_instance_index;
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
@@ -329,7 +355,8 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
 
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
index 249d1cba72c0..7f0bec4622f6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3679,20 +3679,37 @@ static struct boot_triggers {
 } bootup_triggers[MAX_BOOT_TRIGGERS];
 
 static char bootup_trigger_buf[COMMAND_LINE_SIZE];
+static int bootup_trigger_buf_len;
 static int nr_boot_triggers;
 
 static __init int setup_trace_triggers(char *str)
 {
+	char *slot;
 	char *trigger;
 	char *buf;
 	int i;
 
-	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
+	if (bootup_trigger_buf_len >= COMMAND_LINE_SIZE)
+		return 1;
+
+	slot = bootup_trigger_buf + bootup_trigger_buf_len;
+
+	/*
+	 * trace_trigger= parsing tokenizes the backing storage in place.
+	 * Copy each repeated parameter into fresh space and only parse that
+	 * newly copied chunk here.
+	 */
+	trace_append_boot_param(slot, str, '\0',
+				COMMAND_LINE_SIZE - bootup_trigger_buf_len);
+	if (!*slot)
+		return 1;
+
+	bootup_trigger_buf_len += strlen(slot) + 1;
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event triggers");
 
-	buf = bootup_trigger_buf;
-	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
+	buf = slot;
+	for (i = nr_boot_triggers; i < MAX_BOOT_TRIGGERS; i++) {
 		trigger = strsep(&buf, ",");
 		if (!trigger)
 			break;
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
