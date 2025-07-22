Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F6284B4C;
	Tue, 22 Jul 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221750; cv=none; b=qZkXeN77RyQz03ykOukiBOxiVzJrwwKDv8EoFn3IEirk68dTyGTICOt6UEZQFifJKAXm3Zj0GXHLhh/gpMkietZbStfCeXU/RPbkGHISLbeMubcgfs4/fkkEtq0//MzDNvtzPT4HlfLRJBxXm983pITf2NgSZLPGuDBFDRYAQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221750; c=relaxed/simple;
	bh=DxO1YM1X+7JaNQ9U0X8Q5IH0b0RsP0wermUze7T+tCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlG+kCOu7LIWEg3QwJfu+gNo72IDuz0+OcMUqNVf1ojry+u9OU8CG6SaLdbud5V2CnU7Eq8WooyvHTYFqTRs7gm0XM/PqywQ71jEiBb1I0dwYJsrtj8BRSqQWuwyWGXUVvq5sSMK89ZUua6m5JSNb3WrbLqps5eoWGANVGaUuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXRxhk4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXRxhk4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804E1C4CEEB;
	Tue, 22 Jul 2025 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221749;
	bh=DxO1YM1X+7JaNQ9U0X8Q5IH0b0RsP0wermUze7T+tCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXRxhk4VBvRUpC2hDNbswi2Eom3QA+VaejVsk/rvOOZcAFerFFwV1RvA2lv9YwIN2
	 4+oa4LW4IQYuyBW4yB9NVIkAXtOY7nD1SkW5wvcJnv7mHT/qpAAAMq2dbIaOJrE0V1
	 8BuhgoBu3ic1HrUHqQrhBJA7Tnfr9PqyoNcqnGjuVF4lwLDMDbGTK2wtAINwzgTHR/
	 x+Vw9AyMFC8DyjcuZbP8LgHtuAvwobyaXtYlnEugYW6v0yxgUZHTye7H5pOnDgDJBy
	 syZ+3/pMuHuIjBgM22IuGPHrpuOyPw8baxNW+xPCSawH5zoiLfivnZXqnBJC1dygu1
	 LfAsiNe9ecvHg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] tracing: uprobe-event: Allocate string buffers from heap
Date: Wed, 23 Jul 2025 07:02:25 +0900
Message-ID: <175322174554.44400.67987510323737083.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175322168606.44400.9155291012158349647.stgit@devnote2>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
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
 Changes in v3:
  - Split #include sorting.
 Changes in v2:
  - Sort #include alphabetically.
  - Add fail_mem label for handling ENOMEM error.
---
 kernel/trace/trace_uprobe.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 872dce092e46..8b0bcc0d8f41 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)	"trace_uprobe: " fmt
 
 #include <linux/bpf-cgroup.h>
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
 #include <linux/filter.h>
 #include <linux/module.h>
@@ -19,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <linux/uprobes.h>
 
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

