Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E50348C75
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135802; cv=none; b=rxV6XUz6yqEXYBnguVoBX/kr55+L2FIkXOA8J6ox6xfUus6z07Vl/TvQXpHlErllYYXKu94g2U3/92uliTi/H7g6cnLNNc6ZnlDuu/AsBbEQYAI3pPyGOtr0bksaWEDMAYmWlxoVzPLqW/h5D9e0Y7mD/FB+J89GU/QQAR80ItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135802; c=relaxed/simple;
	bh=0t7KiskdL/z6tLq58DM0lyjoNIyrb4NbcoG2+xIJz7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssxaUKsnm8ezq9IQPR5Nb6tnuoRg/IhCTQF+usMn4ftFWE+laNHtJ0xPuVNlJKb1p3E2uph5OguOHuHg8YIPibiHW9iIlQn7iVMTTXuS4Q7NuRO3BcbOapLEwZhNiyiJ2SUDnWiuDP9uHwcCEbzZNC19GOsl1Do4vDcmuE3O214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=V5gZ2KGo; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="V5gZ2KGo"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-85a50f6a7f7so9845927b3.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135798; x=1789740598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dPfI0hp8i5ODnb7Ti+2mvm8Dl2bKUUBUiZ4EzuwrKLQ=;
        b=V5gZ2KGo39xmVWgRLFO095La0VIDQovmhovVThr1oI8A8P5y7q85fSiDuQlgZrvZe1
         MNb18wPPQIRGI3obDMLv4J4sTBY+x31DXkN9ggzo/JM8Z61YafBrJSpWL8pULpcbxeun
         JFaat0EY9hQPtyRHfRRgDhOOGgSzBk7TTgdQgNivkeJFfuCkkd9d1zUxs/hki9d8vvts
         RSPD+/5v0AuLsaWqILHhnR3PUnuim1y9skh94hvhKrUVMdrH9dGdQ43M6Z45vSFdO3Ij
         cObtKtauKaOhjI5y1YmMK7FMl9q2Z7qaLlega+60+bQAkXL3TldjczVBtrJYxGLdljqn
         cqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135798; x=1789740598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dPfI0hp8i5ODnb7Ti+2mvm8Dl2bKUUBUiZ4EzuwrKLQ=;
        b=ec2Rm4ZSKFRi2ogE4lstVKIfRciMotOIFV97CrYcOvsVuF1iHmUSBGHrKzS4b7f2Fj
         PmF5pk/RgSkFPP4L1u0kSJ2znZmH9CnWbmSkW/MdyIQk0oS0YXIaUeppZ7poFoVmZObP
         mMstScwu86JHl2XLjDjIKPefQYVkswr6qseA+1RRDK/pyWvHPdAW67k1potmAPFpAIPl
         uBO7SKvuwfJc2D+13NnvCF46+8paOqMDnD6H+g1K6Rpfyi50GDOloKf4Y9908IEDBXS6
         bKZXG3ht9bgPiS+AhL1xkyqIDiT+jJ1AqaRHaHAkgDQ8+W/68mOeRE7Uj00FKqQ1jF03
         Z/YQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4WJRAaNP9x+wxeyS2O3Ki6eIAG0409ijgrWv5/G1QGz1yWOR1jTuBUtopclT2ptkyhGloAFUjMoVv8oEyiepJr3Y=@vger.kernel.org
X-Gm-Message-State: AFuF++krv2LsEY1AldfmB12BYFYT+blCF/En3GX0q8ed6cEmDge5gaRq
	w5ZbaEZxeYmWWurHD5qtNIi0BwFJA3T/4/HAvmPBrYDWyJWJBnaDVGqUH/+ME2t7lf0=
X-Gm-Gg: AYBFou1Ium5uEZapDoej2fuPmuLSHynhLknglaMj7yVGP3mJ4d1OOlc71CVjgjSlCr4
	f4U8LHDSJ1M8wOeazFOSJ6FMGYbxBakGrGZ56XtnomcJjjL2lfnzsETYycyBokrfQWIH5rt3GG6
	95J8TMTWpIpyJ9r/VlF2WcPM0cRF+zJ56zGvNCS3OCLnhjctMdo8FgkWB8upU22Sdb+MSrCNgbu
	AxJuH17WTGFViucIelcw51H4Q3RDyR5eUWn44bW6Yc2vcsnNO9wjZZ9uMVWEvMw2csbo40vU8Ty
	2tyExlhVUrNz8P8m8pAzfkSlJiHLVe43wlDhr4+SENSQkEf/mIcDgsBaBbed6VBsEEGj/O74pfF
	Aj4QKkDNqjirvpxSyqtaxasiGj/cr3Tb6eOJZPtKSxPD9RUEaQZ02jXfGaIAFGzBd7i2U4PDyGj
	9yISb9sNRcp4lid3oYKdbF/99qs++hvMVxzBWcEZGzInS1QiyPNBmbEm0v44QqGXHJwgFBTioRx
	5J0YCZAtXbjAbPvwDYzNUCRC1JH+46G3vI7GnV6Kzq3K9fD7JDGEF0t
