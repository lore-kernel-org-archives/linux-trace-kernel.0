Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDF1448EF;
	Fri,  5 Jul 2024 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163490; cv=none; b=rAy31Dhi8FLZCex0z2dGyofe3M0gR74vi6xZiG9/B16UHYwXw12c7xSuMmF3KrrHJ7ERh/ZSQBaDtAakAK9vGwTnYsZffmG8RnFw7sdEpvkXgbRNkeCoHEiWKm4pmGYTuJYcEsTAm7ba+Wg6VKblrPopvKSlR+CjSM6sbgDzqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163490; c=relaxed/simple;
	bh=7HuCT+66yaA77r/bURMz9JSlr+eJdbuAnDb6E+CJxOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Gg+Ja+F6E0JPWClK6ecRvcFV4WBxAelfuJp51EDwHWobWrPbIn7C823KHahr2gcIR9REWXDg/JqxIrhPTrNeaG97qGCL5aigfrUR7yKNbVSamiS279e/D4iE2PPVsNs4bVHGI/FFdwTWwd5K5SYfLPT5nCHlMoR+DNFj+SCkTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSibO4TD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSibO4TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFA9C116B1;
	Fri,  5 Jul 2024 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720163489;
	bh=7HuCT+66yaA77r/bURMz9JSlr+eJdbuAnDb6E+CJxOM=;
	h=From:To:Cc:Subject:Date:From;
	b=rSibO4TDXZ/TvAJ84hhSLERh5txetSM1aLGWK2c9rg0ugJ/vZTR0MqvoqR1WC+9lP
	 qQih28ZFTIl5OvZrOgg1tuJJ4lcVoPUprGxU6Zz/O/9WfOmFsi0h7g2v4Q5IU3gMXb
	 KgxrulubsSHOQ1z9cJJA8AXsk8NeUEYxXlg5P9kuUPXskQ/N+35VTu9RC2hHII53Y+
	 mdcxXkaSZv6RJtnNSUrpwy86Tx81rRPA7Cq4wWl9Olf28Q9cfOPWr0NAJrI/Bcsuds
	 cxu+T/wcpGggpKZ5F5ArQ/Vad80zJvlHmeSXSILdIYv8P0445vA2eNZh6cKYd0mc5o
	 8iCEyapmrL7Ww==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH for-next v3] tracing/kprobes: Add symbol counting check when module loads
Date: Fri,  5 Jul 2024 16:11:25 +0900
Message-Id: <172016348553.99543.2834679315611882137.stgit@devnote2>
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

Currently, kprobe event checks whether the target symbol name is unique
or not, so that it does not put a probe on an unexpected place. But this
skips the check if the target is on a module because the module may not
be loaded.

To fix this issue, this patch checks the number of probe target symbols
in a target module when the module is loaded. If the probe is not on the
unique name symbols in the module, it will be rejected at that point.

Note that the symbol which has a unique name in the target module,
it will be accepted even if there are same-name symbols in the
kernel or other modules,

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Update the patch description.
  - Update for latest probe/for-next
 Updated from last October post, which was dropped by test failure:
    https://lore.kernel.org/linux-trace-kernel/169854904604.132316.12500381416261460174.stgit@devnote2/
 Changes in v2:
  - Fix to skip checking uniqueness if the target module is not loaded.
  - Fix register_module_trace_kprobe() to pass correct symbol name.
  - Fix to call __register_trace_kprobe() from module callback.
---
 kernel/trace/trace_kprobe.c |  125 ++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 44 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7fd0f8576e4c..4cee3442bcce 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -678,6 +678,21 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 }
 
 #ifdef CONFIG_MODULES
+static int validate_module_probe_symbol(const char *modname, const char *symbol);
+
+static int register_module_trace_kprobe(struct module *mod, struct trace_kprobe *tk)
+{
+	const char *p;
+	int ret = 0;
+
+	p = strchr(trace_kprobe_symbol(tk), ':');
+	if (p)
+		ret = validate_module_probe_symbol(module_name(mod), p + 1);
+	if (!ret)
+		ret = __register_trace_kprobe(tk);
+	return ret;
+}
+
 /* Module notifier call back, checking event on the module */
 static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
@@ -696,7 +711,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 		if (trace_kprobe_within_module(tk, mod)) {
 			/* Don't need to check busy - this should have gone. */
 			__unregister_trace_kprobe(tk);
-			ret = __register_trace_kprobe(tk);
+			ret = register_module_trace_kprobe(mod, tk);
 			if (ret)
 				pr_warn("Failed to re-register probe %s on %s: %d\n",
 					trace_probe_name(&tk->tp),
@@ -747,17 +762,68 @@ static int count_mod_symbols(void *data, const char *name, unsigned long unused)
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
+	struct module *mod = NULL;
+	char *modname = NULL, *p;
+	int ret = 0;
+
+	p = strchr(symbol, ':');
+	if (p) {
+		modname = symbol;
+		symbol = p + 1;
+		*p = '\0';
+		/* Return 0 (defer) if the module does not exist yet. */
+		rcu_read_lock_sched();
+		mod = find_module(modname);
+		if (mod && !try_module_get(mod))
+			mod = NULL;
+		rcu_read_unlock_sched();
+		if (!mod)
+			goto out;
+	}
+
+	ret = validate_module_probe_symbol(modname, symbol);
+out:
+	if (p)
+		*p = ':';
+	if (mod)
+		module_put(mod);
+	return ret;
+}
+
 static int trace_kprobe_entry_handler(struct kretprobe_instance *ri,
 				      struct pt_regs *regs);
 
@@ -881,6 +947,14 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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
@@ -893,31 +967,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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
@@ -1835,21 +1884,9 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
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

