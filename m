Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091030DEB0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894277; cv=none; b=UdRdSUQHiuu2U2ZKm52i0VN4zxEVVxkJocY1mm1zIPYrAcBzDKhBEOhz86T/f/EtdIQy8MElEI1BQCc3MTYYJ6FoRjRiyD40Y7Tm94EsJOy/dgT33HnepBhafq++YusfsiXEcxJlL61bxIJGI/qxWUguxHfCD/eWhHj9yXd7tWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894277; c=relaxed/simple;
	bh=GYno82SsBkAEwj7YDxqSbKXlEXi9wEXVvML9u3CFPuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/JXyL4/fIbCI4mOqFnVsYYQGwhNojrOopoy+q6AYJnHF92ethNFvvX7S43tjidA/ffQUt8PUaZETddw/v3ury1Y2WqzzNWX3oWWhpqDN2c4/wAFFPoqpcWOeWUqKt98Ug8bGc9em5PcnSNWBOAZn/LM3TjuCU/rFwimVhDesAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRgud/cb; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRgud/cb"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501c4857b2so3225608d50.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894275; x=1775499075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LIdXxmiWbjpMQWYYF2/XpUWkkrF865lkPEGNtH16I8c=;
        b=pRgud/cbc4a48z7qZh4WeCHU2hckMIOCEaRZhZz1EC4H6SMlkc2ArwFgdxEo9QI1Bl
         IBpCcuvU+kpf4BRzhWuSEWMbT13WY8DGoHzp9CCAmPLSn8j8RrQdWNI8nnhbtyjIED+1
         K98H2invoKwOMc9SeQmYa5fR/Oshtd7Q2B8bEnKH53XPRv7tHKJjKTQ1UIlTKk/tlUUH
         dLdO2bs46Fe/7Csy0nH1BDLAuhmixz/reSz0AhZEVx3nkSgT/XMWo2oE/wUA6riWjRQ9
         3vf7BkHkNJgw7pUEDnlK7ZGNXyelBa+vqmhOPbZkULS+N4EW11jp2YCjk77FNtEQYDCQ
         zQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894275; x=1775499075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIdXxmiWbjpMQWYYF2/XpUWkkrF865lkPEGNtH16I8c=;
        b=Ai62UAJ/V1518atB3fwg1umXLbHPOJ0noWYthSzSK7l4GTFRfwlOjCZTFFhc7+qj/j
         7asBGHcayFiKuMYTfc7ewmW6xcfXGyDcXNw2KPxtccSKTGbmnhqhG0GMY6L7EmY1lTlk
         zKwqhC+qMbHAL7JSGrSYc7lGySQ7OA3d4Bh0HwaXiLuRRmvfOSFMe0uxYhzGtodFkNY/
         ckxIbrnHAwfyFfMDkWDrf9iMRGoiqv0wSyGRfKkQqWRPI7CjtMDLXNy7nspODETrdB18
         5jblxibBH3vVfIkrosD6qzJgVQE1WJPwjgmq8PnII6p/ZPyY942kIxfUV6U7F/HHZkQF
         5G7g==
X-Forwarded-Encrypted: i=1; AJvYcCXByJjPRE6G7rVfFJx7RbuAxx3TRIz5vtO+cr6Sv9YOEYjGlbnpa7LDyFjXPaF6bXlalw/HrrCLS4vE2lS/xKODkAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuB4DJaRvQMKogxvfRN5ZiabjbPKcu4AvT0cPDCOv13HWKl8Eo
	Y4+OAzBxROATodk8ZBWEcDfcIrEB2t78Pd434Q8B0gRVHlM4WudF7Ye+YDioTfyP
X-Gm-Gg: ATEYQzxyIZNOhYH9143G12sOYhDhE0C0+hNpKLvms2Zz/TVX/hEc4dB35j6xio+/4oX
	Z9Ci2l3AYZZLhs0T2CKEXXK2WRELn+TMsHL1vMz2yicpTHmE1GbwtPVrYX5LjZVomutMk2vBfCU
	cGg0iZ3TQfcEKoSyvCF+KzwmfAfOx88YOfprY3PkIK03MKsPKOH0R0tYQ9zJSkCSnM73zIAcnw3
	eWCzeerXwD3h0XLhN7MEvUmKw5YkPEeb4EU0ifSmBZ7U71mBYDd8imcsqtj+BAeuHhbkorpM4j6
	s61fqFOrOeLmG2cZwcBPnTgGq41dU0EE+MJbKY1cSKxtpR/BVfcMI762vYxEAVHeFuog39CHgXs
	oBl+rlik/LluPZ/mP9IJSnA1HNbmLEB9hibD0fkII0fLVFLIPHhAXKdq66dPAkF2oND3dumZXGE
	o8D2FCRO0LN+Sv+eOFppNz1ytrNC53C/qUz5ODxrvLBSYIqYd225SMoQ8ipXzUcsXH3wKRSu0pJ
	lOMPQu1DxfS/yJJjloG8rnmI1gQYymzZcsuOIfn2Q==
X-Received: by 2002:a05:690c:6e87:b0:79a:bf27:fe65 with SMTP id 00721157ae682-79bde0a01f5mr133721587b3.35.1774894274972;
        Mon, 30 Mar 2026 11:11:14 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb4521761sm39104447b3.0.2026.03.30.11.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:11:14 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v7 1/2] tracing: Append repeated boot-time tracing parameters
Date: Mon, 30 Mar 2026 12:11:02 -0600
Message-ID: <20260330181103.1851230-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
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
trace_options, and kprobe_event boot parameters.

This also lets Bootconfig array values work naturally when they expand
to repeated param=value entries.

Before this change, only the last instance from each repeated
parameter survived boot.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
Changes since v6: https://lore.kernel.org/all/20260329184254.1813273-1-atwellwea@gmail.com/
- split trace_trigger= handling into a separate patch
- add the requested blank line in trace_append_boot_param()
---
 kernel/trace/ftrace.c       | 12 ++++++++----
 kernel/trace/trace.c        | 31 ++++++++++++++++++++++++++++++-
 kernel/trace/trace.h        |  2 ++
 kernel/trace/trace_kprobe.c |  3 ++-
 4 files changed, 42 insertions(+), 6 deletions(-)

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
index a626211ceb9a..652d9f4e7943 100644
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
+
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
index b8f3804586a0..1579cdec3f56 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -862,6 +862,8 @@ extern int DYN_FTRACE_TEST_NAME(void);
 #define DYN_FTRACE_TEST_NAME2 trace_selftest_dynamic_test_func2
 extern int DYN_FTRACE_TEST_NAME2(void);
 
+void __init trace_append_boot_param(char *buf, const char *str,
+				    char sep, int size);
 extern void trace_set_ring_buffer_expanded(struct trace_array *tr);
 extern bool tracing_selftest_disabled;
 
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

base-commit: e3c33bc767b5512dbfec643a02abf58ce608f3b2
-- 
2.43.0

