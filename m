Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020249D5BB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742999; cv=none; b=OLpmzbCw0OMYhBXFURtjeECuJ/fLsejfir8M/IgLa5aphY83bzc9oakcbw1oxz/eQgiVPM1B8rNH5H0WnuS+xnle4iw352Td3o1WyYlZ6/+6dx9Bdcp5X9yAtHLWTHWxYb1PhNG40QfnjN4gzn2hqwIU4Qip/Nq/FezTjaZB7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742999; c=relaxed/simple;
	bh=WxuURWfyPfVrbwoJYzsme+dJrO0g2fOexfelnDzg3io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZCO716z7AIyS+j6jX1rUCTytX1bzAQHm7x1/2rzo3EdD50KYeYhsowzjh2zOCLTHKhZ+kOzfZudj6k7RonCurq/epZ5mD4BmDvlEsMWCwosfsAXdat/0Lvt4bPvzOi4LWAbR5JyPg3G8sn87EsJzH+yqX4XOjuryn2OtlnluBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=faIyM6d6; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="faIyM6d6"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530e28a62abso11097411cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789742992; x=1790347792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjEABplA81VfGcXS6Z1Q3Y7Xt5Unb50ofxErtTl6HPY=;
        b=faIyM6d6lHdi2mRJmhSPzHxM+FXiWIlOhDJq5o9Z62ITxfUwGTeCXGUj6SE7DLNJUQ
         5Lb+LG7GOby7lBqiZwXaNFA+Qx7agMJFGHY65RBJir/HKN+M9KRLPT+iuTUXNsL30kgX
         h6OvGU036XxbZp6YqvN2ti2/RX3Ti1T+FBZlpfVGpzbhUjJdErnsE3Py2Q3rOxt/ckNG
         D01yMf8s85YvQl1aM5sTE6SLpiEovGxmcH6JSECvcg7/CL2m2hQJWop3TlaTMRG3Z65x
         UY3kXN3gIy7x66vwDivlF84Av9tx5bwvGStrXywUlZh8l5iyxz0Mt9fztlIjzWIN6HYj
         sboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742992; x=1790347792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjEABplA81VfGcXS6Z1Q3Y7Xt5Unb50ofxErtTl6HPY=;
        b=FRQZ0o9zOFunUbAhuI7ANFcD9njTPCE2sZcJ5UF96sx/1jDuUifGM9U57yWj1ppGBy
         yXnpe0PX/7x1JM+DczJxYKmrma1+c/Ix1sVHpFob9opyk4GkiwQ7uGXudvJML+AYxzdM
         XqMi7+S54ud4Hj1vyOcGsAYyJ6g9Ar0HYaLdS3Wm7N+tKR2qRj+zMEBoC3Ccvdx3ffLK
         /C7ZgrcRr8ncovakxyZJexPntULVQCAIrTbf69gkJ6LN76ji4JOt7A3si+CUgHQdXcHm
         +DKiEFMYo5vsb35FM9NvDXQ4CBdwcr9rgei2OZbGe7H006FM21F3ejOzx+13mkG2I2cA
         gHLw==
X-Forwarded-Encrypted: i=1; AKwUvBxFvQFStjRYxGDXNqT451dR20DvouJ/oNI6Tfu/RP2r6QFI3DHxvtojQiOjTvT/OXA+QRrtskbYJky4U5GStNUBQt4=@vger.kernel.org
X-Gm-Message-State: AFuF++ltzLpC/vMOKlIwxV19ATp8pE5etg7S5xFInE/jj49krY8cI8Hu
	ZZqvKO5MHi/3HAs8ZxPIncoCl996xBOOFHfauOdq6utpzNukNsFOoKkhFTNuMgCwMhE=
