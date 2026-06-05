Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B09386557
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677595; cv=none; b=fdaQJzgRRB59sHIxYlHFITojrAfEXj9lWWZAiOc0lo9Y4ccQe9/WRlb7zWXMLw77Z+xY5PVJJ0sqxAgHAy/l36bKTlQTA7Mh4m3VGLvZpJh5OP3xP5vs0LLsYo4ZAukq6NZeoe6fJS/6bjzH8GIMi45m6ylZCk83bPbYDtBPbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677595; c=relaxed/simple;
	bh=7zF3hoBco+kheYhQFPMsuDWaQfk6rSkz3tdGzWg3LOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QyQLAn+FWshEamo5ruHG78zcTzwLxn9zVh/BCRPgkGtc9AB+5d8ZTAVz+zzNof75Tu3c5aBlmNsNN9GS+z6XZhLCSfEA7UzEje3sY9ER2/PJ3keVDrqvwUxiB4z4pyx8dXWon8re02yM7zI7tDJ1kHzcj+viC70FRY0TjzmIqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgPeuUWu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgPeuUWu"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490ab3f6e55so1833555e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677592; x=1781282392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzM6XX/eusxalGqryWLtyN7IPdFFdWTN29SoKegCm9s=;
        b=fgPeuUWuEfPz90NA3wjIH4pOQ5QOu4hFSczP4i0l1rAIchxmV6yvRkhLzZ/BFf+mTk
         jV46X6cnziZ34kwVDRLhUqMSLBqNPmocV7a7eIHZYESQyggbBC5I2wCLIAku7nRtxdyl
         uGZoXEgR4qDr75mIq98BZBR2uyOQrKoWHf1m6g+K4SwYCfJm2huCP/iBJQeTi+izkzVa
         qhNRTuG7pKh+vqBuZjB8cOa+gl1pnvbR4S0lFLeX/7dAbMM8D49utL1Ss0S5JI49kg9r
         2+cw+UjYfPAhbYT+basQYyynl4DzupmYC11ny04aYRdlcC3AS1F9U8/iCEHk4K9t5mSu
         jG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677592; x=1781282392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzM6XX/eusxalGqryWLtyN7IPdFFdWTN29SoKegCm9s=;
        b=WdKqG8m/AZoLO6kbCHw8g4wax7uVnGRoElwNLzJo5/IhdrqN6RxnBsx2deaAHYjVCZ
         rXQekIA4IDUWJjPDzEvOInFQwkSrWcSiYywoUtAKdy5RwBnfSKe1W7+D157CCc/FVX4D
         TPVplQjkvh1ZnOy7bgNV+owD+e/EeA2pTsZfhDB+vWksDZzYyDUeGc7XZtz6T9Jh0HtQ
         C8Nv8zbJ5W7auQnuSu5RUm+nOI8cFroEDDcKtg1uf4g//Z8Bq1pcILQ4akgf5GRtaHL/
         HAJ+fSqD83S2+rvbZHa8iZEEaQcTHf9V6dGtMcDNcxJvZoXU95tYWMtCHN6mV7lucwYD
         7pAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hkXkyQpoMkRqpQk2eA/G8VsIC3C2QaNrY9u2ZrCiKVyLgwrsmPwgdZH1Hcam6TKRbQT9aX7qAwAviPQZiEsJLRRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAABP2kyHW9z4vk7AACUf/jmVInTyrGZ+bMuvSV8RL9Mb3+luS
	1h+K9zikuQKaUPyXTxOwJAx5J/XpBgAmhebJn8A74Ye1p0P1uobq3k1DjCkVoOE/ACfi6wsax5I
	uu2OFtIx7PiRfRj9pCoUfCw==
X-Received: from wmph20.prod.google.com ([2002:a05:600c:4994:b0:490:bd79:13cd])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468c:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490c257c3c8mr77547205e9.12.1780677592385;
 Fri, 05 Jun 2026 09:39:52 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:23 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-17-vdonnefort@google.com>
Subject: [PATCH v2 16/18] tracing/remotes: Add trace_remote cmdline options
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the same format as trace_instance, add a cmdline to configure
a trace remote on registration:

  trace_remote=<remote>^<opt1>^<opt2>,<evt1>,<evt2>

Enabling events automatically turns on tracing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index f72fc862ae7f..a0a372c47562 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -13,6 +13,8 @@
 #include <linux/trace_seq.h>
 #include <linux/types.h>
 
+#include <asm/setup.h>
+
 #include "trace.h"
 
 #define TRACEFS_DIR		"remotes"
@@ -1167,6 +1169,132 @@ static int poll_ms_show(struct seq_file *s, void *unused)
 }
 DEFINE_TRACE_REMOTE_ATTRIBUTE(poll_ms);
 
+static char trace_remote_cmdline[COMMAND_LINE_SIZE];
+
+static int __init set_trace_remote_cmdline(char *str)
+{
+	static int idx;
+
+	if (!str)
+		return 0;
+
+	strscpy(trace_remote_cmdline + idx, str, COMMAND_LINE_SIZE - idx);
+	idx += strlen(str);
+	trace_remote_cmdline[idx++] = '\t';
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
+			if (!WARN_ON(trace_remote_loaded(remote)))
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
+		if (strcmp(rname, name) == 0) {
+			opts_cmdline = token;
+			events_cmdline = curr;
+			break;
+		}
+	}
+
+	guard(mutex)(&remote->lock);
+
+	if (opts_cmdline)
+		trace_remote_apply_cmdline_opts(remote, opts_cmdline);
+	if (events_cmdline)
+		trace_remote_apply_cmdline_events(remote, events_cmdline);
+}
+
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -1343,6 +1471,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	list_add(&remote->node, &trace_remotes);
+	trace_remote_apply_cmdline(name, remote);
 	retain_and_null_ptr(remote);
 
 	return 0;
@@ -1822,3 +1951,15 @@ static struct remote_event *trace_remote_find_event(struct trace_remote *remote,
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
2.54.0.1032.g2f8565e1d1-goog

