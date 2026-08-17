Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387143A80E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974948; cv=none; b=msbpdoTi9jl7afYPCsJ2k3WHpy01dCe3HYbRD9kM5CP9/x57bJOHO5rnOB/y9YUZeeT+u8TQuBkLRXtDS7/t5LEIfF92SM1fZBkwZDdQKB00jiWH1KH9hL4676tsOr59Z5FBG3RfAyr0vCtulqwabCtSmH5vrqQpEn9FT5iSJKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974948; c=relaxed/simple;
	bh=um503tE4KiLpjeR0L9vWVP8QvQuobYkC11kB2lpF5bE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iN5G/L3gD7ZH1Abm3yBPNylraxdQGUs1Q1S2Mm8jPbM9KB6suNFDMFvr7g0vko0wWXjstOOOCWHBLequaLRB6cMobr9ER+oicD0rEoCn/iCbP0PiBKKwviK62Q/VqYCATRqk8bDWynZ9vtoQlxOZI2Ry2ZxsqDYRAJ/bIUbamBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ozhIbl7c; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozhIbl7c"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a36683ee94so2910620a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974938; x=1787579738; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RPANiFSwQx1UeEN6L9ImsPRlhPzOEZbKWDb7jJt3s4=;
        b=ozhIbl7ctHTMNbtxvIKs5SLFAkgw6dxtyz3HGLJ6NJmHkW6ou/1OVAVJTM+3r4GBNj
         TcUS8FQCTVCfIUAcyMWD/gLHd9xwpjkHzLF2OzhkLgYiyIXVRnx5J70EVf7CXjP3gsGm
         ztQGDNMnfoTP0VzO8XP74rxkoPSYO5cBoBSczM9a9jGLmSJWRkI8Wi1DqQA4YEIsj0+e
         PsrV12czSqNHdG7R4WmFlQBJgjHRGQmGfOUm6Kl/epFBxF00GP9aKBGQtX8alTHUYEZV
         IYo+a3qjyVw8xo/79N/0kc9TMQPpMhiAeUiesjgwU8x3ntfpqdE+sSu/jzw8vESjx8Xq
         CS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974938; x=1787579738;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RPANiFSwQx1UeEN6L9ImsPRlhPzOEZbKWDb7jJt3s4=;
        b=QnzhMGZezNo/WMIUnmTKLLsF77G9Fw6MG5F/9S/4UXBooFts/FM8A0bnq/rTAl7Pox
         4KFnK1h3rNpa+VdxEMWOOrNt8Dd0S4foQLzOnMI3qszCRlYMYhnWZezRBMVmF8maTx4S
         Imox6a2MLsvvnvRpSCYjh/eeUZ8iafoXd138BVR62WxwkN0t2EZ7s3esCOIpcCo1gD/I
         g9VcHC+4Boji3Q79eAvOkq1JngmDEDYcyCm8nAaBoi725fpxnGQ5lQDFguaYxuirtdIx
         /4YSQ0GdDCY9WZsltyuwTZPzgHwxqvOWEVXsA6HrrGYTlqZmYk3gB9E+cIN/djmyihSX
         JlgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2EE9OSfBX3wYKmMjcZ8PSHcp5xF6iKH4CsSZy9UWJXFWcxg9nqNA/80MbATtmkMVxCW4jz+JHl0zNQP7kt9aCgc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvd+qPpIzw0qKi7VMb7ODIPtt0J11d524Lxl3KoFee3wEKt3wC
	XjSuow983dPnmh3fXHwuHZ06OgHztais19k/SlS3nmpOBP7xHfB9DmzVUV1sKCwOmDuRUXjTP+g
	Z+X3j3YZH/1HoPZoEWc14Kg==
X-Received: from edbdd25.prod.google.com ([2002:a05:6402:3139:b0:6a3:6d1f:8547])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:44d7:b0:6a3:7423:fb70 with SMTP id 4fb4d7f45d1cf-6a38a8dbe62mr8095073a12.4.1786974938202;
 Mon, 17 Aug 2026 06:55:38 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:15 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-17-vdonnefort@google.com>
Subject: [PATCH v6 16/18] tracing/remotes: Add trace_remote cmdline options
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the same format as trace_instance, add a cmdline to configure
a trace remote on registration:

  trace_remote=<remote>^<opt1>^<opt2>,<evt1>,<evt2>

Enabling events automatically turns on tracing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 204d5bef7a8c..34847463d9e4 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -13,6 +13,8 @@
 #include <linux/trace_seq.h>
 #include <linux/types.h>
 
+#include <asm/setup.h>
+
 #include "trace.h"
 
 #define TRACEFS_DIR		"remotes"
@@ -1170,6 +1172,126 @@ static int poll_ms_show(struct seq_file *s, void *unused)
 }
 DEFINE_TRACE_REMOTE_ATTRIBUTE(poll_ms);
 
