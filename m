Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988486;
	b=ikePaG057Oigxj5J4URigavUTNOO7PnedniYiTjgVE8dckE5cxdHG21uNTRdF+NWmtY7
	 WMYAiaoNfVuX7vHXIOCH9scbzQ8Gnp7SIwK6neaTdbH9rhgHc6Qui4jX82ROsxo5or0q0
	 /pUoZ7n8H32odoe1NEx7gFJCFCl5grF6bOEOp8/qAd8qvZ4uz3XHlwLazJr/8ZiujMq2X
	 lEOTBU/AvaxdTPKAffi+LKvyeONb0Q7r/dgA7PS9ZuiAEnq2KO0qYnwN/wwC0Q6vyj0Sh
	 qV29aK64YJXGmggoq9/ech9EiVGgQaCb8qZPCINzKDkGwFzN5MhmXzss3t1PlqA5oGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RGdmMv/zejXl0U6EZP3BlJHi6QkCr6F3J9LIF8hljBo=;
	b=wT5vrvl6qSXGjuPKnYcf78IbsTKbgylj1SZCrMI82HOJchLeaZGs0j6OcTcrxWPqC296
	 knfpuyEWK2iLWyqY4mBvH3V4rENJ5dnVHPsg/SXmp6p+joAULe8uY5clLEMfd9p5WuYFO
	 c1EjuRSGaOCLWLLM1sknob4D+BOc4gIxjyo53ufcWjAjKtH01KV7OR75prbHLXVqNbOZ5
	 cIV9WgNFUFsl8hV2DVJBahqs512GIVzfkylR6P7LeqofjkJD1nVK8dsTo/+gCuiVieu0x
	 EwbzaPCcl7scp5/BZnS7V2TgVz3TwwRFAYgobzSJ8oyUzkESb6xqGf0n0YAcXZXveSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NCTRVGOQ;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F5608360D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B6F5608360D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NCTRVGOQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49953abe51fso7317395e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988485; x=1794593285; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGdmMv/zejXl0U6EZP3BlJHi6QkCr6F3J9LIF8hljBo=;
        b=NCTRVGOQpOKwpIsobsxmzo7UkslqKtAbghaKQMmZ1QUiEncvYK0fL6wkGL7q4JXoWV
         pZEradxsKS5rs2IR8CQ/PZ4xNXXjFsBp9ghe0JxGr1U8t7jIJNS7SJ0a52i9Y9sYOFo6
         KXZ3Gmm9Gs51aH7Wvr/mzkcU17dP1EaUfF6yO/cG9gAaoyyNfK7nqdBxSxSUdsrvkNtX
         4/dFFBVaDN/f1qXzNjV9fA01LRSORM8YsPwOlIQjA11F8fqpDXb+zhNOayAetbGYMyBW
         vGo4sNBfZtsPolnWIbJUVG/sld+bkvLdd6Ea9hLFaT67Od2eKWAKo4QwioaWT3aXLHSz
         RUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988485; x=1794593285;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RGdmMv/zejXl0U6EZP3BlJHi6QkCr6F3J9LIF8hljBo=;
        b=P5AB8O72fG/lpKaWnf8bf1O8X5zX3UBX67BtnXCDC/wlW9p5c/1FliO4nbciex2ixq
         XT8arr2dQnkgpwjUKFIG0z7QzQPRP7Xq39xZ6pCd1nI6ZBw1niLsoK862uVXMbHkFzp/
         vO+kHRCX8P8U6LqxZHoUoNZGn9wdojPHuyuwQsWxXzwT6c9+567/djWtay9w92l7lgcl
         shYM5t4dj/mkya8ltjOAwrO7bykVtOcGqULMY4IxCml1ROo7hW1V7qXS7Iv36BMAtMLU
         n1kjhJgKZtidiXo3NC3NPMAkXSJ+4UZrM2yivj6ku0qNSaxAByM0WvrZwwlOey4uVuyO
         tBtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzalR43XEaptNa8j017b5kF8QcpVYtLVhovljjWI8cT1Mpbuj9hpFZfnXFVMuWFmMas7qUeF0k0RZ4NmOzX/2TL1OI=@vger.kernel.org
X-Gm-Message-State: APuU4Z86JGgAxFW3ljZjoXDZ1IBF4ognvIp62l76Q0l1b7AIw52rLm84
	NLTIkNC303G72PefTxcNqzhvyJe6yGKADJ5rJ6qzTKq/e7qdXaHGxXH8Vio5HxhUUlHb+nJ8wrS
	cXpcg3+fhpuGZVNFtvWEx1g==
