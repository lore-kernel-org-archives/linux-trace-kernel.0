Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF492D9498;
	Fri, 18 Jul 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838486; cv=none; b=T2ZydgKyfEsfHtTHCw7ULE5npvDBx8ow24velizykJ1A7X9d9XJYczpKEJuiZyezWhnfQb1IgWdMuBuSpsg3UPWO5pYfsbtXNxaopHnB63PtfDwLvVCa1kZhlG1qDcNSUw5sGGzkmR6uz5LR8Xmns6Tmoixf/0GfQ6StxL0zCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838486; c=relaxed/simple;
	bh=Lzo7hIsuSu19X6bNrAGPaKlHyr6A69CrRZrO8+MMXHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLCkSulhqn28J+q0z91PILRvJiwfgUXZOUsn4vHvA3xXne4cV7kL4G+2OJ0q99JdJs3FCzN5j+/VFWFHafu9Pe9Go3YKHwTk2ZMpVgcQ03amUgJAxrPbx4KoSbb8U2+ii81PmaYbzdlADx2n+N/TWOtzAHwQd+e2sCiN0j2v+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPFHZRAl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPFHZRAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363DEC4CEEB;
	Fri, 18 Jul 2025 11:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838485;
	bh=Lzo7hIsuSu19X6bNrAGPaKlHyr6A69CrRZrO8+MMXHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPFHZRAlotkz8dgLtt3vUreQNWVCwAq1o8cfMggsbp5ccF2d3Ez6h1yj8GzuXdMph
	 DNFFzCyI/1O/7C0Fyk3UZ7Yo3phzVmkHZBu4LqMtPmbDx0ijC2mo65QBMFHNCUO9x7
	 jYXrCO78kk5vPDasboEd+WKv4LwY9AFp+K7Vg59Gc0EMtp+7F5MZeTAc275CiqVSt0
	 Gemv7+bkJd3sS9VT/VMMSscj3dzEO5mzfcVeCvFRl3SKX6EQX5FNkRGZvWCa8/0kzu
	 2kTfkJn2lDv4iiWTJhkPO9qr692PZfpr3XQZg0pfTy2JR2tuqtkuCLTcoy5s2QPkip
	 Dm4wO6asLOHCw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/5] tracing: eprobe-event: Allocate string buffers from heap
Date: Fri, 18 Jul 2025 20:34:40 +0900
Message-ID: <175283848063.343578.12113784863348416166.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175283843771.343578.8524137568048302760.stgit@devnote2>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
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
 kernel/trace/trace_eprobe.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 1e18a8619b40..75d8208cd859 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2021, VMware Inc, Tzvetomir Stoyanov tz.stoyanov@gmail.com>
  *
  */
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
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
 
@@ -885,6 +886,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	event = strchr(&argv[0][1], ':');
 	if (event) {
+		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!gbuf) {
+			ret = -ENOMEM;
+			goto parse_error;
+		}
 		event++;
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
@@ -894,6 +900,12 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	trace_probe_log_set_index(1);
 	sys_event = argv[1];
+
+	buf2 = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+	if (!buf2) {
+		ret = -ENOMEM;
+		goto parse_error;
+	}
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
 	if (ret || !sys_event || !sys_name) {
 		trace_probe_log_err(0, NO_EVENT_INFO);
@@ -901,7 +913,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	}
 
 	if (!event) {
-		strscpy(buf1, sys_event, MAX_EVENT_NAME_LEN);
+		buf1 = kstrdup(sys_event, GFP_KERNEL);
+		if (!buf1) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		event = buf1;
 	}
 

