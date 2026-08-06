Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FC3A5429;
	Thu,  6 Aug 2026 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978427; cv=none; b=cQiZ9F4YnPMig7vq53nkxlw+/b9xcgF31o/5x+lMfpf9IfEoP2ZqYELIae2HIQI2yV+KNemxAlBbblEVvKPyHJF4HmRCAIwlrjtALYzP5XbToXdmxlxXUmiLeHjPqRSYWaRf8OMvCL+bWl2xTdlWbf/5zRP2sOS0xSkoHJCGmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978427; c=relaxed/simple;
	bh=aWlPQzgF2eqH7UPINhTPXLY1l6uBW3E44x4GyVYsmFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mo+vAPMhPdSR4+G7okjyHrxZG4I72uWIExkeSWMadJrYArKpc+JYCOYyb3xTI9wMKl00VFgsvio+fdfg2Iqfj2P/aGtz/6EaHJoAWNd4oiXFmFwDMtcNIMcybv8jm0aZcP8o7aUMI7p7EqkIIvfuTh/hJaiJjkTAFnrVpbPdW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcgGIUCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcgGIUCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632BF1F000E9;
	Thu,  6 Aug 2026 01:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785978425;
	bh=lyeQQY/9uxHSjcdz3qjuvR/fuu1OhucK52DTtzuVb90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LcgGIUCDew/CTcIoXKnL/3XgMfg2Wbr/PvIMV5DvhuVzAncXjh/Jmq3TYhi8PJhaH
	 JjPU6/pDNebxJHEU8MOSoFzWqFpTN3PuI84hVnFjDTREGQw8pihfXVwKqZcyUlyr9h
	 l+Hnoy4+bcLCmlSYmIeKsqTs+FbufTXB9+TJHx8rP7ceY2+aEAfnLvkz+FFAdZRm2i
	 w6xMZQwRJRVsFUHawor8FOGnkbecjnVPPckovwcq05wu9n7Kzwsyt7Tw3V3ZzFZKbn
	 5j5i3VrOqnG3QrXYj1e2xCbl7xY/BlKKLdu+KO/5JrBvP2/bRpE1zdirAli0lJhP1i
	 qNSrsX81sW76Q==
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
Subject: [PATCH 1/2] tracing/boot: Add support for eprobe, fprobe, and tprobe events
Date: Thu,  6 Aug 2026 10:07:01 +0900
Message-ID: <178597842125.123558.2594525097237345437.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178597841107.123558.13065821394773752510.stgit@devnote2>
References: <178597841107.123558.13065821394773752510.stgit@devnote2>
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
 Documentation/trace/boottime-trace.rst |   18 ++++-
 kernel/trace/trace_boot.c              |  113 ++++++++++++++++++++++++++++++++
 kernel/trace/trace_dynevent.c          |    5 +
 3 files changed, 133 insertions(+), 3 deletions(-)

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
index 2ca2541c8a58..6ecf1a035caa 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -18,6 +18,7 @@
 #include <linux/trace_events.h>
 
 #include "trace.h"
+#include "trace_dynevent.h"
 
 #define MAX_BUF_LEN 256
 
@@ -172,6 +173,109 @@ trace_boot_add_synth_event(struct xbc_node *node, const char *event)
 }
 #endif
 
+#ifdef CONFIG_EPROBE_EVENTS
+static int __init
+trace_boot_add_eprobe_event(struct xbc_node *node, const char *group,
+			    const char *event)
+{
+	struct xbc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *val;
+	int ret = 0;
+
+	xbc_node_for_each_array_value(node, "probes", anode, val) {
+		if (val[0] == 'e' && (val[1] == ':' || isdigit(val[1])))
+			strscpy(buf, val, MAX_BUF_LEN);
+		else
+			snprintf(buf, MAX_BUF_LEN, "e:%s/%s %s", group, event, val);
+
+		ret = dyn_event_create(buf, NULL);
+		if (ret) {
+			pr_err("Failed to add eprobe: %s\n", buf);
+			break;
+		}
+	}
+
+	return ret;
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
+static int __init
+trace_boot_add_fprobe_event(struct xbc_node *node, const char *group,
+			    const char *event)
+{
+	struct xbc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *val;
+	int ret = 0;
+
+	xbc_node_for_each_array_value(node, "probes", anode, val) {
+		if (val[0] == 'f' && (val[1] == ':' || isdigit(val[1])))
+			strscpy(buf, val, MAX_BUF_LEN);
+		else
+			snprintf(buf, MAX_BUF_LEN, "f:%s/%s %s", group, event, val);
+
+		ret = dyn_event_create(buf, NULL);
+		if (ret) {
+			pr_err("Failed to add fprobe: %s\n", buf);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int __init
+trace_boot_add_tprobe_event(struct xbc_node *node, const char *group,
+			    const char *event)
+{
+	struct xbc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *val;
+	int ret = 0;
+
+	xbc_node_for_each_array_value(node, "probes", anode, val) {
+		if (val[0] == 't' && (val[1] == ':' || isdigit(val[1])))
+			strscpy(buf, val, MAX_BUF_LEN);
+		else
+			snprintf(buf, MAX_BUF_LEN, "t:%s/%s %s", group, event, val);
+
+		ret = dyn_event_create(buf, NULL);
+		if (ret) {
+			pr_err("Failed to add tprobe: %s\n", buf);
+			break;
+		}
+	}
+
+	return ret;
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
@@ -477,6 +581,15 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
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

