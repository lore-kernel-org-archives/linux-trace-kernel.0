Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC722D8387;
	Fri, 18 Jul 2025 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838475; cv=none; b=PIQrlrqNADdQOMJEf9wTIT7WoSnk1WZ0bGHlD2DxTX0mD9osUOlxqAniZLr9nT3hLzvwC7H2apQAvyuZ5THlYUnVuv/FEJLpQmrJUp+G6ao1cNIZeGi6yxfxsnaYyEflkSSIaOQNTlzoXDiGsSDzXN2CywRhi4xCxSSrFcKab6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838475; c=relaxed/simple;
	bh=E2lm3aHfVHYQJcOBR7OBP3UW7aulka1N/K5QYP8yvDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nADgAqwhXDDYlppCm1EYduCAbpCkKR7/44nPZsTn89z/YMPQ/F5hLqxGN9yhUciuL4+gdxY6pTTPPyy82ab6QqcK7uulOVXnh20lCm9CknK8c4/TUPBkGZ66sNRdZcAXrP0RMQqKxvCVczfUEcTntJlWgvXOZxl/CXve6lmGgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr+jbLBZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr+jbLBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A445C4CEEB;
	Fri, 18 Jul 2025 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838475;
	bh=E2lm3aHfVHYQJcOBR7OBP3UW7aulka1N/K5QYP8yvDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xr+jbLBZhIRHDzUJi3m/Vt8b39qxBCbbTcWpAwiKboRfAVbVg//fKETig0wCRnzCL
	 9mYCxj45jIDICgtliairx7wijvyI2iGtZJYWzb+J3tyyVvYiBRCGkvMPvsfwL3cGS4
	 CAf8B9YsJP8+rex6xhmIRdJKWWfXQJdfTgKgBC0stzusmcjiKyfNFzOAy30K99ci00
	 9BXdkZtf+KIHdaB2suancU3FX6uqZFHXwXkkBPV+BoXj4WwRwExjgJML7WQIgdpTg6
	 mYd1AS/Hw4BOgs11RGkemX4bIKnEgWmNmqX6zKwZz9WcEag8tw1r+F6kRei1hEnd3s
	 XhRa6nPWrdz2w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/5] tracing: kprobe-event: Allocate string buffers from heap
Date: Fri, 18 Jul 2025 20:34:29 +0900
Message-ID: <175283846936.343578.3747359008449354291.stgit@devnote2>
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

Allocate temporary string buffers for parsing kprobe-events
from heap instead of stack.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 15d7a381a128..793af6000f16 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -861,20 +861,20 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_kprobe *tk __free(free_trace_kprobe) = NULL;
+	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
+	const char **new_argv __free(kfree) = NULL;
 	int i, len, new_argc = 0, ret = 0;
-	bool is_return = false;
 	char *symbol __free(kfree) = NULL;
-	char *tmp = NULL;
-	const char **new_argv __free(kfree) = NULL;
-	const char *event = NULL, *group = KPROBE_EVENT_SYSTEM;
+	char *ebuf __free(kfree) = NULL;
+	char *gbuf __free(kfree) = NULL;
+	char *abuf __free(kfree) = NULL;
+	char *dbuf __free(kfree) = NULL;
 	enum probe_print_type ptype;
+	bool is_return = false;
 	int maxactive = 0;
-	long offset = 0;
 	void *addr = NULL;
-	char buf[MAX_EVENT_NAME_LEN];
-	char gbuf[MAX_EVENT_NAME_LEN];
-	char abuf[MAX_BTF_ARGS_LEN];
-	char *dbuf __free(kfree) = NULL;
+	char *tmp = NULL;
+	long offset = 0;
 
 	switch (argv[0][0]) {
 	case 'r':
@@ -893,6 +893,8 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 		event++;
 
 	if (isdigit(argv[0][1])) {
+		char *buf __free(kfree) = NULL;
+
 		if (!is_return) {
 			trace_probe_log_err(1, BAD_MAXACT_TYPE);
 			return -EINVAL;
@@ -905,7 +907,7 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 			trace_probe_log_err(1, BAD_MAXACT);
 			return -EINVAL;
 		}
-		memcpy(buf, &argv[0][1], len);
+		buf = kmemdup(&argv[0][1], len + 1, GFP_KERNEL);
 		buf[len] = '\0';
 		ret = kstrtouint(buf, 0, &maxactive);
 		if (ret || !maxactive) {
@@ -973,6 +975,9 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 
 	trace_probe_log_set_index(0);
 	if (event) {
+		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!gbuf)
+			return -ENOMEM;
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
@@ -981,16 +986,22 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 
 	if (!event) {
 		/* Make a new event name */
+		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!ebuf)
+			return -ENOMEM;
 		if (symbol)
-			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
+			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
 				 is_return ? 'r' : 'p', symbol, offset);
 		else
-			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_0x%p",
+			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%c_0x%p",
 				 is_return ? 'r' : 'p', addr);
-		sanitize_event_name(buf);
-		event = buf;
+		sanitize_event_name(ebuf);
+		event = ebuf;
 	}
 
+	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
+	if (!abuf)
+		return -ENOMEM;
 	argc -= 2; argv += 2;
 	ctx->funcname = symbol;
 	new_argv = traceprobe_expand_meta_args(argc, argv, &new_argc,

