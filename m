Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE74282F5;
	Tue, 22 Jul 2025 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221731; cv=none; b=rNLLenXZRb4gY+ZuSDmWeZw6Ai0U+OrFM5p2rA2F93YPlSvC3iZAeZXfdBuSeQW1ku6F5QogeIb6QqAL9gWZXXyNTGRwBu0u/2oGkcMvtzdR+cqNeRY8WEZre8vN0/2mERt8T9kEtE83CWsAQnd0cPA/fJcMAqZ9oFyp+h4ywjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221731; c=relaxed/simple;
	bh=Wq0i8GteHDgwXzQXT1t9807QiLhKfB+vLNzYG5yqT7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wzf7jsnbNDgJEJHQZCOoCOnphR8jn8tOO6SV9s9QLNFjuxSrKm3jJClYA5JVGdCiMS/O3XGFl45JQROF/iwghM7tXEZwatnquiXDVKMzItcvHSkObNkLHNINoQK8/UEjbwmPyBvjz7Hm5RuB7Xvpzr4pAxPcA+2H+wphk6uYcTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpzG7ewt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpzG7ewt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D313FC4CEEB;
	Tue, 22 Jul 2025 22:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221730;
	bh=Wq0i8GteHDgwXzQXT1t9807QiLhKfB+vLNzYG5yqT7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FpzG7ewtH/N4G2Aq4spItGnHdTeQgcH3IooB4RzL3oeQgyeWbOGWtJhcmsjqGMS5P
	 KQ47BYcbMwbj93EEDlZ/JMMFQqocdc+N/Vf6LFNRRhrzlIFEZNBMmqdex3eVAk3x6B
	 XhKYlYphRJY7E7Ik6j/YeliEIbVqxWrISfB/ETEGshUxm64Tx97aqtLtK3a/k4XJZ4
	 0mo8RYSuJcwGNgjhiKEUIchusrPzCn2766Ky39UsY6ZYVFpsgdfR435WgcrfrLbA2E
	 yEtd5sL75eQHS/VMp8JzRNfpANe/tRyGmdxOEMji7PYK3k9AnOZquT+XSvunt/J9Cp
	 /5lHZ3J7NQZ3A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] tracing: kprobe-event: Allocate string buffers from heap
Date: Wed, 23 Jul 2025 07:02:06 +0900
Message-ID: <175322172565.44400.4742329195614143339.stgit@devnote2>
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

Allocate temporary string buffers for parsing kprobe-events
from heap instead of stack.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c |   39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d14b33e205f7..ccae62d4fb91 100644
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

