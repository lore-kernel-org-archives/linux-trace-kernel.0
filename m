Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70CB31F99E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390424; cv=none; b=ZsW4OXMWwKUgyuQ1n5LCK+jzvKchQKR00C4YQWUFsNIDzSazRBinamIad8XmDz5rLEjmdGseGqxDfv2GCRgaZ4AzsU4vKGAQ40UC1acg1/JagEVU5MMhBnHyRgD8wFkeF3hIta+jTPqcOGkdYaNDNHxo3AvCJvHAYIenDfC6Z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390424; c=relaxed/simple;
	bh=1Fu3GPsdy7SmCXEEtqhiqHPRY6vnKjAAZ7to4vwTvyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D14c2OC3eYdIyJv8ZnGfLWC2iXZteuBs58AK7j+qRv8pBpgYSBlDG7tRNcXZdj09ZgUD9Q00Jz6NgLHpB3TZYHyQ4deIqn1/7h3qkRr/yM/1Oyl8WVLS3pqK/ZWNX2C4et9YqPu82ddsTI58WCfVToFSdwVpAGlwXRHmJY3eU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssdND8dT; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssdND8dT"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so1592789fac.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390422; x=1774995222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk9f11+7KV00+v0s4eHakI5wNW8ozm7KXQsOzb5w0aQ=;
        b=ssdND8dT+b1oudDV31D6YkNeXydkrDJ7+tHvaSUzBY4lrkXpNZxuS7D3o3AmQ4rEp0
         5IGCXOuYeP0pE3+FMHwxMFzfjGhcy0UTib7RvuQg4G5UAXIUmbExOCONYyDhZXqC/pc1
         VsM8dH4Rh+1P6g4aYuvfMF+wRfTZGaIZ54FNhogTulmEfGjTtIOzGqmvatZbinzgdzJZ
         vCCRLaofAiGc2tmu0TcR0tCn9W8TGQlZGFloM+8mZz2zadMqtD0drNcRjL+4v+Jzr2OO
         Fast7nD65kWwERGyjBWVCfueSSGx9M/QNx1Lbj0ncL8/hNECQb0IsWxgBQBJGWCpuBVA
         WSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390422; x=1774995222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gk9f11+7KV00+v0s4eHakI5wNW8ozm7KXQsOzb5w0aQ=;
        b=Yyp0V/LB2GlucL2IGb3ruY0Xsh3VZTjxLFbO8i3V/FeXixXfXKBU2Zwk9OhcM5rpCs
         autG0Ph9fpgad+ubWZPH8BUQU09sUfxrAVwVeLPHLfKdqnpqwP47vQVc7u6e/OFl6qq5
         hxkG2o0TASVGdadzFGpFXdjolRyL7KXWQxwWcPiiOPNlclM/eEHTNo7XecdJuFPHhi0x
         Ibie92lHO4L5SBQRSRRg0sr1W2fWHUa9oFRP0Kch/FvCfz4rT+mtt8ULyvXofL2obFQc
         kSKPNllS3Omx1PtqFDQvXxnV3krSAJ9NsAgGBSmLJsIe7A4P//vPtIIlJct+CuE8YYU1
         RYtQ==
X-Gm-Message-State: AOJu0Yw61nNHcbQK+/9ALfn2sKLOYq1EEiC2T2DeXB8aaxRX2YXXB8l4
	RbspydoZbSmfHr9lNGZNwjBArZyH4xM5IxomalsWW22h0ZJK5cNep7nqGoIt185S
X-Gm-Gg: ATEYQzysvMjUi2717emHkQLjdqUml8g9S/Y9Bx/xVgOcD3wVydN55sGj/Rp1PcDsOcv
	HTNZCd7/CHh09w+fb3pm9HnY8TcREQkUdleemPpHj+NQ4xj77PK91RmKgIOtvEMTS1fvZK9Ufyr
	6S4C4/CdFiWuOSVOk+yB0EDhckNFhlXWhIB/FB8ccNTfBErXxw+xRuTFcqXr9aw9M3O+x9TEaHm
	qyKSRmQFDBFZUTQW3+sJVikBtTb7iINPlfSJ1D6oibKHfy0XRAxQolWHRlvDtrp5wWO20RUQbO3
	kl4WI7zPE+6ND6bepb9226y7Kc+B9f9CGIBXFMyyNhgtuW5m1LAGZ0ZByFAttbAQXPwb82N8bo8
	1qfIQzzvdyn6cSGKeDpn78BQpXNlSI3i9j5zp2IYRS1iFjPN1uk414r6MtOGuw5871Zif6m2FUs
	48oKWsHgDDaziIS4mFniQCFrJrWaS/PFzTbkL5cqbtfQH0Gb2vlttRAWbJco9QREc+wBAXDv0Xp
	wn5PN70hNLprAc/xOAM0QVkZhCR6wibmX9z17JSng==
