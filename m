Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278430E0D6;
	Thu,  6 Aug 2026 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029714; cv=none; b=V1BlHgPaGw4KS5K+/SwSQUbiBtQieBIJd2kwmsYT/6l4tqC8sJN50Wj1xzvxgfSq4lLwKyb1hGxvuj/PlY016MNl19L19u8Tdr7juwajMoy/wTNSTow+/cSIGKio0IRm0EHYTm8ONDI/Ipjqn6B+EmFCakoBxN1HuK31CWE23oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029714; c=relaxed/simple;
	bh=MbaVqOimnB2PepN4cP3JP2c8sndbM0AOApiAQvhTTKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUFU3yvWI451It1LHQdaw1aIfsvlGlR5ygf3slWdAaHWKmTfUDHwBHLRKjG+evIJ0CTzhUuh6dbiSTKcM72VhsZATxss3V7xKudbWw2/6kCiv8zPXDm3wKOnM/VngJkwpE8nTIiItxLdui4tTiVIBnReTtj1J3EBk+pH57BXd2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgPiMxzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgPiMxzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9AB1F000E9;
	Thu,  6 Aug 2026 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786029712;
	bh=nkqsTD5ySydxaKtCYDGV3LNnpEbKrG41kBt1atrphzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgPiMxzm48opp5uKy+R3JlknloFP/USgI+oUB8wvoeNUE67+NlBKtTCPTmQpR1jPC
	 Yk+MoxFcvgcu46AyKXQEjxnfqnD1upp8rjq85fqLWxfd8pQk7opjmZtMmXqxE2266q
	 xNSyRqamVgdUxr0lNcCRbotVjJWw9O1ay5BYIU1z395exzP+AKBNo0kbuicE4VkiCg
	 6/a2gruruVh6QyYD5D0zK7dQ8sfRu8DI+A7tGMw/M6F6qUagm7Z8y9rsnD0Kd1l8Lm
	 l/xLGV7OgYdHeFUbEjamthgmSsqVb0omoUKrXnnjOrZ2tdEI9g6Ju6bXUVD74hI+FB
	 sJK9dIawGhiZw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/2] tracing/boot: Add support for eprobe, fprobe, and tprobe events
Date: Fri,  7 Aug 2026 00:21:48 +0900
Message-ID: <178602970854.141946.4094580379384586498.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178602969872.141946.3932041319962687996.stgit@devnote2>
References: <178602969872.141946.3932041319962687996.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Boot-time tracing currently supports kprobe-events and synthetic-events
under per-event configuration options.

Extend boot-time tracing to support newly added dynamic probe types:
- event probes (eprobe) under the "eprobes" event group
- function probes (fprobe) under the "fprobes" event group
- tracepoint probes (tprobe) under the "tracepoints" or "tprobes"
  event group

To support this cleanly, update dyn_event_create() in trace_dynevent.c
so that passing NULL as the type parameter delegates to
create_dyn_event(), allowing generic creation of any registered
dynamic event type from a raw command string.

Update Documentation/trace/boottime-trace.rst accordingly to describe
the new per-event bootconfig options.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Fix raw command detection logic for eprobes, fprobes, and tprobes
   by requiring ':' or isspace() after type prefix.
 - Consolidate duplicate loop logic into trace_boot_add_probe_event()
   helper function.
---
 Documentation/trace/boottime-trace.rst |   18 ++++++-
 kernel/trace/trace_boot.c              |   86 ++++++++++++++++++++++++++++++++
 kernel/trace/trace_dynevent.c          |    5 ++
 3 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 651f3a2c01de..2c3c1fedb92c 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -121,9 +121,21 @@ ftrace.[instance.INSTANCE.]event.synthetic.EVENT.fields = FIELD[, FIELD2[...]]
    Defines new synthetic event with FIELDs. Each field should be
    "type varname".
 
-Note that kprobe and synthetic event definitions can be written under
-instance node, but those are also visible from other instances. So please
-take care for event name conflict.
+ftrace.[instance.INSTANCE.]event.eprobes.EVENT.probes = PROBE[, PROBE2[...]]
+   Defines new event probe based on PROBEs. This option is available only
+   for the event which group name is "eprobes".
+
+ftrace.[instance.INSTANCE.]event.fprobes.EVENT.probes = PROBE[, PROBE2[...]]
+   Defines new fprobe event based on PROBEs. This option is available only
+   for the event which group name is "fprobes".
+
+ftrace.[instance.INSTANCE.]event.tracepoints.EVENT.probes = PROBE[, PROBE2[...]]
+   Defines new tracepoint probe based on PROBEs. This option is available only
+   for the event which group name is "tracepoints" or "tprobes".
+
+Note that dynamic event definitions can be written under instance node, but
+those are also visible from other instances. So please take care for event
+name conflict.
 
 Ftrace Histogram Options
 ------------------------
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 2ca2541c8a58..4a71b91ad203 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -18,6 +18,7 @@
 #include <linux/trace_events.h>
 
 #include "trace.h"
