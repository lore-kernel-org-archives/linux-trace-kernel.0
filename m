Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04846E013
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852254; cv=none; b=dX4jRI4sWHsodXpIh+YJV131i5jOlG8nyZY1OsFG4EuBoU+pJmEakfQkCHry0WAj5LqUBzyBNwij1bbqINesk8RCaQ6k3QbtUIwgGvLB0MdeGmEjEYFdqiSFC0OHc0WVBLCkJtnCYAxvginK8IbzZG3dQRdr/oS5aiCN5zqjR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852254; c=relaxed/simple;
	bh=QGatgsAET/5XqKb3+hsGKw6QkVZbzk2Z1c+qVO2iegI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h3yX9O/gjzoDu1+KGD1cYA2Mx/psw83YIhiLYoSS8DlKgievzLfjYHLSj5U+cX3ecnAmwmUjK8Kq7KdCtLis9CXJz13UPMlySJhngvW+H/6PODvBEWfBIS4W2LefYSDWnzVutd/aKUQ+O5uVtzfbwIqKnfPlxVwesFk5HfzepTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abI1O0cp; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abI1O0cp"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1c25c44d15so293918266b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852251; x=1786457051; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/J+xPvL9n08cw0WZxmpDgbasEs5MnLj6R6UWekeMZ2w=;
        b=abI1O0cpP1+s1pKItgbKz39T+ViRvX1XlxtuwgQudkSI7VPOtR7pSmIR8LNszvVYOb
         ApLStjOC5QEezOeqG6LNHiihX0D3QFd6zmTaGqX/UFN2K3WZPK9UatBv3c/xsqjGP3Hu
         KbQIpuP3s841S4K+c3uTEFzog/ZvDcco1Li6rbwgeHvEUl4I5X5irodrYHkVl0ihJOpY
         9VH4vRkdaA7dRr6sEBG9sIYcWjtxKTQpHEruiI5yhuN8j4JG3AjElruKjUWOeaLvkq11
         PwjIrOPvZ8xUsw5UII0npUmLHlG1ipEaJILYa3qb7RtHtPEpD0VpUp8SfDkG6GIdvT8F
         BWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852251; x=1786457051;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/J+xPvL9n08cw0WZxmpDgbasEs5MnLj6R6UWekeMZ2w=;
        b=DUA7ipjitnWrI+90mtNMY40/4i486ZvoJr+cmJebBHTEbUFdUoCNdAQUTbU5oVlGPc
         0QRpqD/8k5B8osaBfRfWBzJyy2MpzJAAXXVon9S/orzIrdylAIu5sRQptCWfmx5N1Did
         Xlmw2D2LOnSXp3MEmqtouUsxP5Tna6XFyH59Bz4laK7ZIVsWl9Dh7lKR0kXHhLkR6UFm
         2yOLOlzoen36Q0dffBL7upGMke8zXszALW+Q3UNxGlgtlzMuDy74JD7sP3HuzL7d0Myj
         NfugSU4gRkPvNLwNp2W+GRC96d12lzFrNsS1+47NmUG98O7LIssctMnlxDCWtcbZk/5r
         Im7w==
X-Forwarded-Encrypted: i=1; AHgh+Rp9szxw9e8wC6U0PVtDoVe9tfjwWQ88y2EyMucWI7VtZ9hzM58uxGGITGLNskvNi9zNJxBbygYRjtOkzt3sNznXjSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTfTStIlFL0XmPf2oJsElgJ0y9j8091HQat0sP1vLKJBqiXbg
	GVfOB0n96Xb9059zAIg4G9TxVysZSZf73xRFRWxrGl2XnJJgiW90eJ9umMLfdaiCAwNvLn7UMKb
	RVFfvVdxIrsncg+6B+MFjCA==
X-Received: from ejbgz12.prod.google.com ([2002:a17:906:f2cc:b0:c12:5011:7092])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:987:b0:c12:5a0e:3e0 with SMTP id a640c23a62f3a-c20283c4a01mr317099666b.19.1785852251065;
 Tue, 04 Aug 2026 07:04:11 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:31 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-17-vdonnefort@google.com>
Subject: [PATCH v4 16/18] tracing/remotes: Add trace_remote cmdline options
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
index ccdac9fa106a..e72ee6ecf473 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -13,6 +13,8 @@
 #include <linux/trace_seq.h>
 #include <linux/types.h>
 
+#include <asm/setup.h>
+
 #include "trace.h"
 
 #define TRACEFS_DIR		"remotes"
@@ -1169,6 +1171,125 @@ static int poll_ms_show(struct seq_file *s, void *unused)
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
@@ -1345,6 +1466,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	list_add(&remote->node, &trace_remotes);
+	trace_remote_apply_cmdline(name, remote);
 	retain_and_null_ptr(remote);
 
 	return 0;
@@ -1828,3 +1950,15 @@ static struct remote_event *trace_remote_find_event(struct trace_remote *remote,
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
2.55.0.571.g244d577d93-goog

