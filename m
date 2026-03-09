Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7717E33A9DA
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091654; cv=none; b=duyNNBASxWlTVc18+Ooqwi6+wYH81Mtq8jt8yLV5ydaHh9uKzXE6mPM6ws7b5o4hhgdcUFj3+s6OMfeN3GWC0iC14DV9y2AgCcb+Fje+51ND9KlWlEvLlogJdQ+gG6kKdkci+dXNnRnBQIHDLc0vy8lJWaDYyc3xIxZfK42z70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091654; c=relaxed/simple;
	bh=6stQYyOxMRnUStvEWwSG/+EyIdCyR+1lCeFjXm/jGoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkQq3Dmw2Uk+X4+rdzlgEwReMxqU0SigCZGQPsYd6GccndzxzM8fnPHUzeIy7XXokvS3ToKZxKEWx8FSsg2exe+N7ZpFVvSYJZRuaiicBgwbm9S87rDeYVy3t7i0UijnSa1xtlGgzv2QfOqbZaoiTCIWNjyAoGLocnpwK8dOTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGkcLKZS; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGkcLKZS"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d741f61ee5so1542704a34.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773091652; x=1773696452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZQ7pa4QZtyeqTGy8hRuNrpZ4pJ+pX/bVyCr6bI4rKo=;
        b=hGkcLKZSYUNaKLD9x22C1FnKSjO4i/Uh/bIjR/JX/6JdlyTUqwgQBy0nqdU47tZYbN
         bAu8LKI1A8FElGo6y0R/2NCR9mzYfoVmQQmQ78xEA90bs1samcWYVMHCw7hMJCS51pwj
         bwgkvwysFojHVtK6c5QDcywS26v3KM+6yh03efJcSmKDRxuEgbhIjI8eqwyAoo3LMSyj
         nNmMDINPOmWQZBFkGs9ykq6pVw8LMfutIAM4rAAEczH3O/Tjxh/8bAZPVQxrM9pK87N7
         S3aghgHsweG+X6rfuDSmiixPeKbjCipMUQNT9TnaSB1Fp2acOblMpMj1yYU2k6Mg4niU
         NeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091652; x=1773696452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZQ7pa4QZtyeqTGy8hRuNrpZ4pJ+pX/bVyCr6bI4rKo=;
        b=TeVbQcl42IIfu04JnQeKvwO1FjHjFgg2GnPeicPY91VrHeLFBlMIWUlGntwZPaZXqh
         ll4s5Q83oSjPPSkAWboozPPhQuF8zSUE2red5T/rKBFzvd/KRlDRt9PW3scjx7TmZi3+
         KNUjEk/nTKv3A6hk4FUp35x8K/0g0a3cexqYbAH13XbSCovDMSgBTRooD8pBajB4jjXQ
         WhbC5LP7lga8FO5zERM9oNX99SXH1q2ZmtnC4Sj5b3ULM+M8D8e4qtE344HbDvD3oUl7
         M4YRuI2CP8BA2XP9jELWKjM4XpW5zZYVpiPJK4emfzit4pb3vkU+4ozochmYPhW2h7n/
         nyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2thqjdXarffDrLQWN+IbkZ/yevp5wYFxV6YhmvB3GwMKyBcyP8c4TXepPpVhOc2WiMpSyyuFYPu/zrLF0h5GrXoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzq/ItHUJWr3mfJvYfzzSV5sHDVMd/HBYKUDgW42ZUzQUW678f
	mCDxkNAln8q0Oum1gtKLf0vFKksFOzndX9frcPRGj8JBfRrs6Ctqk0vqZkTUFrZJ
X-Gm-Gg: ATEYQzwMn5EraKqO2o1xKpEL6MASWDqY4uoIoPETOUvQgHJCCyjw7QR7123vUr3ZtRw
	26zmlV1d7F88fDiQOWI9NRGp8Lo63WVQAsJvJCW9IckweLB8ylw4LS3t1oMlTDxQxT2XqdggR2P
	7frzoxyAk0lFGm5VCygjBakjxQx7VEq2RvoA+wGoQIrGpj7dbBX85+/N1TonRGMVSeizQU1B8X2
	AAIcLHJXuBTBvHHZwW40qYC6aGba/dJyB4av8glDXcDjcBg6ALjyXbwMMvRTbUJzbYQ347AcEB3
	9DXBnU/XN7X0mDQTt6oT4fLj3i07NFlExnTJOLjgvNqGDwlIBLj4klhRmU/Tj2XvabZTopnHEJU
	qEkjrW/0x1bd6Iep/CzAAZbrq/Cj1UgkxWL6UBCKzmi9gr9KOaH80m0vlx2WIEjlh9TguFzWv/y
	Z5K5IAOGUZdE1Vv87Hb+VWGQ58h0SLjN8ZsvMtF6mVqUYxlwdU3BnMDhZLY+VmytdwvN1NQpzMi
	Xezed39ICzeoQHMY+r8PyLZ9+WAXDRMPh89hVGMcW9Kx72O
X-Received: by 2002:a05:6820:189a:b0:67b:af93:92d0 with SMTP id 006d021491bc7-67baf9395dcmr4115115eaf.28.1773091652273;
        Mon, 09 Mar 2026 14:27:32 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb3bb67fbsm2639289eaf.15.2026.03.09.14.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:27:31 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v2 1/2] tracing: preserve repeated boot-time tracing parameters
Date: Mon,  9 Mar 2026 15:27:01 -0600
Message-Id: <20260309212702.13622-2-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309212702.13622-1-atwellwea@gmail.com>
References: <20260309212702.13622-1-atwellwea@gmail.com>
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
v2:
- No changes

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