+static char trace_remote_cmdline[COMMAND_LINE_SIZE];
+
+static int __init set_trace_remote_cmdline(char *str)
+{
+	trace_append_boot_param(trace_remote_cmdline, str, '\t', COMMAND_LINE_SIZE);
+	return 1;
+}
+__setup("trace_remote=", set_trace_remote_cmdline);
+
+static void trace_remote_apply_cmdline_opts(struct trace_remote *remote, char *cmdline)
+{
+	bool dmesg_on = false;
+	char *opt;
+	int ret;
+
+	while ((opt = strsep(&cmdline, "^"))) {
+		if (!*opt)
+			continue;
+
+		if (!strcmp(opt, "dump_on_panic")) {
+			remote->panic_on = true;
+		} else if (!strcmp(opt, "dmesg")) {
+			dmesg_on = true;
+		} else if (!strncmp(opt, "buf_size=", 9)) {
+			/* buf_size can only be applied if the buffer is unloaded */
+			if (trace_remote_loaded(remote))
+				pr_warn("Cannot apply buf_size after events are enabled\n");
+			else
+				remote->trace_buffer_size = memparse(opt + 9, NULL);
+		} else if (!strncmp(opt, "poll=", 5)) {
+			unsigned int poll_ms;
+
+			if (!kstrtouint(opt + 5, 10, &poll_ms) && poll_ms > 0)
+				remote->poll_ms = poll_ms;
+			else
+				pr_warn("Invalid trace remote poll '%s'\n", opt);
+		} else {
+			pr_warn("Unknown trace remote option '%s'\n", opt);
+		}
+	}
+
+	if (dmesg_on) {
+		ret = trace_remote_enable_dmesg(remote, true);
+		if (ret)
+			pr_warn("Failed to enable trace remote dmesg (%d)\n", ret);
+	}
+}
+
+static struct remote_event *
+trace_remote_find_event_by_name(struct trace_remote *remote, const char *name);
+
+static int
+trace_remote_enable_event(struct trace_remote *remote, struct remote_event *evt, bool enable);
+
+static void trace_remote_apply_cmdline_events(struct trace_remote *remote, char *cmdline)
+{
+	bool tracing_on = false;
+	char *token;
+	int ret;
+
+	while ((token = strsep(&cmdline, ","))) {
+		struct remote_event *evt;
+
+		if (!*token)
+			continue;
+
+		evt = trace_remote_find_event_by_name(remote, token);
+		if (!evt) {
+			pr_warn("trace remote event '%s' not found\n", token);
+			continue;
+		}
+
+		ret = trace_remote_enable_event(remote, evt, true);
+		if (ret)
+			pr_warn("Failed to enable trace remote event '%s' (%d)\n", token, ret);
+		else
+			tracing_on = true;
+	}
+
+	if (tracing_on) {
+		ret = trace_remote_enable_tracing(remote);
+		if (ret)
+			pr_warn("Failed to enable trace remote tracing (%d)\n", ret);
+	}
+}
+
+static void trace_remote_apply_cmdline(const char *name, struct trace_remote *remote)
+{
+	char *cmdline __free(kfree) = NULL;
+	char *events_cmdline = NULL;
+	char *opts_cmdline = NULL;
+	char *curr, *next;
+
+	if (!trace_remote_cmdline[0])
+		return;
+
+	cmdline = kstrdup(trace_remote_cmdline, GFP_KERNEL);
+	if (!cmdline)
+		return;
+
+	next = cmdline;
+	while ((curr = strsep(&next, "\t"))) {
+		char *token = strsep(&curr, ",");
+		char *rname = strsep(&token, "^");
+
+		if (strcmp(rname, name))
+			continue;
+
+		opts_cmdline = token;
+		events_cmdline = curr;
+
+		guard(mutex)(&remote->lock);
+
+		if (opts_cmdline)
+			trace_remote_apply_cmdline_opts(remote, opts_cmdline);
+		if (events_cmdline)
+			trace_remote_apply_cmdline_events(remote, events_cmdline);
+	}
+}
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -1346,6 +1468,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	list_add(&remote->node, &trace_remotes);
+	trace_remote_apply_cmdline(name, remote);
 	retain_and_null_ptr(remote);
 
 	return 0;
@@ -1829,3 +1952,15 @@ static struct remote_event *trace_remote_find_event(struct trace_remote *remote,
 	return bsearch((const void *)(unsigned long)id, remote->events, remote->nr_events,
 		       sizeof(*remote->events), __cmp_events);
 }
+
+static struct remote_event *
+trace_remote_find_event_by_name(struct trace_remote *remote, const char *name)
+{
+	int i;
+
+	for (i = 0; i < remote->nr_events; i++) {
+		if (!strcmp(remote->events[i].name, name))
+			return &remote->events[i];
+	}
+	return NULL;
+}
-- 
2.55.0.691.gc56d675ccc-goog

