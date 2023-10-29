Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0080B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Oct 2023 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfviiagA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F86DC433C8;
	Sun, 29 Oct 2023 03:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698549051;
	bh=9t8XSEZa0yobHjz6LzUAd1uwRa75aeszKCTXOZzVNt0=;
	h=From:To:Cc:Subject:Date:From;
	b=GfviiagAPaVvYNtgf+S9S/2I5n7P92WfJI53ixQW6rJllJzgKdpphgzpJK9PV6dqA
	 pZA/yEehcL+Ee2kJ0EATFjwfBxNIVR3POKfsxHl/wtm4k05/iUsry2NJcMH+D1Vwh8
	 Mihlf8udmWchtragYxqeG0kCoTYSrVVmRB269bAnydzOMXV0FF8KqEx8wzA3UuwPgB
	 cRwf50aFgkRUsR0gRfeqTK3jAI2U3zor1HtNZDvoWXIYOJR1CL5npJkjZRZPQMif5I
	 6cSHUhp7G+4rqyRlz8KyfO16GPmppznSvd+dbhU57CxGS13wn40VWOx4vDVLuCv0Yz
	 q2MTEgtVMKxXg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH for-next] tracing/kprobes: Add symbol counting check when module loads
Date: Sun, 29 Oct 2023 12:10:46 +0900
Message-Id: <169854904604.132316.12500381416261460174.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Check the number of probe target symbols in the target module when
the module is loaded. If the probe is not on the unique name symbols
in the module, it will be rejected at that point.

Note that the symbol which has a unique name in the target module,
it will be accepted even if there are same-name symbols in the
kernel or other modules,

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |  112 ++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 44 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e834f149695b..90cf2219adb4 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -670,6 +670,21 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	return ret;
 }
 
+static int validate_module_probe_symbol(const char *modname, const char *symbol);
+
+static int register_module_trace_kprobe(struct module *mod, struct trace_kprobe *tk)
+{
+	const char *p;
+	int ret = 0;
+
+	p = strchr(trace_kprobe_symbol(tk), ':');
+	if (p)
+		ret = validate_module_probe_symbol(module_name(mod), p++);
+	if (!ret)
+		ret = register_trace_kprobe(tk);
+	return ret;
+}
+
 /* Module notifier call back, checking event on the module */
 static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
@@ -688,7 +703,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 		if (trace_kprobe_within_module(tk, mod)) {
 			/* Don't need to check busy - this should have gone. */
 			__unregister_trace_kprobe(tk);
-			ret = __register_trace_kprobe(tk);
+			ret = register_module_trace_kprobe(mod, tk);
 			if (ret)
 				pr_warn("Failed to re-register probe %s on %s: %d\n",
 					trace_probe_name(&tk->tp),
@@ -729,17 +744,55 @@ static int count_mod_symbols(void *data, const char *name, unsigned long unused)
 	return 0;
 }
 
-static unsigned int number_of_same_symbols(char *func_name)
+static unsigned int number_of_same_symbols(const char *mod, const char *func_name)
 {
 	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
 
-	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
+	if (!mod)
+		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
 
-	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
+	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
 
 	return ctx.count;
 }
 
+static int validate_module_probe_symbol(const char *modname, const char *symbol)
+{
+	unsigned int count = number_of_same_symbols(modname, symbol);
+
+	if (count > 1) {
+		/*
+		 * Users should use ADDR to remove the ambiguity of
+		 * using KSYM only.
+		 */
+		return -EADDRNOTAVAIL;
+	} else if (count == 0) {
+		/*
+		 * We can return ENOENT earlier than when register the
+		 * kprobe.
+		 */
+		return -ENOENT;
+	}
+	return 0;
+}
+
+static int validate_probe_symbol(char *symbol)
+{
+	char *mod = NULL, *p;
+	int ret;
+
+	p = strchr(symbol, ':');
+	if (p) {
+		mod = symbol;
+		symbol = p + 1;
+		*p = '\0';
+	}
+	ret = validate_module_probe_symbol(mod, symbol);
+	if (p)
+		*p = ':';
+	return ret;
+}
+
 static int __trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -859,6 +912,14 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 			goto parse_error;
 		}
+		ret = validate_probe_symbol(symbol);
+		if (ret) {
+			if (ret == -EADDRNOTAVAIL)
+				trace_probe_log_err(0, NON_UNIQ_SYMBOL);
+			else
+				trace_probe_log_err(0, BAD_PROBE_ADDR);
+			goto parse_error;
+		}
 		if (is_return)
 			ctx.flags |= TPARG_FL_RETURN;
 		ret = kprobe_on_func_entry(NULL, symbol, offset);
@@ -871,31 +932,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 	}
 
-	if (symbol && !strchr(symbol, ':')) {
-		unsigned int count;
-
-		count = number_of_same_symbols(symbol);
-		if (count > 1) {
-			/*
-			 * Users should use ADDR to remove the ambiguity of
-			 * using KSYM only.
-			 */
-			trace_probe_log_err(0, NON_UNIQ_SYMBOL);
-			ret = -EADDRNOTAVAIL;
-
-			goto error;
-		} else if (count == 0) {
-			/*
-			 * We can return ENOENT earlier than when register the
-			 * kprobe.
-			 */
-			trace_probe_log_err(0, BAD_PROBE_ADDR);
-			ret = -ENOENT;
-
-			goto error;
-		}
-	}
-
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -1767,21 +1803,9 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	char *event;
 
 	if (func) {
-		unsigned int count;
-
-		count = number_of_same_symbols(func);
-		if (count > 1)
-			/*
-			 * Users should use addr to remove the ambiguity of
-			 * using func only.
-			 */
-			return ERR_PTR(-EADDRNOTAVAIL);
-		else if (count == 0)
-			/*
-			 * We can return ENOENT earlier than when register the
-			 * kprobe.
-			 */
-			return ERR_PTR(-ENOENT);
+		ret = validate_probe_symbol(func);
+		if (ret)
+			return ERR_PTR(ret);
 	}
 
 	/*