X-Received: from wmfx12.prod.google.com ([2002:a05:600c:2d0c:b0:4a1:f979:6ce2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f16:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4b6dea6a06cmr53003985e9.21.1793988484831;
 Fri, 06 Nov 2026 10:08:04 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:55 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-20-vdonnefort@google.com>
Subject: [PATCH v8 19/21] tracing/remotes: Add trace_remote cmdline options
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
---
 kernel/trace/trace_remote.c | 144 ++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index ebfc2dd67b79..9fa8d38caa3b 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -14,6 +14,8 @@
 #include <linux/trace_seq.h>
 #include <linux/types.h>
 
+#include <asm/setup.h>
+
 #include "trace.h"
 
 #define TRACEFS_DIR		"remotes"
@@ -1177,6 +1179,135 @@ static int poll_ms_show(struct seq_file *s, void *unused)
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
+static bool trace_remote_apply_cmdline_opts(struct trace_remote *remote, char *cmdline)
+{
+	bool dmesg_on = false;
+	char *opt;
+
+	while ((opt = strsep(&cmdline, "^"))) {
+		if (!*opt)
+			continue;
+
+		if (!strcmp(opt, "dump_on_panic")) {
+			WRITE_ONCE(remote->panic_on, true);
+		} else if (!strcmp(opt, "dmesg")) {
+			dmesg_on = true;
+		} else if (!strncmp(opt, "buf_size=", 9)) {
+			unsigned long long size;
+			char *end;
+
+			size = memparse(opt + 9, &end);
+			if (!*end && size && size < ULONG_MAX)
+				WRITE_ONCE(remote->trace_buffer_size, size);
+			else
+				pr_warn("Invalid trace remote buffer size '%s'\n", opt);
+		} else if (!strncmp(opt, "poll=", 5)) {
+			unsigned int poll_ms;
+
+			if (!kstrtouint(opt + 5, 10, &poll_ms) && poll_ms)
+				WRITE_ONCE(remote->poll_ms, poll_ms);
+			else
+				pr_warn("Invalid trace remote poll '%s'\n", opt);
+		} else {
+			pr_warn("Unknown trace remote option '%s'\n", opt);
+		}
+	}
+
+	return dmesg_on;
+}
+
+static struct remote_event *
+trace_remote_find_event_by_name(struct trace_remote *remote, const char *name);
+
+static int
+trace_remote_enable_event(struct trace_remote *remote, struct remote_event *evt, bool enable);
+
+static bool trace_remote_apply_cmdline_events(struct trace_remote *remote, char *cmdline)
+{
+	bool tracing_on = false;
+	char *token;
+
+	while ((token = strsep(&cmdline, ","))) {
+		struct remote_event *evt;
+		int ret;
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
+	return tracing_on;
+}
+
+static void trace_remote_apply_cmdline(const char *name, struct trace_remote *remote)
+{
+	char *cmdline __free(kfree) = NULL;
+	char *events_cmdline = NULL;
+	char *opts_cmdline = NULL;
+	bool tracing_on = false;
+	bool dmesg_on = false;
+	char *curr, *next;
+	int ret;
+
+	if (!trace_remote_cmdline[0])
+		return;
+
+	cmdline = kstrdup(trace_remote_cmdline, GFP_KERNEL);
+	if (!cmdline)
+		return;
+
+	guard(mutex)(&remote->lock);
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
+		if (opts_cmdline)
+			dmesg_on |= trace_remote_apply_cmdline_opts(remote, opts_cmdline);
+		if (events_cmdline)
+			tracing_on |= trace_remote_apply_cmdline_events(remote, events_cmdline);
+	}
+
+	if (dmesg_on) {
+		ret = trace_remote_enable_dmesg(remote, true);
+		if (ret)
+			pr_warn("Failed to enable trace remote dmesg (%d)\n", ret);
+	}
+
+	if (tracing_on) {
+		ret = trace_remote_enable_tracing(remote);
+		if (ret)
+			pr_warn("Failed to enable trace remote tracing (%d)\n", ret);
+	}
+}
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -1353,6 +1484,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	list_add(&remote->node, &trace_remotes);
+	trace_remote_apply_cmdline(name, remote);
 	retain_and_null_ptr(remote);
 
 	return 0;
@@ -1840,3 +1972,15 @@ static struct remote_event *trace_remote_find_event(struct trace_remote *remote,
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
2.56.0.455.g6c5a503b38-goog

