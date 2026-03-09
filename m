Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D650258ED4
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085973; cv=none; b=rBJw7WKZb3kZuw4Q32nsP1ZEBkxJjAeOGVRXWazyRtA50HMXqRbGjQrc7b8FXLbcP+ahtEyoFMuUszFWZz3dxR65IlLKtQqFKtwrTGy0kTQTX/kG+DbiAZibqeNdDZYMPhwkXj+FvrqUW7f+2l/fsX0MA23qDoUIdeeaIz+oxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085973; c=relaxed/simple;
	bh=w/+pYun5GysAaWOOHq4gwRcOi4slps50EWq3vhGOfwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rZXScCzK+gdb139YSIIvWEs9KTDI0yuIZUvsm2Fb+F30xsEP70IIKK/bG0wegRv2WAAU2J9gP/5DKjejxLf+bAOiBC4XaDgOI0qXfcGsBINTFL/N2RLWjQR1kIe2SjPWTSSyf52iR+oMVUAsnJJJx0eMRUuEkalO1Xwq5BswrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu/v1PKT; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu/v1PKT"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-41708e43f61so910552fac.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773085971; x=1773690771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xyENWBemTlgf42utf4z6UrQbN0qBAnJVayqo1XQ0AzU=;
        b=hu/v1PKThHs0axuqdEAktPlb78ugIBT56p3YZW1JNYP4cXPVCFZ1ZJuLcHwsWZHaLt
         2LPLKqYsixBoZ6CraheL+jxCu7dk+WdalxjgwEkUEnUvnFVjZUo9t6Nv+wE/4/SUBAB8
         PBV19FK4B7tu4Y+vDXZynx406gfCP+tbGcjlLGRQvYjLki5nWNA4gy52tqLLG0BDnZyB
         9FCVHX6Y+RW9gVCYFM3g/JW1UsuQp6Ud8q+3DZ+Jwlg+4rFmXPgq5SJySHWSMocBLCyK
         TVHRSgY8tUhQimoX+W+ucrVEAsXrbLpKUlmuVxsEWjE/AEiEkj0hSs+1u/KcjJkWEpzb
         5NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773085971; x=1773690771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyENWBemTlgf42utf4z6UrQbN0qBAnJVayqo1XQ0AzU=;
        b=bpZ2HlkfGkIuJNli3MhZgdykmB05cAmGJ5yJY09XVINODqyZ+o1PnI0uvgNnACn5gG
         r+CKO54LK16uLkj2cCMkKHB4tldgg3+zRg0K4ApqYSSOGsetNoAZPtFj/ZaElZQ0AhnN
         MQ7a4+bQ/y9pjydI9kPqS1ADilYq3AYcJ+SMUdBt28+OqZJp7r2lEmPkhusRFQ9zKSwf
         2Llxy3PA7DAh1sPnB4F8D4a/Mga4CwKEBvrcXCnaOFBr8TxPf4j5ugpjleiB0NfAWKEH
         kXkTrK4Dq/QHNo1ci8dfkR9o3jG0QWSb+tQvRGSKqLTi+nMEDdaoRV60LMBHUKeKZOc+
         mlZA==
X-Forwarded-Encrypted: i=1; AJvYcCX8QxgrvwTHfn2M4Isn+tCswYv53RC/tsDWWQcJKPcxg5Pk6iqfTRqaO0YzLoSfNYg80aYsJJPWZjZQG+X00AR6nek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhB5ct8chmR/vJbGEuHIJNHxDSEGPLaQ8keNJpdLhfaWu619wD
	8f2Q+qjQ4r/hqHZlSTtcwbNGUidTO6sJkcmrnC2nqAH9gDOu4GeeX2TM