X-Received: by 2002:a05:690c:e64c:20b0:873:5c7b:c107 with SMTP id 00721157ae682-884b338f76bmr10673077b3.63.1789135797554;
        Fri, 11 Sep 2026 07:09:57 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e8047a4dsm255725685a.23.2026.09.11.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:09:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:43 +0000
Subject: [PATCH RFC v2 05/15] ftrace: Mark modules hosting direct-call
 trampolines for Tasks RCU
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-5-eaaa61ed2da4@toxicpanda.com>
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
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
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135736; l=7014;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=0t7KiskdL/z6tLq58DM0lyjoNIyrb4NbcoG2+xIJz7Y=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIYpNGNhK8IIkgKHr1QxZn5VS4Cl+AINmPPfcsvZi4ZGk+7mTHv8oPmVPnKO/4ckp4yjA+b+rY+
 zCDlRK/TVmQM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

An out-of-line direct trampoline registered with register_ftrace_direct()
is kept alive only by Tasks RCU while a task executes it or is preempted
in something it called; ftrace_shutdown()'s synchronize_rcu_tasks() is
what stops rmmod freeing it under such a task.  Once preemption becomes a
Tasks RCU quiescent state, such a trampoline must hold
current->rcu_tramp_nesting across its call-out like the ftrace and BPF
trampolines do, so document that in register_ftrace_direct().

That still leaves the few instructions before the increment and after
the decrement.  For BPF images those are in dynamically allocated text
that rcu_tasks_ip_in_trampoline() already treats as protected, but the
in-tree samples (and any similar user) place their trampolines in module
.text.  Add a sticky module::ftrace_direct_tramp flag, set by every
register/modify path when the direct address is module text, and have
rcu_tasks_ip_in_trampoline() treat a task interrupted anywhere in such a
module as a potential reader.  Other modules' text is unaffected.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/module.h |  7 +++++++
 kernel/rcu/tasks.h     | 23 +++++++++++++++++++++--
 kernel/trace/ftrace.c  | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..ea4727f53fab 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -521,6 +521,13 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/*
+	 * An ftrace direct-call trampoline lives in this module's text; see
+	 * rcu_tasks_ip_in_trampoline().  Sticky once set.
+	 */
+	bool ftrace_direct_tramp;
+#endif
 #ifdef CONFIG_KPROBES
 	void *kprobes_text_start;
 	unsigned int kprobes_text_size;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 0e46d8fe4d8e..1b9fe1bfa591 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1114,16 +1114,35 @@ bool __weak arch_rcu_tasks_ip_in_trampoline(unsigned long ip)
  *    deliberately does not consult is_ftrace_trampoline() and friends: text
  *    being torn down may already be unregistered there while a task still
  *    stands on it;
- *  - in core text the architecture flags via arch_rcu_tasks_ip_in_trampoline().
+ *  - in core text the architecture flags via arch_rcu_tasks_ip_in_trampoline();
+ *  - in the text of a module that hosts an ftrace direct-call trampoline,
+ *    which covers the instructions before that trampoline's increment and
+ *    after its decrement (see ftrace_direct_mark_module()).
  *
  * A false positive only defers the quiescent state to the task's next
  * context switch.
  */
 bool rcu_tasks_ip_in_trampoline(unsigned long ip)
 {
+	bool ret = true;
+
 	if (core_kernel_text(ip))
 		return arch_rcu_tasks_ip_in_trampoline(ip);
-	return !is_module_text_address(ip);
+
+#ifdef CONFIG_MODULES
+	scoped_guard(rcu) {
+		struct module *mod = __module_text_address(ip);
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+		if (mod)
+			ret = READ_ONCE(mod->ftrace_direct_tramp);
+#else
+		if (mod)
+			ret = false;
+#endif
+	}
+#endif
+	return ret;
 }
 NOKPROBE_SYMBOL(rcu_tasks_ip_in_trampoline);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 53d5db60bfa5..14f27b887231 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6076,6 +6076,29 @@ static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->trampoline = 0;
 }
 
+/*
+ * A direct trampoline may live in module text rather than in dynamically
+ * allocated text that rcu_tasks_ip_in_trampoline() recognises on its own (see
+ * samples/ftrace/ftrace-direct*.c).  The trampoline itself must hold
+ * current->rcu_tramp_nesting across its call-out (see register_ftrace_direct());
+ * marking the owning module here covers the instructions before that increment
+ * and after the decrement, where a task interrupted in the module's text must
+ * not be treated as Tasks-RCU quiescent, so that ftrace_shutdown()'s
+ * synchronize_rcu_tasks() still keeps the module text from being freed under
+ * it.
+ */
+static void ftrace_direct_mark_module(unsigned long addr)
+{
+#ifdef CONFIG_MODULES
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
+ * select ARCH_HAS_RCU_TASKS_PREEMPT_QS a preemption is a Tasks RCU quiescent
+ * state unless current->rcu_tramp_nesting is non-zero, so the trampoline must
+ * increment it before calling out and decrement it before returning, as the
+ * ftrace and BPF trampolines do (see rcu_tasks_trampoline_enter() and
+ * samples/ftrace/ftrace-direct.h).  The few instructions before the increment
+ * and after the decrement are covered by the irq-exit IP check: automatically
+ * for trampolines outside kernel and module text (e.g. BPF images), and via
+ * ftrace_direct_mark_module() for trampolines in module text.
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

