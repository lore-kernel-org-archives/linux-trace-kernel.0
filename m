Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF993FCB18
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420335; cv=none; b=VWps3l9W6iVRL65LpHi1PbcNn1tGlV6B/Ms5dwi6aDrALbBpTi/KB4E14sFS5UrcHk08G0qA30GYFPeG2Hn+f1+JcvBJPW9SV8j++h+zDm4DpKbpwwcZ/di/g4G3q2VAidI4hapX4G2H509aGbjTQ0hbqqNDtl/7qy8txFJam7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420335; c=relaxed/simple;
	bh=EOsC4lNAkCTryGHvlas+49avT1rN6CF4AOBiIs+ftGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kRLzfJCJ68XqPqVWYdajTV1sRgCpBLTsBDG4EDMmcLIbCx0GhIeyi+rxQjhoVP+KQ8oDByLRvxUZGEWT10WwbiSDkLjI8AH54ApdFqiHAAs5XWFM4nxur6lU3wWLh0duwiBWR5D4OUGKe3R52X3KO3UtW7HC1B2YkwP+6pAL8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSufVFRu; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSufVFRu"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6889b2a4afcso6575108a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420332; x=1781025132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JF0t3krSgEgAnqtmr9Rsu3XY0LyuHZBzjpruwXWfGx8=;
        b=iSufVFRuG2GzURnH9hMRGWD5S6aGgqCiHiSM3lPeq/9AQfplsZUAX9httzdndzNt3Y
         s+dG0yyVMpy9ddjxyddvDTYbjgVrnIRQ1VkenIn4xsUHjmRWMEETRy011ZDS1lX+SDun
         xiFkTJyCUmyMnzGC/N1lTbyaeg3wkRCxlhb8S6YaM8SjZxShQELwY0R8kd747ET1gPyA
         B1lqT30K126KLqTIMG31NHtgWPyjunhhYHg4WxV3LTqDUm23E75qm+9imwtC6hn758to
         DaTKo9mhEyHIN5BMgHcpZjs/y085gfoHCGEP13xD+muzMnqf/znTnW1k8GASeroJyW9w
         PylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420332; x=1781025132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JF0t3krSgEgAnqtmr9Rsu3XY0LyuHZBzjpruwXWfGx8=;
        b=koMrguUIsdW6bS2/eF+riGlcM37Iqq+osTMx7WOCfJPYGA55yaqMeUtmLffF6mTria
         CEekFQyft4/ev/F098GD7dOEHUS5ts/4G8HhCW8WcbQAfZBWvx9yC12qIx9R+w37pxF+
         snammXExiuef+O5msSSygDwKsQavzywjKxbAQ8LYtjgVlu9Tsdnt9fuGiDqBjsuOaH9G
         vjnTLcF0qhroJpdlOhcVv7W672K9WmzunYfNnd4B8/MQjVpvjMZcvAVyZ9oZPdo82wKN
         DuLBtE8/GfCadjMifhk2NwPTu4OJ5L/3b/k1XUof8G8TIe/8aTRz54S8RO9wS5tYbwQ2
         bHmg==
X-Forwarded-Encrypted: i=1; AFNElJ8canAVxyRN0csctfQ5dvcYB8mGQuIZqIO83Ky177RHgqUq/6LGC7OrMtaLnyZgqTCYgJEtizeJL9tRG8H6beUBlH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNMtdslUKlMuwzquqQ694IhjdYxoatlhWDYbT9s3O0lBNizaI
	CmmlornEy78gbg3STmmPBg4pLwzUYiqVmfrU0RtBnHKK/Hltc30CkPF+1OvSOxwIWGVFsm1KZlG
	CmM8dyMdF4uSFS0NumlgrYg==
X-Received: from edqw3.prod.google.com ([2002:aa7:d283:0:b0:68c:60e:c4f2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:cd6c:0:b0:687:e07f:d860 with SMTP id 4fb4d7f45d1cf-68e5e0622fdmr324420a12.26.1780420332451;
 Tue, 02 Jun 2026 10:12:12 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:44 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-13-vdonnefort@google.com>
Subject: [PATCH 12/13] tracing/remotes: Add trace_remote cmdline options
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
index 3164f327d4d8..0b44636b6eea 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -13,6 +13,8 @@
 #include <linux/trace_seq.h>
 #include <linux/types.h>
 
+#include <asm/setup.h>
+
 #include "trace.h"
 
 #define TRACEFS_DIR		"remotes"
@@ -1057,6 +1059,124 @@ static int dump_on_oops_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(dump_on_oops);
 
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
+	bool printk_on = false;
+	char *opt;
+	int ret;
+
+	while ((opt = strsep(&cmdline, "^"))) {
+		if (!*opt)
+			continue;
+
+		if (!strcmp(opt, "dump_on_oops")) {
+			remote->panic_on = true;
+		} else if (!strcmp(opt, "printk")) {
+			printk_on = true;
+		} else if (!strncmp(opt, "buf_size=", 9)) {
+			/* buf_size can only be applied if the buffer is unloaded */
+			if (!WARN_ON(trace_remote_loaded(remote)))
+				remote->trace_buffer_size = memparse(opt + 9, NULL);
+		} else {
+			pr_warn("Unknown trace remote option '%s'\n", opt);
+		}
+	}
+
+	if (printk_on) {
+		ret = trace_remote_enable_printk(remote, true);
+		if (ret)
+			pr_warn("Failed to enable trace remote printk (%d)\n", ret);
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
 static struct dentry *tracefs_root;
 static DEFINE_MUTEX(tracefs_lock);
 static u64 tracefs_root_count;
@@ -1228,6 +1348,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 		goto err_unregister_events;
 	}
 
+	trace_remote_apply_cmdline(name, remote);
 	no_free_ptr(remote);
 	return 0;
 
@@ -1708,3 +1829,15 @@ static struct remote_event *trace_remote_find_event(struct trace_remote *remote,
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

