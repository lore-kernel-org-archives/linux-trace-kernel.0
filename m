Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2D4A2601
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261929; cv=none; b=MXTf5rJqrGvZbDwSXgk+U3jUnplknFY0COq006rXoI+VOp7YYxvI/i0TPJrpP//UMNjhJg6LzrTb1IAHwId7qgV6vebkRymD8KsMA+t+IIjifZc9jekJiFh3U6o2YpemY+YrIZ1vVumQgG6Fe+NT4RnkoCt2En41oxiQGWqg124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261929; c=relaxed/simple;
	bh=Jrp7mt6cQSQ3EkaTbrA76OUMeNLl2/PHGv5RXvN55+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=co9VUtEZNCYmTPdiWWKVaJnD9p6CF+wVdfemDE/zGMWlV9GqdLWxmwmI+ga5u/9LOKaOFXxa6ZKMtKWoDHV/RG+4lI5u+u2BIvbckHwQiEwalqucUwXtKWYJfv/NwL6tRUw9s6nJ80C8WYm3d5hEpfpUd0WXT/8FvszJAOxoqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+w7Itjk; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+w7Itjk"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-486f9d150c3so1407080f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261924; x=1790866724; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GSVp2wd2bElbaVHZ4PZQs4KwrjTqCz18IG8mqkgeKvc=;
        b=B+w7ItjktoYHM6m8cA4oa//tTiFen4fgn6uUFGJx+Nrt+LH7lAATI2IilVEFF3lAvS
         StUG0ly5LdkyafYMPfrEHeCMzgAddzTswz2S0fqge716Y9oBQD6eNwo4TNq6LtQPvfdI
         w3pUQg9VOlvs8knqRH8hhB82Y9FVEuICTfDdyadhBIytPvNzb2I4ENtE++Scir88DgCv
         hV92Jhp0AP5ujO70DPdY1/55paYZ8uPyZjgxva2rGLNaJsM4IYubL/i7+klxQSYddVOm
         JuaufW6d27qQhbtyoxXt0EUGRpDQMxT6p4dTFFOALragppUZfH9tRy8xf/UpPkPysGmS
         /6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261924; x=1790866724;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSVp2wd2bElbaVHZ4PZQs4KwrjTqCz18IG8mqkgeKvc=;
        b=FqLoNh0gjPDEzcnOI3kvtq3Yv9RvAsGfLjVv7JP96d33X68UicwK4JrQooTKix1hoB
         kqApv0lyoPldytedOVOYQ+xoU8iu9tuwMeq+8cuLE2G/V7gB+ijV/8PB8vFsYCtb2U51
         vwRpER0dqVsq1dU25dngBZbad/aPz1tAZJUUBCbVlQfckq7AGpANGGhJdlZw3i7E9ce9
         UQ46iiPpDLKRfN0pSrHolj8yM9sWLJbvALOFCfZao7tCtXbY+zm8HMbIfGiBB2TF8g6h
         n5cPZC/rdJGy/W5ma9a12IyPjvMYpqS5rTf2O2Y3q7RUwivUZ8V7zYFvQ1tyhECwjNx/
         lTMg==
X-Forwarded-Encrypted: i=1; AKwUvBwmRydSrcLo9GsxkeEcJ6heU7cbgtI8Lj86XYP5hi2BnsM3iKpnj+XqrE2PHL2iF1b2UbalAgI5MDMjNQu+2HSonDg=@vger.kernel.org
X-Gm-Message-State: AFuF++nc9R8vVuRCWWarYzHu595vh9Di/pw/qFsWNmolI/qQE+Ubpstk
	Vrkeq/0wI+ZpJFa1ApFQ/9Alw6Rx9/UMIv9o4xNdHr6tboRkEsG2piruWzSeWxCtPb6qo2fkcQX
	ldY1lbOW7k10yVOdEk9n1GA==
X-Received: from wraj5.prod.google.com ([2002:a5d:4525:0:b0:487:2ee:a313])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2088:b0:487:27f6:a4e9 with SMTP id ffacd0b85a97d-488716c3819mr4666334f8f.57.1790261924227;
 Thu, 24 Sep 2026 07:58:44 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:52 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-19-vdonnefort@google.com>
Subject: [PATCH v7 18/20] tracing/remotes: Add trace_remote cmdline options
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
 kernel/trace/trace_remote.c | 137 ++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index b2547eb117f8..de41f36e9a0e 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -14,6 +14,8 @@
 #include <linux/trace_seq.h>
 #include <linux/types.h>
 
+#include <asm/setup.h>
+
 #include "trace.h"
 
 #define TRACEFS_DIR		"remotes"
@@ -1173,6 +1175,128 @@ static int poll_ms_show(struct seq_file *s, void *unused)
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
+			WRITE_ONCE(remote->trace_buffer_size, memparse(opt + 9, NULL));
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
@@ -1349,6 +1473,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	list_add(&remote->node, &trace_remotes);
+	trace_remote_apply_cmdline(name, remote);
 	retain_and_null_ptr(remote);
 
 	return 0;
@@ -1836,3 +1961,15 @@ static struct remote_event *trace_remote_find_event(struct trace_remote *remote,
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
2.56.0.rc1.310.g51773c2048-goog

