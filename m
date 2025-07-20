Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCD1C84A6;
	Sun, 20 Jul 2025 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992551; cv=none; b=d3jWeTVieirROSSqeuge+Yk6U26g3BtKyj5pnW2GU5Tl1SYvQfrYl1KchYDJq3CPwhyikYYmE/CF7zERUlt6szGpbYSqx4hE04xAeDEiiS261+cC02TJqPj+AsjuJa0kV2j1CEw2+Exk13xYSpToe6jCrOgLEr8sWQuXCfYNlsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992551; c=relaxed/simple;
	bh=ruSnIaoyUzmF4Iq1fSxbSDMwjdBan9AVWbkD9IZkaOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Omnp3iGZ/ADbC2nxz9hH0eU5orGXMXoe8wC8VJj6Gc+G4eOqw5G3i1hCBu1NwVsiTNGTModGq0ssPJ5H1XTgV/0cRWxj7lrp6qvovd8NYGpD0BmT0lCgBEZxVB9n02IH7q7J7v54eipiywoO5mt6kpo7eZnWXxjgBpNJJqecXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKcZ0JK7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKcZ0JK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE29C4CEE7;
	Sun, 20 Jul 2025 06:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752992550;
	bh=ruSnIaoyUzmF4Iq1fSxbSDMwjdBan9AVWbkD9IZkaOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKcZ0JK7zrDs3SYpxlnP863cTASEzvH4olgZk9CDmLxk4nkvpsfwAgoOsf/YQndlP
	 k8WkkA07jtGlYoNe+W1Tz1J0u9MRq8gsDWq30a36h+yG4VHCJs55Q6vuOe9fJ/UooP
	 9h7NeZq4+fgiaQryplcQ0ktEa4NUDR4hWkMP1nkWCLEE1QJcPsT7LbURF+8RpSy2qY
	 QNupP6E2mpMwynH54RC35xS9rIXxHye9wtnnX4rQxkLogNZq645A2U5MWkS4tfeGaV
	 jtDCZYyB5wynjwxL0JnH8So2tNXK7Ofe6xMiCfZmlPLT6OJHp9MGrPvcMvg5OkvYQD
	 QWIftzT+uepnA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] tracing: uprobe-event: Allocate string buffers from heap
Date: Sun, 20 Jul 2025 15:22:26 +0900
Message-ID: <175299254616.418723.15582800834785477413.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175299249728.418723.17799706394466693180.stgit@devnote2>
References: <175299249728.418723.17799706394466693180.stgit@devnote2>
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

Allocate temporary string buffers for parsing uprobe-events
from heap instead of stack.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Sort #include alphabetically.
  - Add fail_mem label for handling ENOMEM error.
---
 kernel/trace/trace_uprobe.c |   40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 797ac1250956..8b0bcc0d8f41 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -8,17 +8,19 @@
 #define pr_fmt(fmt)	"trace_uprobe: " fmt
 
 #include <linux/bpf-cgroup.h>
-#include <linux/security.h>
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
+#include <linux/filter.h>
 #include <linux/module.h>
-#include <linux/uaccess.h>
-#include <linux/uprobes.h>
 #include <linux/namei.h>
-#include <linux/string.h>
-#include <linux/rculist.h>
-#include <linux/filter.h>
 #include <linux/percpu.h>
+#include <linux/rculist.h>
+#include <linux/security.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/uprobes.h>
 
+#include "trace.h"
 #include "trace_dynevent.h"
 #include "trace_probe.h"
 #include "trace_probe_tmpl.h"
@@ -537,15 +539,15 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
  */
 static int __trace_uprobe_create(int argc, const char **argv)
 {
-	struct trace_uprobe *tu;
 	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
 	char *arg, *filename, *rctr, *rctr_end, *tmp;
-	char buf[MAX_EVENT_NAME_LEN];
-	char gbuf[MAX_EVENT_NAME_LEN];
-	enum probe_print_type ptype;
-	struct path path;
 	unsigned long offset, ref_ctr_offset;
+	char *gbuf __free(kfree) = NULL;
+	char *buf __free(kfree) = NULL;
+	enum probe_print_type ptype;
+	struct trace_uprobe *tu;
 	bool is_return = false;
+	struct path path;
 	int i, ret;
 
 	ref_ctr_offset = 0;
@@ -653,6 +655,10 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	/* setup a probe */
 	trace_probe_log_set_index(0);
 	if (event) {
+		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!gbuf)
+			goto fail_mem;
+
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
@@ -664,15 +670,16 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		char *ptr;
 
 		tail = kstrdup(kbasename(filename), GFP_KERNEL);
-		if (!tail) {
-			ret = -ENOMEM;
-			goto fail_address_parse;
-		}
+		if (!tail)
+			goto fail_mem;
 
 		ptr = strpbrk(tail, ".-_");
 		if (ptr)
 			*ptr = '\0';
 
+		buf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!buf)
+			goto fail_mem;
 		snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_0x%lx", 'p', tail, offset);
 		event = buf;
 		kfree(tail);
@@ -724,6 +731,9 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	trace_probe_log_clear();
 	return ret;
 
+fail_mem:
+	ret = -ENOMEM;
+
 fail_address_parse:
 	trace_probe_log_clear();
 	path_put(&path);