X-Gm-Gg: AYBFou2kQx+4n9VyNhOFQDx8Wh9Tds+bpxsywdH/w5shQpdSPxCSC4IsTraG9O/k3h6
	b0pkAOHEdsmGqXukVyR4a+oB0xS7WFAhVNB2Hir1SRd72muiOnsdJAGFPPZ6CeS+7oU7ejsSXts
	ahmSQ8DeHXhwCV2bnp+x/+rw7DN9WWEI09xDQZpHoOBDn3ztBOtZHEosoDumUEdzAM8uoa8BDHD
	f4C129DbuHNyt6m1jkBbb5nHps5IPSUXxygb7HFY8eeOmf2S+gp+nDBKXAe0dkgDaeqjb4ucwTl
	JqMzm65Z/jb1aVz+jeOIIJJ7h9AMZLMA6GOq3lwWBgOpDrEwy3EEqjH9XcPAVYbmrBDSfn7TsjE
	hUuRpz3Byg5aeabRgVjSQsIbGLNse62sliZJIv+1+mTFFNK2+BjKoSXZc+jFqPc5OhsSZFIlOQF
	MuuN0Yi8zkg1DuS8I2NEUfies45VRj907zMWMJbRrggb2RqKE5WL8P0z/HqFLKCSsWZmdlnW6Pj
	1Xcxf70x/X9oQwy7KT0o0fe6iTi7w8egsn+9dm34UwrLQ1LkuPg3acUTg==
X-Received: by 2002:ac8:7f0d:0:b0:52f:9e5c:33ff with SMTP id d75a77b69052e-5329e3767d5mr46806381cf.13.1789742991795;
        Fri, 18 Sep 2026 07:49:51 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532a19a5ce3sm14843771cf.12.2026.09.18.07.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:49:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:23 +0000
Subject: [PATCH RFC v4 04/13] ftrace: Mark modules hosting direct-call
 trampolines for Tasks RCU
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-4-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=7065;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=WxuURWfyPfVrbwoJYzsme+dJrO0g2fOexfelnDzg3io=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOzJNf4EPWurTiDx3kIhXFyZwPBWmFPff1giOF5VzhAiMbXyfZ1cbtvqDh0lVG3P1j1LapzQR9r
 O/9+GtEnVpA0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

An out-of-line direct trampoline registered with register_ftrace_direct()
is kept alive only by Tasks RCU while a task executes it or is preempted
in something it called; ftrace_shutdown()'s synchronize_rcu_tasks() is
what stops rmmod freeing it under such a task.  Where Tasks RCU is built
on reader-marked trampolines, such a trampoline must be a Tasks Trace
reader across its call-out like the ftrace and BPF trampolines are, so
document that in register_ftrace_direct().

That still leaves the few instructions before the reader is entered and
after it is left.  For BPF images those are in dynamically allocated
text that rcu_tasks_trampoline_text() already treats as unmarked
trampoline text, but the in-tree samples (and any similar user) place
their trampolines in module .text.  Add a sticky
module::ftrace_direct_tramp flag (under CONFIG_TASKS_RCU_TRAMPOLINE_READERS,
its only consumer), set by every register/modify path when the direct
address is module text, and have rcu_tasks_trampoline_text() treat a task
interrupted anywhere in such a module as a potential holdout.  Other
modules' text is unaffected.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/module.h |  7 +++++++
 kernel/rcu/tasks.h     | 18 +++++++++++++++---
 kernel/trace/ftrace.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..82ca4f774725 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -521,6 +521,13 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	/*
+	 * An ftrace direct-call trampoline lives in this module's text; see
+	 * rcu_tasks_trampoline_text().  Sticky once set.
+	 */
+	bool ftrace_direct_tramp;
+#endif
 #ifdef CONFIG_KPROBES
 	void *kprobes_text_start;
 	unsigned int kprobes_text_size;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index eb1388dd8a61..42ea6e0e61cb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1006,6 +1006,8 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  *    deliberately does not ask is_ftrace_trampoline() and friends, since
  *    text being torn down may already be unregistered there);
  *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text();
+ *  - the text of a module that hosts an out-of-line ftrace direct-call
+ *    trampoline (see ftrace_direct_mark_module());
  *  - the bytes after a kprobe that a pending jump optimization is about to
  *    overwrite, the one synchronize_rcu_tasks() user with no trampoline.
  *
