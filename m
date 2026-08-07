Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7340F73D;
	Fri,  7 Aug 2026 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139057; cv=none; b=avm4KKxNgqiJ4jAx8sKcjwj5dX/9QGfh0P81kZZ4KHKT/fmL3rHMinzWN0EqMv0XCeINOeNoQpKSYg2ugNfmvzd1V3CpLwHr8UyOp4JkEi61fItR6gHb7lQtIz4HaFNlrjbDOzqW7LGK1OAhp+vsxNZDeE/9BqQqjrsIiNl1Ex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139057; c=relaxed/simple;
	bh=PgpLUGTVQ9cpmS/93k5L9eHzQDq1uZWcok9j32iq7Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULwPj31+bFcv7DrX0rBVBfeVYuyroNCScoI3Fk42WbWP7Cazpmmfj+RMNbX01UwjoQlkmhX0dSK7fOK7BbgLUWaiioFue2HBCsY+SrxkLX0En69sRvNz9etcqQPv2+ZSqSlFSHnV9swHD697uP7THy4NqXl6C/BCydHSrNv70EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz1JRykw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz1JRykw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F8D1F000E9;
	Fri,  7 Aug 2026 21:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786139055;
	bh=C+xXl80bd6x34cCIP2RcHDAoitBXU5S8s9xnaRNvAjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hz1JRykw1TBu53Dhq3dC8Msll4eE3Jj0UmwRxvrjrGiimGhzN7rQIXdk2PcC8BrKb
	 FbLM0HrtB384WfMDxR8CryQtJX0HE/yuVz12w+zuhYuzUsgg3/A13VmtikuxBGIwkr
	 QKf7HCU6PXYEwspGl9VUNNTgwpiVEUqiZHSPNaAQDmRhz03kNgl0tZHkCill1tis/6
	 sQNMu3rOUeSbcrl5TAE7U1AcusXcHM+vEsApoZsIUWP1Tvkq/4WT3TS5ELNU1i5sBf
	 ZqgHc0IK0E1E7an/4dM4zMc43vCZpiQl9nstG79shCgrtURCZuhzRX4ZLBK8um2J8r
	 1lMquUYXZr22g==
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
Subject: [PATCH v3 1/2] tracing/boot: Add support for eprobe, fprobe, and tprobe events
Date: Sat,  8 Aug 2026 06:44:11 +0900
Message-ID: <178613905149.259829.18185480460810689421.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178613904128.259829.16130019979800943264.stgit@devnote2>
References: <178613904128.259829.16130019979800943264.stgit@devnote2>
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

Changes in v3:
 - Check return values of strscpy() and snprintf() in trace_boot_add_probe_event()
   to prevent silent buffer truncation when constructing probe event strings.

Changes in v2:
 - Fix raw command detection logic for eprobes, fprobes, and tprobes
   by requiring ':' or isspace() after type prefix.
 - Consolidate duplicate loop logic into trace_boot_add_probe_event()
   helper function.
---
 Documentation/trace/boottime-trace.rst |   18 +++++-
 kernel/trace/trace_boot.c              |   97 ++++++++++++++++++++++++++++++++
 kernel/trace/trace_dynevent.c          |    5 ++
 3 files changed, 117 insertions(+), 3 deletions(-)

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
index 2ca2541c8a58..5da0a8bbb110 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -18,6 +18,7 @@
 #include <linux/trace_events.h>
 
 #include "trace.h"
+#include "trace_dynevent.h"
 
 #define MAX_BUF_LEN 256
 
@@ -172,6 +173,93 @@ trace_boot_add_synth_event(struct xbc_node *node, const char *event)
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
+		if (val[0] == type && (val[1] == ':' || isspace(val[1]))) {
+			ret = strscpy(buf, val, MAX_BUF_LEN);
+			if (ret < 0) {
+				pr_err("%s command is too long: %s\n", type_name, val);
+				break;
+			}
+		} else {
+			ret = snprintf(buf, MAX_BUF_LEN, "%c:%s/%s %s", type, group, event, val);
+			if (ret >= MAX_BUF_LEN || ret < 0) {
+				pr_err("%s command is too long: %c:%s/%s %s\n",
+				       type_name, type, group, event, val);
+				ret = -E2BIG;
+				break;
+			}
+		}
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
@@ -477,6 +565,15 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
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

