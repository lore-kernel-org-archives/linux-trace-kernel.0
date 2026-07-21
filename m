Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFF4DB54C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630203; cv=none; b=E3r8fKdQJ3hnKr6qbpV1Pv+p2Pbwcshq/QfSZblon2MSOysjnhpscv99Tn4Uk48flblQMyX+xfUnBlhbU+gJLaBsoUgKRgntbhrw6iNwh4WQxXgr8UNpNQR4hNkyoctVWkdtR4hCcT6ViyQHnLMQ7YOsy7xGROMwHSMic5Nvo5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630203; c=relaxed/simple;
	bh=5NlliOoW/GE77s7/nTsi0Mxratp1HC+AzLBu9Qn/utU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDSoK5QKGnp+yvW58mGMfEjJaR/eKAJARH0Rxy9OzCj0MV1Cc334sWKH7i2/sWL88OU8GaAxa9iP6MjussBvkFWRIM7B0/GsdLDFYfFBIwjMp7omOZ+oXBBEBRzoj7xwBm51G+T+2JbZ/+y7HIbqDvn/vbVBYVvKqnpdBbM3RrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PziqwD6z; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PziqwD6z"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f726186c4so1601439f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630198; x=1785234998; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wO0RZSdKiY6sJVy+r61ubMEkeGcDxujLS3NgS+rPaUM=;
        b=PziqwD6zIssiOp+dE9v3I+ALEzbAX24z9QUANq1q/4/PA7sEqLUtjSk5jHnTVWbPTj
         uPgRbj9zaZf0SGK0BzvcC8P7r2kvSG7kxR0wrSEOfQy9uxr1vbTPuD+LrLHO6z0twIp2
         MAcYw+wDpubQkEH1s17BDkb3RaYBBqaLKHgjME6Dm0Z9Z6Xsb69TGo649/Ux96EPEarD
         eKDNYAfbVVGRju4UNkWPvwlKB7aHMXyNWqDOk7cEgmipCrvVlOzDweB9tOzCE0QEIH41
         6R3yrcxjKY2+r5/kpAn0kyf2WHSmoZ3yaolS8Ld/tXh0yVkOpMSbLB1s+NarAgjXIkxN
         qTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630198; x=1785234998;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wO0RZSdKiY6sJVy+r61ubMEkeGcDxujLS3NgS+rPaUM=;
        b=e28CUn+S3cZMT10Oz88jNJkcXE/GqAtjoVmkFv0foRYMOUydXS5w4MwJbuIEz5Q/J2
         ppN4CEqrhbNjj639Y3WVUpHZZlr/uut/A2C8aQlE8lDz+GA6YdUn+NJditrlOQ5pDbNe
         F+cfeG0jxl4qqLehz76glh6pjdbLG1maTSeupTKJiYbqBAR4c0qra81FYcp6iQu2esVg
         nHAHHO67W5WCfADVe1fWMDvUmmCMvUhBN0Izl6yhtHuEiHhIVSU+oAWuuGQZgcJJnJGJ
         psVCyUrJXm117LiaQsQ+/zBd8oTx1NzBSY08KdCusCshXv656l9nMiBeh6ZmrdXf/gFO
         fTag==
X-Forwarded-Encrypted: i=1; AHgh+RofQSPAgMpW0MCkzzlx1tOsTB1IfG7sRbtlo1s0hrXgSnzESjpYLQ3H0Vl5xTqj+OJJqbySLEOhPh76G7gcKPaHkEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/JAKIJwTfuMtj5o1Lgem20I4wSBQJSRZVnkIa+q3U+Y8oVua
	M0FstmVEE4aT6VbZe8SuZPfQBQs2kmKPTEhQrRD8Gbajmo3uYREcahbT11PK1rYBkwZRL4+aoKw
	2ubNitANM49A6foYFrdPydQ==
X-Received: from wmbgw25.prod.google.com ([2002:a05:600c:8519:b0:493:c197:f6e8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4453:b0:495:4f62:1ff7 with SMTP id 5b1f17b1804b1-4954f622066mr158709115e9.17.1784630198266;
 Tue, 21 Jul 2026 03:36:38 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:36:01 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-17-vdonnefort@google.com>
Subject: [PATCH v3 16/18] tracing/remotes: Add trace_remote cmdline options
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
index 33dd3333b90a..11de5cea876e 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -13,6 +13,8 @@
 #include <linux/trace_seq.h>
 #include <linux/types.h>
 
+#include <asm/setup.h>
+
 #include "trace.h"
 
 #define TRACEFS_DIR		"remotes"
@@ -1169,6 +1171,132 @@ static int poll_ms_show(struct seq_file *s, void *unused)
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
@@ -1345,6 +1473,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	list_add(&remote->node, &trace_remotes);
+	trace_remote_apply_cmdline(name, remote);
 	retain_and_null_ptr(remote);
 
 	return 0;
@@ -1818,3 +1947,15 @@ static struct remote_event *trace_remote_find_event(struct trace_remote *remote,
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
2.55.0.229.g6434b31f56-goog