X-Gm-Gg: ATEYQzyBukeQoB1ySlZc9xeADtD6TgHgh3OgoXu0oXlbH17eMKgAn8gzNdSJfusuV+p
	qrTfdoGctmQdGoD5LRLhyWZw4Ihl5C5Dvv+LPP5LT5M2DdxD4FBS9Gk8yEIejoPdwN/ZmzCaJzB
	NBZ3U2fgppg7+8jsrKWR3m+n0eI2wK65KiY8bCaFHnuVvEZxf+M2bnLCaEEOdMIhcO0KjmdnE1u
	gofNaA0RswQQZ0NABcTM2Tnf6QoQdp5k5lmmzPHb+5h6oVH2/T32ypf3Fswddvbpf/TNk8thEUS
	dTDQ66fhxTiZmHaXLTdNZtvTvYI6bgEX0adlU7Mgmm+dx/Nduxe/7OHEQvypZppSy7QTOxu+TmJ
	R3co3N4C/lcPKHAE1bgzaMAdcwJUrNLw69kzbGXMXOj1fj4esNcEL7e15dw1iNVlNyy6y/vbEkN
	u0TIKsfbDeUXYBiChDhH03ig5jx1lZggJOsIYFmlsgIjvtu8zQU9Pnu6l9IC8eIYRKmPymNwMc6
	6JSnyGM5DtBJZ1nmOMHIRAktOMz37OHT+LtjjiqNyMiyzUT
X-Received: by 2002:a05:6871:7c18:b0:417:4713:a0e7 with SMTP id 586e51a60fabf-4174713c260mr1342986fac.54.1773085970865;
        Mon, 09 Mar 2026 12:52:50 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756d4d342sm525308fac.12.2026.03.09.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 12:52:50 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH 1/2] tracing: preserve repeated boot-time tracing parameters
Date: Mon,  9 Mar 2026 13:52:19 -0600
Message-Id: <20260309195220.2726094-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bootconfig expands arrays into repeated param=value entries, and the
kernel command line can repeat the same tracing parameter as well.
Several tracing __setup() handlers still overwrite their boot buffers,
so only the last ftrace filter, graph filter, trace option, kprobe
event, or trace trigger entry survives boot.

Preserve repeated values in the format their existing parsers already
consume: comma-delimited lists for ftrace filters and trace options,
semicolon-delimited lists for kprobe events, and per-chunk parsing for
trace_trigger=. The trace_trigger parser tokenizes its storage in
place, so keep a running length and only parse the newly appended
chunk into bootup_triggers[].

Fixes: 2af15d6a44b8 ("ftrace: add kernel command line function filtering")
Fixes: 7bcfaf54f591 ("tracing: Add trace_options kernel command line parameter")
Fixes: a01fdc897fa5 ("tracing: Add trace_trigger kernel command line option")
Fixes: 970988e19eb0 ("tracing/kprobe: Add kprobe_event= boot parameter")
Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 kernel/trace/ftrace.c       | 29 +++++++++++++++++++++++++----
 kernel/trace/trace.c        | 23 ++++++++++++++++++++++-
 kernel/trace/trace_events.c | 23 ++++++++++++++++++++---
 kernel/trace/trace_kprobe.c | 23 ++++++++++++++++++++++-
 4 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8df69e702706..cdd46f639333 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6835,13 +6835,34 @@ EXPORT_SYMBOL_GPL(ftrace_set_global_notrace);
 static char ftrace_notrace_buf[FTRACE_FILTER_SIZE] __initdata;
 static char ftrace_filter_buf[FTRACE_FILTER_SIZE] __initdata;
 
+static void __init append_ftrace_boot_param(char *buf, const char *str,
+					    char sep)
+{
+	size_t len, str_len;
+
+	if (buf[0] == '\0') {
+		strscpy(buf, str, FTRACE_FILTER_SIZE);
+		return;
+	}
+
+	len = strlen(buf);
+	str_len = strlen(str);
+	if (!str_len)
+		return;
+	if (str_len >= FTRACE_FILTER_SIZE - len - 1)
+		return;
+
+	buf[len] = sep;
+	strscpy(buf + len + 1, str, FTRACE_FILTER_SIZE - len - 1);
+}
+
 /* Used by function selftest to not test if filter is set */
 bool ftrace_filter_param __initdata;
 
 static int __init set_ftrace_notrace(char *str)
 {
 	ftrace_filter_param = true;
-	strscpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
+	append_ftrace_boot_param(ftrace_notrace_buf, str, ',');
 	return 1;
 }
 __setup("ftrace_notrace=", set_ftrace_notrace);
