Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7D3911A2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551245; cv=none; b=ue++defLUSLW6y4CVgCjtR0rhBrw0GjBvHPa2U0W+YdYESfniVqw7aJgH30EJccBqTgAp13bpTaxwcgtcLXTpVOg3ybLP4TZuJGFMsHjINB9TMOmstgRvJ92I5rFLdrIMNiuSNw5O4JJ/TKV1vCxYgb9cvebqTXQ+RDiWhXTa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551245; c=relaxed/simple;
	bh=wsZEE9Zz0mqjuBsNamOoGhBoBuELzXWcnKGuADaQB2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X5xtw7iyjJts38p1K/NJgaWi/bQZy3DvKcqIb5wleGopmJw3zEtWAb9GIGGq0q3Ckn5T/32hSghjMgN2QqmblgHFnQdq8uMlINFFKGU7qcn2fqZKrLtAuD2Z4ajznuHDCqKKy0yFGVAxtfqea7AiKUpCI/y8JtunwviQPMfOCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFiEJEJ7; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFiEJEJ7"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6d70223dso831824f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551242; x=1787156042; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ji3tCFeKYvvU/YCTSwEXd6efxBELYIn3Hl3vNbltnQE=;
        b=KFiEJEJ7+2lxI4FZBZ9OtlAxr6Lyc6zh5KG5550PEm7hVX0dm2QuV3uLFim+ggcsuI
         GhnkSqNk+Sn9oaRHuaFl6DNagtiCSgiDLDI5QhoOVS0obTLKrDvFmIyR12MF5z221GkT
         6Jpt5fvC9p1lGgV181J6FKP7YmvVyuB34M11NY8UC7v+buPNy0TNQ2HjJMdxok0HN1QQ
         f4Qqj41Xeur43ht/epBzO1dgus1n5RnfNTvjl5jAYBwjo3MQmq4Y2BMLxHbPwXUXI8j7
         AuR9R4V5NRZsBQc/xxu7rU9hrrWZ7Qhwc9ccDJVKHlnVdiwBGRCVRKbuzjNyOO3cjBy8
         Y+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551242; x=1787156042;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ji3tCFeKYvvU/YCTSwEXd6efxBELYIn3Hl3vNbltnQE=;
        b=SLabjrPS3exE1p8fizI9AVMqvl/kCNiOvYTLlb4GJbLl52LyijkxTkeAEdAx6CsGRH
         cVm0pDCr/HOlipl5oB2RFtkTtf1npD2sFUP1sabjshK6Wa/LTTJvYpyMX/+GgpZfV+3g
         QlFQA9ZDUWoR/NKBeDazwA6uFqaNSKIkYkHxjlTbuhxGKxYYEfG1e026XzhRLW0I6gSY
         sW8TxBCrZhEdFmL7G4hG+j5XfL+5taByayWFz1I41PHcfn3oNyIZBA0EGoKOHgNPuywP
         x37zdEhLIoUs24tSbvbcfJ+EvNtcezip+YgSdjis6lckcAjaTrONYIviRQo3FxGMpgdr
         FfDg==
X-Forwarded-Encrypted: i=1; AHgh+RpzzyoIJTWe24PG3fDzZjf7I1s77zmw+oNvp7Ix0tDoaY06zxQLx9uJlvmhHdfeR7A4Y7SPGjHEfURy4ELFiqshqKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0WCSsEos25xUJ5C3kFE7ZRJOMG0q/K23L8RmKBCCNfvHUIKH
	Voz+Q1LjlrFFYpNiE7FmeYCh7YyBiBJRcjTGs3PTZP0yNrK+l2cKEcvAw+O3lknOHVhLTg2zfiX
	m4Y0JPSOlzJrg3zdxm2YR3Q==
X-Received: from wrql16.prod.google.com ([2002:a5d:4810:0:b0:47f:90dd:e729])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25e3:b0:47f:90a4:ff42 with SMTP id ffacd0b85a97d-48152b0a8ddmr9032868f8f.5.1786551241963;
 Wed, 12 Aug 2026 09:14:01 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:38 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-17-vdonnefort@google.com>
Subject: [PATCH v5 16/18] tracing/remotes: Add trace_remote cmdline options
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
index b1c75666ab63..8764d0ed3909 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -13,6 +13,8 @@
 #include <linux/trace_seq.h>
 #include <linux/types.h>
 
+#include <asm/setup.h>
+
 #include "trace.h"
 
 #define TRACEFS_DIR		"remotes"
@@ -1169,6 +1171,124 @@ static int poll_ms_show(struct seq_file *s, void *unused)
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
@@ -1345,6 +1465,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	list_add(&remote->node, &trace_remotes);
+	trace_remote_apply_cmdline(name, remote);
 	retain_and_null_ptr(remote);
 
 	return 0;
@@ -1828,3 +1949,15 @@ static struct remote_event *trace_remote_find_event(struct trace_remote *remote,
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