@@ -1014,12 +1016,22 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  */
 bool rcu_tasks_trampoline_text(unsigned long ip)
 {
+	bool ret = true;
+
 	if (core_kernel_text(ip))
 		return arch_rcu_tasks_trampoline_text(ip) ||
 		       kprobe_in_optimized_region(ip);
-	if (is_module_text_address(ip))
-		return kprobe_in_optimized_region(ip);
-	return true;
+
+#ifdef CONFIG_MODULES
+	scoped_guard(rcu) {
+		struct module *mod = __module_text_address(ip);
+
+		if (mod)
+			ret = READ_ONCE(mod->ftrace_direct_tramp) ||
+			      kprobe_in_optimized_region(ip);
+	}
+#endif
+	return ret;
 }
 NOKPROBE_SYMBOL(rcu_tasks_trampoline_text);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 53d5db60bfa5..f69f71591358 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6076,6 +6076,29 @@ static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->trampoline = 0;
 }
 
+/*
+ * A direct trampoline may live in module text rather than in dynamically
+ * allocated text that rcu_tasks_trampoline_text() recognises on its own (see
+ * samples/ftrace/ftrace-direct*.c).  The trampoline itself must be a Tasks
+ * Trace reader across its call-out (see register_ftrace_direct()); marking the
+ * owning module here covers the instructions before it enters that reader and
+ * after it leaves it, where a task interrupted in the module's text must not be
+ * counted as Tasks-RCU quiescent, so that ftrace_shutdown()'s
+ * synchronize_rcu_tasks() still keeps the module text from being freed under
+ * it.
+ */
+static void ftrace_direct_mark_module(unsigned long addr)
+{
+#if defined(CONFIG_MODULES) && defined(CONFIG_TASKS_RCU_TRAMPOLINE_READERS)
+	struct module *mod;
+
+	guard(rcu)();
+	mod = __module_text_address(addr);
+	if (mod)
+		WRITE_ONCE(mod->ftrace_direct_tramp, true);
+#endif
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * for multiple functions registered in @ops
@@ -6090,6 +6113,17 @@ static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
  * and save the parameters of the function being traced, and restore them
  * (or inject new ones if needed), before returning.
  *
+ * Nothing but Tasks RCU keeps the trampoline at @addr alive while a task is
+ * executing it or is preempted in something it called.  On architectures that
+ * select HAVE_RCU_TRAMPOLINE_READERS, Tasks RCU only waits for such a task if
+ * it is a Tasks Trace RCU reader, so the trampoline must enter one
+ * (rcu_read_lock_trace() or an assembly equivalent) before calling out and
+ * leave it before returning, just as that option requires of the in-kernel
+ * ftrace and BPF trampolines.  The few instructions before and after are
+ * covered by the irq-exit check: automatically for trampolines outside kernel
+ * and module text (e.g. BPF images), and via ftrace_direct_mark_module() for
+ * trampolines in module text.
+ *
  * Returns:
  *  0 on success
  *  -EINVAL  - The @ops object was already registered with this call or
@@ -6169,6 +6203,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->flags |= MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
 	ops->direct_call = addr;
+	ftrace_direct_mark_module(addr);
 
 	err = register_ftrace_function_nolock(ops);
 	if (err)
@@ -6237,6 +6272,8 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	lockdep_assert_held_once(&direct_mutex);
 
+	ftrace_direct_mark_module(addr);
+
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
@@ -6419,6 +6456,7 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
 			if (__ftrace_lookup_ip(direct_functions, entry->ip))
 				goto out_unlock;
+			ftrace_direct_mark_module(entry->direct);
 		}
 	}
 
@@ -6702,6 +6740,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 			tmp = __ftrace_lookup_ip(direct_hash, entry->ip);
 			if (!tmp)
 				continue;
+			ftrace_direct_mark_module(entry->direct);
 			tmp->direct = entry->direct;
 		}
 	}

-- 
2.55.0

