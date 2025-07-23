Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B91991B6;
	Wed, 23 Jul 2025 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234291; cv=none; b=o0/26G6FUOFCFMnCKTgz3Vu6imQRGmn86Oh2BC49L4yE7bkFrbuVw9l2bf4lUaTQQ6aog0aWkohjrT+68+0ZG/gBzSyW76v8g0srRB/NRbRcNVWUAPRPjMdC8Z76lHekr6FVsEoILoQfthVDujd8XE4VJTsOh52UiEyrt1Ssda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234291; c=relaxed/simple;
	bh=s4acfsBSSQb0a10qdIvIDWcvzwbhtVpvJV4UIF0tfbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSrrB/CCw0/ZT6jA82v028fffAfj8DHcpbtVcrnM3tGmA8W28H9NKDq+inB7Z/8MrJQiA+OpLVDonO79JU76k1CNrsl9T3jpzFEweQZMfC/bZ1TYmGYoRvCFqrmzFmhxrz6EA9qUUiGo00xhBhVsUbkSpGe3vxM/YxiPvGvHPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRD/ymKb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRD/ymKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2367CC4CEEB;
	Wed, 23 Jul 2025 01:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234290;
	bh=s4acfsBSSQb0a10qdIvIDWcvzwbhtVpvJV4UIF0tfbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRD/ymKbOirPj+42Q7NWdxZWg3BdjaEdAuW9gKoaqC4WZGCv1bl8AnJuGLrL0UUs1
	 hZX0cRuztZKMQCaOU9uYkJYTHY109FRoFORRX+mugJOzBDmCT1lw7AyF+G1WTWhm1j
	 a698eL2GF6u2BukfDiEpjIq17R8GjCCC9zEivWQYG8PKt8dymwovqex+AbDLAT7NlW
	 dpbVD+Znkui7yyBi8vd81Ox9+r/YZ0Z6V0lzFll6FTGaUEjgmMZXq5bc+E0utD2cNo
	 uUzekRvwmS7AQU2m+TPWbraYprTHvETWb24pu+6fPqtTFt7IC/zajKIGf/+mq9V1yo
	 4khFxQ2oa+eGA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] tracing: eprobe-event: Allocate string buffers from heap
Date: Wed, 23 Jul 2025 10:31:26 +0900
Message-ID: <175323428599.57270.988038042425748956.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175323423662.57270.14650807176845939538.stgit@devnote2>
References: <175323423662.57270.14650807176845939538.stgit@devnote2>
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