+#include "trace_dynevent.h"
 
 #define MAX_BUF_LEN 256
 
@@ -172,6 +173,82 @@ trace_boot_add_synth_event(struct xbc_node *node, const char *event)
 }
 #endif
 
+#if defined(CONFIG_EPROBE_EVENTS) || defined(CONFIG_FPROBE_EVENTS)
+static int __init
+trace_boot_add_probe_event(struct xbc_node *node, const char *group,
+			    const char *event, char type, const char *type_name)
+{
+	struct xbc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *val;
+	int ret = 0;
+
+	xbc_node_for_each_array_value(node, "probes", anode, val) {
+		if (val[0] == type && (val[1] == ':' || isspace(val[1])))
+			strscpy(buf, val, MAX_BUF_LEN);
+		else
+			snprintf(buf, MAX_BUF_LEN, "%c:%s/%s %s", type, group, event, val);
+
+		ret = dyn_event_create(buf, NULL);
+		if (ret) {
+			pr_err("Failed to add %s: %s\n", type_name, buf);
+			break;
+		}
+	}
+
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_EPROBE_EVENTS
+static inline int __init
+trace_boot_add_eprobe_event(struct xbc_node *node, const char *group,
+			    const char *event)
+{
+	return trace_boot_add_probe_event(node, group, event, 'e', "eprobe");
+}
+#else
+static inline int __init
+trace_boot_add_eprobe_event(struct xbc_node *node, const char *group,
+			    const char *event)
+{
+	pr_err("Event probe is not supported.\n");
+	return -EOPNOTSUPP;
+}
+#endif
+
+#ifdef CONFIG_FPROBE_EVENTS
+static inline int __init
+trace_boot_add_fprobe_event(struct xbc_node *node, const char *group,
+			    const char *event)
+{
+	return trace_boot_add_probe_event(node, group, event, 'f', "fprobe");
+}
+
+static inline int __init
+trace_boot_add_tprobe_event(struct xbc_node *node, const char *group,
+			    const char *event)
+{
+	return trace_boot_add_probe_event(node, group, event, 't', "tprobe");
+}
+#else
+static inline int __init
+trace_boot_add_fprobe_event(struct xbc_node *node, const char *group,
+			    const char *event)
+{
+	pr_err("Fprobe event is not supported.\n");
+	return -EOPNOTSUPP;
+}
+
+static inline int __init
+trace_boot_add_tprobe_event(struct xbc_node *node, const char *group,
+			    const char *event)
+{
+	pr_err("Tracepoint probe is not supported.\n");
+	return -EOPNOTSUPP;
+}
+#endif
+
 #ifdef CONFIG_HIST_TRIGGERS
 static int __init __printf(3, 4)
 append_printf(char **bufp, char *end, const char *fmt, ...)
@@ -477,6 +554,15 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 	if (!strcmp(group, "synthetic"))
 		if (trace_boot_add_synth_event(enode, event) < 0)
 			return;
+	if (!strcmp(group, "eprobes"))
+		if (trace_boot_add_eprobe_event(enode, group, event) < 0)
+			return;
+	if (!strcmp(group, "fprobes"))
+		if (trace_boot_add_fprobe_event(enode, group, event) < 0)
+			return;
+	if (!strcmp(group, "tracepoints") || !strcmp(group, "tprobes"))
+		if (trace_boot_add_tprobe_event(enode, group, event) < 0)
+			return;
 
 	mutex_lock(&event_mutex);
 	file = find_event_file(tr, group, event);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index c4dfbc293bae..6f2e39b797e5 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -116,6 +116,8 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	return ret;
 }
 
+static int create_dyn_event(const char *raw_command);
+
 /*
  * Locked version of event creation. The event creation must be protected by
  * dyn_event_ops_mutex because of protecting trace_probe_log.
@@ -124,6 +126,9 @@ int dyn_event_create(const char *raw_command, struct dyn_event_operations *type)
 {
 	int ret;
 
+	if (!type)
+		return create_dyn_event(raw_command);
+
 	mutex_lock(&dyn_event_ops_mutex);
 	ret = type->create(raw_command);
 	mutex_unlock(&dyn_event_ops_mutex);

