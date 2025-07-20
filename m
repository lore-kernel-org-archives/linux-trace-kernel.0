Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7191ADC90;
	Sun, 20 Jul 2025 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992542; cv=none; b=l3x/PV8CME7DVokuhcqim8V7mEPifCWJYGGMeR2vmGklMJcCkNuGHz/qOTRxDt0/BnvQA08LWoqK3egLHyxebF/zsy5WZATLM8q+FhQn7nNS7CVR6K0B7ztIUS2K2WAK3lMqkWWwGdfpCbl+1HRW6V6OJHz2oM/shvkS4U39ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992542; c=relaxed/simple;
	bh=Y6eWHhRzvLS7UKVCubfUp6ykDh2zGXNc/JAUTrUqM5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6cgpDshUH7iRldSez5wiApI3l8CcR0Ru1Kp3cYRFhOm/63zb1C5B2AYq4Cp5JgZjOnJ/26yT41mMPgjtZ42aM47fXHBCGBRZJQo1HwI41WEhIXNBDwjeswK//a5ezEcpQ3UWdUoOfuUIkV1zSW9K65AD6oa93VvkVZ37hQn2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcJMwfzn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcJMwfzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD64C4CEE7;
	Sun, 20 Jul 2025 06:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752992540;
	bh=Y6eWHhRzvLS7UKVCubfUp6ykDh2zGXNc/JAUTrUqM5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcJMwfzn1M6VkNvsfzlJF5gkm8hGFVoCqaZFhPInsThhdF20ewdhWRnbHwuvN16K/
	 yn5OgV4ZzokICOAS2PLAkaxE9cv/g0h9UyiV3sI7yI8jQyGMQFh8ECMhV8M6yMPZeE
	 SRrcyc7y+njKzgkZQKsjpii81HM5fC4j4D39axCfW1oL0CMLueZHKoCOuqY/GFg8KE
	 VJgjhTfJJMgttzLPtmcI/xy2vmzXVWu9siiqM0N5iPXuRUtwMwJCsl6BD+gbcB5Svj
	 uo0tDWpIG4wobzm8YaLZN1HIKcDocjZubkvb9ac8LGCQ7BX1KYSg3bWoxPXxvGmfUy
	 gF/+VbXGUR12A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] tracing: eprobe-event: Allocate string buffers from heap
Date: Sun, 20 Jul 2025 15:22:16 +0900
Message-ID: <175299253643.418723.5944624119162360742.stgit@devnote2>
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

Allocate temporary string buffers for parsing eprobe-events
from heap instead of stack.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Use new label for returning -ENOMEM.
  - Sort #include alphabetically.
---
 kernel/trace/trace_eprobe.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 1e18a8619b40..f16a0ab0b001 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -9,14 +9,15 @@
  * Copyright (C) 2021, VMware Inc, Tzvetomir Stoyanov tz.stoyanov@gmail.com>
  *
  */
+#include <linux/cleanup.h>
+#include <linux/ftrace.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/ftrace.h>
 
 #include "trace_dynevent.h"
 #include "trace_probe.h"
-#include "trace_probe_tmpl.h"
 #include "trace_probe_kernel.h"
+#include "trace_probe_tmpl.h"
 
 #define EPROBE_EVENT_SYSTEM "eprobes"
 
@@ -871,10 +872,10 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
 	const char *sys_event = NULL, *sys_name = NULL;
 	struct trace_event_call *event_call;
+	char *buf1 __free(kfree) = NULL;
+	char *buf2 __free(kfree) = NULL;
+	char *gbuf __free(kfree) = NULL;
 	struct trace_eprobe *ep = NULL;
-	char buf1[MAX_EVENT_NAME_LEN];
-	char buf2[MAX_EVENT_NAME_LEN];
-	char gbuf[MAX_EVENT_NAME_LEN];
 	int ret = 0, filter_idx = 0;
 	int i, filter_cnt;
 
@@ -885,6 +886,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	event = strchr(&argv[0][1], ':');
 	if (event) {
+		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!gbuf)
+			goto mem_error;
 		event++;
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
@@ -894,6 +898,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	trace_probe_log_set_index(1);
 	sys_event = argv[1];
+
+	buf2 = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+	if (!buf2)
+		goto mem_error;
+
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
 	if (ret || !sys_event || !sys_name) {
 		trace_probe_log_err(0, NO_EVENT_INFO);
@@ -901,7 +910,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	}
 
 	if (!event) {
-		strscpy(buf1, sys_event, MAX_EVENT_NAME_LEN);
+		buf1 = kstrdup(sys_event, GFP_KERNEL);
+		if (!buf1)
+			goto mem_error;
 		event = buf1;
 	}
 
@@ -974,6 +985,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	trace_probe_log_clear();
 	return ret;
 
+mem_error:
+	ret = -ENOMEM;
+	goto error;
 parse_error:
 	ret = -EINVAL;
 error:

