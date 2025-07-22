Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711FD286D5D;
	Tue, 22 Jul 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221740; cv=none; b=FKXFITYplpJouvkLROXtIrsEQ4rk6Xl2y9qcd86+iBVzKZH0gA8SbXawPTXKB8gU6lbTI1h0V3QdU27RiuUq/8k1Ee1hzlDIl7KzmwjZlSUMuyPXqqYXf3LNSnFUW/o6XPJ5k6hMFdI8Xyf7WFJQuxdsctazb1jUd0E/NPgvFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221740; c=relaxed/simple;
	bh=s4acfsBSSQb0a10qdIvIDWcvzwbhtVpvJV4UIF0tfbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrgT0Fu4olq0h3XoW8v1AC0afhjyJY+LPqkTES9z9d25hPDF5pZjqOcxS/PsMCy7loQOYifWs8K3CH8FHdboO3clowRRka5PWkJSyICUaueJyR3QM6/C/AicI7hGucDv6BYciNyMQPy3K/+h/af9ABfzYO1b6c33lADnw4lSPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNs16k8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNs16k8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BFCC4CEEB;
	Tue, 22 Jul 2025 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221740;
	bh=s4acfsBSSQb0a10qdIvIDWcvzwbhtVpvJV4UIF0tfbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNs16k8nQ2LVCOLnxHJEoBKhKPEJkctR3wAyQRPtIxHKiUNvcbAtch7i4FkDeBSLJ
	 QF2gUABwDXhtXNetMafw3GG+hhtcVnVQm+De2LlVkqrzSX8n10aaktQxlze2ASDaXd
	 Fl0G1ptVcigOJRrx5VmRWwKC0thIQzSGflt3p9rn3EhCqUQ8UNrfqFMGX3IppO4Eog
	 5Gvn2Ol0g8VmlxYqnvleJA5zHCdvkUV+6XG6mLVvRDXEs4qo5AupfMGYQE8SMBqJG/
	 IiFvzVWSr24AZU1gURZ3qSqW0t6dXJAwtuP5ZeQz9ZMlAgSgijNjv37sdC0HK/mgRt
	 rWHFjoopsdUeQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] tracing: eprobe-event: Allocate string buffers from heap
Date: Wed, 23 Jul 2025 07:02:16 +0900
Message-ID: <175322173570.44400.3225843477955658372.stgit@devnote2>
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

Allocate temporary string buffers for parsing eprobe-events
from heap instead of stack.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes in v3:
  - Split #include sorting.
 Changes in v2:
  - Use new label for returning -ENOMEM.
  - Sort #include alphabetically.
---
 kernel/trace/trace_eprobe.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 7ba3a18be4c5..f16a0ab0b001 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2021, VMware Inc, Tzvetomir Stoyanov tz.stoyanov@gmail.com>
  *
  */
+#include <linux/cleanup.h>
 #include <linux/ftrace.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
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

