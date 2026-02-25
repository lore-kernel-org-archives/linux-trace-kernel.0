Received: from mail.189.cn (189sx01-ptr.21cn.com [183.56.237.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51632DC787;
	Wed, 25 Feb 2026 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.56.237.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771998610; cv=none; b=ZAKgISApZQLMKm3U4kM6mm4ETV1rVyZdFD/KGVl7pnqi05HdD60joAQQAIIspK3VC5MXLQ153MHWLfIZD/br7W23hhAh6Jn5dUhh1igximdOTbXYCHO3tMUGxNUDkOdsmWqQDTtnxgJWFgrkxgXzHteR2RY8ljlZ5eKIGkiT4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771998610; c=relaxed/simple;
	bh=o+P1kY66CBYLmRYKQxbNW8s1rlNqPYF56mvw7fY1H+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4oMPgsfIKesVoqX5lJrJes0T80tXE0rEHtd10T7o0pS9acLbOs22rSrRXzB4V8P74S1v5q8HLJt+xdh2bTyyg4urLD25eGsWqFOG9h/rQtECxXovw9G8JRXObrvz6r1muuZapei+hKzhJkOvQyXskVO11LoRGcLh+kaDEiwHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.56.237.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.676214326
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-60.24.210.5 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 92A7F400317;
	Wed, 25 Feb 2026 13:46:40 +0800 (CST)
Received: from  ([60.24.210.5])
	by gateway-153622-dep-76cc7bc9cd-r45x9 with ESMTP id 5b315b3428bd494eb786883da9b9de49 for mcgrof@kernel.org;
	Wed, 25 Feb 2026 13:46:41 CST
X-Transaction-ID: 5b315b3428bd494eb786883da9b9de49
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 60.24.210.5
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From: chensong_2000@189.cn
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Song Chen <chensong_2000@189.cn>
Subject: [PATCH] kernel/trace/ftrace: introduce ftrace module notifier
Date: Wed, 25 Feb 2026 13:46:39 +0800
Message-ID: <20260225054639.21637-1-chensong_2000@189.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Chen <chensong_2000@189.cn>

Like kprobe, fprobe and btf, this patch attempts to introduce
a notifier_block for ftrace to decouple its initialization from
load_module.

Below is the table of ftrace fucntions calls in different
module state:

	MODULE_STATE_UNFORMED	ftrace_module_init
	MODULE_STATE_COMING	ftrace_module_enable
	MODULE_STATE_LIVE	ftrace_free_mem
	MODULE_STATE_GOING	ftrace_release_mod

Unlike others, ftrace module notifier must take care of state
MODULE_STATE_UNFORMED to ensure calling ftrace_module_init
before complete_formation which changes module's text property.

That pretty much remains same logic with its original design,
the only thing that changes is blocking_notifier_call_chain
(MODULE_STATE_GOING) has to be moved from coming_cleanup to
ddebug_cleanup in function load_module to ensure
ftrace_release_mod is invoked in case complete_formation fails.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/module/main.c  | 14 ++++----------
 kernel/trace/ftrace.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 710ee30b3bea..5dc0a980e9bd 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -45,7 +45,6 @@
 #include <linux/license.h>
 #include <asm/sections.h>
 #include <linux/tracepoint.h>
-#include <linux/ftrace.h>
 #include <linux/livepatch.h>
 #include <linux/async.h>
 #include <linux/percpu.h>
@@ -836,7 +835,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
-	ftrace_release_mod(mod);
 
 	async_synchronize_full();
 
@@ -3067,8 +3065,6 @@ static noinline int do_init_module(struct module *mod)
 	if (!mod->async_probe_requested)
 		async_synchronize_full();
 
-	ftrace_free_mem(mod, mod->mem[MOD_INIT_TEXT].base,
-			mod->mem[MOD_INIT_TEXT].base + mod->mem[MOD_INIT_TEXT].size);
 	mutex_lock(&module_mutex);
 	/* Drop initial reference. */
 	module_put(mod);
@@ -3131,7 +3127,6 @@ static noinline int do_init_module(struct module *mod)
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
-	ftrace_release_mod(mod);
 	free_module(mod);
 	wake_up_all(&module_wq);
 
@@ -3278,7 +3273,6 @@ static int prepare_coming_module(struct module *mod)
 {
 	int err;
 
-	ftrace_module_enable(mod);
 	err = klp_module_coming(mod);
 	if (err)
 		return err;
@@ -3461,7 +3455,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	init_build_id(mod, info);
 
 	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
-	ftrace_module_init(mod);
+	blocking_notifier_call_chain(&module_notify_list,
+				MODULE_STATE_UNFORMED, mod);
 
 	/* Finally it's fully formed, ready to start executing. */
 	err = complete_formation(mod, info);
@@ -3513,8 +3508,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
  coming_cleanup:
 	mod->state = MODULE_STATE_GOING;
 	destroy_params(mod->kp, mod->num_kp);
-	blocking_notifier_call_chain(&module_notify_list,
-				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
  bug_cleanup:
 	mod->state = MODULE_STATE_GOING;
@@ -3524,7 +3517,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mutex_unlock(&module_mutex);
 
  ddebug_cleanup:
-	ftrace_release_mod(mod);
+	blocking_notifier_call_chain(&module_notify_list,
+				     MODULE_STATE_GOING, mod);
 	synchronize_rcu();
 	kfree(mod->args);
  free_arch_cleanup:
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3ec2033c0774..47c74d4a2425 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5223,6 +5223,43 @@ static int __init ftrace_mod_cmd_init(void)
 }
 core_initcall(ftrace_mod_cmd_init);
 
+static int ftrace_module_callback(struct notifier_block *nb, unsigned long op,
+			void *module)
+{
+	struct module *mod = module;
+
+	switch (op) {
+	case MODULE_STATE_UNFORMED:
+		ftrace_module_init(mod);
+		break;
+	case MODULE_STATE_COMING:
+		ftrace_module_enable(mod);
+		break;
+	case MODULE_STATE_LIVE:
+		ftrace_free_mem(mod, mod->mem[MOD_INIT_TEXT].base,
+				mod->mem[MOD_INIT_TEXT].base + mod->mem[MOD_INIT_TEXT].size);
+		break;
+	case MODULE_STATE_GOING:
+		ftrace_release_mod(mod);
+		break;
+	default:
+		break;
+	}
+
+	return notifier_from_errno(0);
+}
+
+static struct notifier_block ftrace_module_nb = {
+	.notifier_call = ftrace_module_callback,
+	.priority = 0
+};
+
+static int __init ftrace_register_module_notifier(void)
+{
+	return register_module_notifier(&ftrace_module_nb);
+}
+core_initcall(ftrace_register_module_notifier);
+
 static void function_trace_probe_call(unsigned long ip, unsigned long parent_ip,
 				      struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-- 
2.43.0