@@ -6849,7 +6870,7 @@ __setup("ftrace_notrace=", set_ftrace_notrace);
 static int __init set_ftrace_filter(char *str)
 {
 	ftrace_filter_param = true;
-	strscpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
+	append_ftrace_boot_param(ftrace_filter_buf, str, ',');
 	return 1;
 }
 __setup("ftrace_filter=", set_ftrace_filter);
@@ -6861,14 +6882,14 @@ static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
 
 static int __init set_graph_function(char *str)
 {
-	strscpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
+	append_ftrace_boot_param(ftrace_graph_buf, str, ',');
 	return 1;
 }
 __setup("ftrace_graph_filter=", set_graph_function);
 
 static int __init set_graph_notrace_function(char *str)
 {
-	strscpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
+	append_ftrace_boot_param(ftrace_graph_notrace_buf, str, ',');
 	return 1;
 }
 __setup("ftrace_graph_notrace=", set_graph_notrace_function);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebd996f8710e..42d03d36ae39 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -327,9 +327,30 @@ __setup("trace_instance=", boot_instance);
 
 static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
 
+static void __init append_trace_boot_options(const char *str)
+{
+	size_t len, str_len;
+
+	if (trace_boot_options_buf[0] == '\0') {
+		strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
+		return;
+	}
+
+	len = strlen(trace_boot_options_buf);
+	str_len = strlen(str);
+	if (!str_len)
+		return;
+	if (str_len >= MAX_TRACER_SIZE - len - 1)
+		return;
+
+	trace_boot_options_buf[len] = ',';
+	strscpy(trace_boot_options_buf + len + 1, str,
+		MAX_TRACER_SIZE - len - 1);
+}
+
 static int __init set_trace_boot_options(char *str)
 {
-	strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
+	append_trace_boot_options(str);
 	return 1;
 }
 __setup("trace_options=", set_trace_boot_options);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 249d1cba72c0..c3981f62e4bc 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3679,20 +3679,37 @@ static struct boot_triggers {
 } bootup_triggers[MAX_BOOT_TRIGGERS];
 
 static char bootup_trigger_buf[COMMAND_LINE_SIZE];
+static int bootup_trigger_buf_len;
 static int nr_boot_triggers;
 
 static __init int setup_trace_triggers(char *str)
 {
 	char *trigger;
 	char *buf;
+	ssize_t copied;
 	int i;
+	int start;
 
-	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
+	if (bootup_trigger_buf_len >= COMMAND_LINE_SIZE)
+		return 1;
+
+	start = bootup_trigger_buf_len;
+	if (start && !*str)
+		return 1;
+
+	copied = strscpy(bootup_trigger_buf + start, str,
+			 COMMAND_LINE_SIZE - start);
+	if (copied < 0) {
+		if (start)
+			return 1;
+		copied = strlen(bootup_trigger_buf + start);
+	}
+	bootup_trigger_buf_len += copied + 1;
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
index a5dbb72528e0..a63a56b55570 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -29,9 +29,30 @@
 /* Kprobe early definition from command line */
 static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
 
+static void __init append_kprobe_boot_event(const char *str)
+{
+	size_t len, str_len;
+
+	if (kprobe_boot_events_buf[0] == '\0') {
+		strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
+		return;
+	}
+
+	len = strlen(kprobe_boot_events_buf);
+	str_len = strlen(str);
+	if (!str_len)
+		return;
+	if (str_len >= COMMAND_LINE_SIZE - len - 1)
+		return;
+
+	kprobe_boot_events_buf[len] = ';';
+	strscpy(kprobe_boot_events_buf + len + 1, str,
+		COMMAND_LINE_SIZE - len - 1);
+}
+
 static int __init set_kprobe_boot_events(char *str)
 {
-	strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
+	append_kprobe_boot_event(str);
 	disable_tracing_selftest("running kprobe events");
 
 	return 1;
-- 
2.34.1