X-Received: by 2002:a05:6870:d60f:b0:41c:e4:f933 with SMTP id 586e51a60fabf-41ca6e68bacmr840404fac.22.1774390421947;
        Tue, 24 Mar 2026 15:13:41 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c57bdf2b0sm8966606fac.7.2026.03.24.15.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:13:41 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v4 1/2] tracing: Preserve repeated boot-time tracing parameters
Date: Tue, 24 Mar 2026 16:13:25 -0600
Message-ID: <20260324221326.1395799-2-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324221326.1395799-1-atwellwea@gmail.com>
References: <20260324221326.1395799-1-atwellwea@gmail.com>
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

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 kernel/trace/ftrace.c       | 12 ++++++++----
 kernel/trace/trace.c        | 31 ++++++++++++++++++++++++++++++-
 kernel/trace/trace.h        |  2 ++
 kernel/trace/trace_events.c | 26 +++++++++++++++++++++++---
 kernel/trace/trace_kprobe.c |  3 ++-
 5 files changed, 65 insertions(+), 9 deletions(-)

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
index a626211ceb9a..1b1f6f9035c6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -228,6 +228,34 @@ static int boot_instance_index;
 static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;
 static int boot_snapshot_index;
 
+/*
+ * Repeated boot parameters, including Bootconfig array expansions, need
+ * to stay in the delimiter form that the existing parser consumes.
+ */
+void __init trace_append_boot_param(char *buf, const char *str, char sep,
+				    size_t size)
+{
+	size_t len, str_len;
+
+	if (!buf[0]) {
+		strscpy(buf, str, size);
+		return;
+	}
+
+	str_len = strlen(str);
+	if (!str_len)
+		return;
+
+	len = strlen(buf);
+	if (len >= size - 1)
+		return;
+	if (str_len >= size - len - 1)
+		return;
+
+	buf[len] = sep;
+	strscpy(buf + len + 1, str, size - len - 1);
+}
+
 static int __init set_cmdline_ftrace(char *str)
 {
 	strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
@@ -329,7 +357,8 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
 
 static int __init set_trace_boot_options(char *str)
 {
-	strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
+	trace_append_boot_param(trace_boot_options_buf, str, ',',
+				MAX_TRACER_SIZE);
 	return 1;
 }
 __setup("trace_options=", set_trace_boot_options);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b8f3804586a0..64ce179d12dd 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -863,6 +863,8 @@ extern int DYN_FTRACE_TEST_NAME(void);
 extern int DYN_FTRACE_TEST_NAME2(void);
 
 extern void trace_set_ring_buffer_expanded(struct trace_array *tr);
+void __init trace_append_boot_param(char *buf, const char *str,
+				    char sep, size_t size);
 extern bool tracing_selftest_disabled;
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 249d1cba72c0..5f72be33f2d1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3679,20 +3679,40 @@ static struct boot_triggers {
 } bootup_triggers[MAX_BOOT_TRIGGERS];
 
 static char bootup_trigger_buf[COMMAND_LINE_SIZE];
+static size_t bootup_trigger_buf_len;
 static int nr_boot_triggers;
 
 static __init int setup_trace_triggers(char *str)
 {
 	char *trigger;
 	char *buf;
+	size_t start, str_len;
 	int i;
 
-	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
+	if (bootup_trigger_buf_len >= COMMAND_LINE_SIZE)
+		return 1;
+
+	start = bootup_trigger_buf_len;
+	if (start && !*str)
+		return 1;
+
+	str_len = strlen(str);
+	if (start && str_len >= COMMAND_LINE_SIZE - start)
+		return 1;
+
+	/*
+	 * trace_trigger= parsing tokenizes the backing storage in place.
+	 * Copy each repeated parameter into fresh space and only parse that
+	 * newly copied chunk here.
+	 */
+	trace_append_boot_param(bootup_trigger_buf + start, str, '\0',
+				COMMAND_LINE_SIZE - start);
+	bootup_trigger_buf_len += strlen(bootup_trigger_buf + start) + 1;
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event triggers");
 
-	buf = bootup_trigger_buf;
-	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
+	buf = bootup_trigger_buf + start;
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

