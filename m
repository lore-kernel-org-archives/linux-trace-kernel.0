Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE6946C;
	Tue, 26 Nov 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629397; cv=none; b=gY8jPG1Gf5VGwpoabEbVEZidJdsHO8t7hOROuHxiUoveGTMxvRafCI9zj1TltE7xhURE/EqQi/hW/vpKjo6360UjHr4pqLm8vOJSFCz6sLoS3MuXywzUB4UFJCDE8svA+0L6Ipnd2sNn2jr5utLo5Uxuu0tOx5GrvwMeXNxahlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629397; c=relaxed/simple;
	bh=cLxIbSGBoRaPw3169/Ujnl5h46Pq1YmSYLjEwUEjjI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqP/kvPTNcK0oDyDOrH0KtGB68kpelXTK2okm9279dP9kPHMTzSKDZ2XdGMS8m8hRAbW1okGJJsPDFui49A7jsc0bE7sc6XS/MaVW1+uZzzD6QJl1M78y28Mgoh55WpD9lS8kci57nk00JGqyf/+MFwqNbrocSzVR6/AA5iY6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab14Ezls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab14Ezls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1068C4CECF;
	Tue, 26 Nov 2024 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732629396;
	bh=cLxIbSGBoRaPw3169/Ujnl5h46Pq1YmSYLjEwUEjjI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ab14EzlsS/VRjoIsA1Ux09+UxBr5W+WhB2yk9UC1y83dOgJZpb11tODxq0ybkS1Gh
	 LAilOss1sygXAvune9Tkb78To1o/DxV+zHDDyXCQ3aTJwQwi/XLcSSbMvtboDb1YnD
	 VdGLT/ebVRJ1EmrNp/Subv4MAbG1J0kCK7ONufn3zo0Mv1M6Wo+jFlje3vVqgKXuL6
	 rKFrh2x+5nxnGmuddsJt4eIQC64/CK7TpN3UxrllxkP0Xyh612DBQvmURk7TivGLqV
	 RA4o28I5O/2mrdzy2xL4ffbQgykeYZzSN1AG2Wo2mErFMIbkO0Et7jNAZT1VFBnts/
	 83VVBSpw4gxzw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/6] kprobes: Adopt guard() and scoped_guard()
Date: Tue, 26 Nov 2024 22:56:31 +0900
Message-ID: <173262939134.8323.5749305699780043892.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173262937038.8323.5774362855789721936.stgit@devnote2>
References: <173262937038.8323.5774362855789721936.stgit@devnote2>
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

Use guard() or scoped_guard() for critical sections rather than
discrete lock/unlock pairs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |  205 +++++++++++++++++++++++-------------------------------
 1 file changed, 89 insertions(+), 116 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cb9dbdafbbcf..62b5b08d809d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -141,10 +141,9 @@ static int collect_garbage_slots(struct kprobe_insn_cache *c);
 kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 {
 	struct kprobe_insn_page *kip;
-	kprobe_opcode_t *slot = NULL;
 
 	/* Since the slot array is not protected by rcu, we need a mutex */
-	mutex_lock(&c->mutex);
+	guard(mutex)(&c->mutex);
  retry:
 	rcu_read_lock();
 	list_for_each_entry_rcu(kip, &c->pages, list) {
@@ -155,9 +154,8 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 				if (kip->slot_used[i] == SLOT_CLEAN) {
 					kip->slot_used[i] = SLOT_USED;
 					kip->nused++;
-					slot = kip->insns + (i * c->insn_size);
 					rcu_read_unlock();
-					goto out;
+					return kip->insns + (i * c->insn_size);
 				}
 			}
 			/* kip->nused is broken. Fix it. */
@@ -174,12 +172,12 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	/* All out of space.  Need to allocate a new page. */
 	kip = kmalloc(struct_size(kip, slot_used, slots_per_page(c)), GFP_KERNEL);
 	if (!kip)
-		goto out;
+		return NULL;
 
 	kip->insns = c->alloc();
 	if (!kip->insns) {
 		kfree(kip);
-		goto out;
+		return NULL;
 	}
 	INIT_LIST_HEAD(&kip->list);
 	memset(kip->slot_used, SLOT_CLEAN, slots_per_page(c));
@@ -188,14 +186,12 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	kip->ngarbage = 0;
 	kip->cache = c;
 	list_add_rcu(&kip->list, &c->pages);
-	slot = kip->insns;
 
 	/* Record the perf ksymbol register event after adding the page */
 	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (unsigned long)kip->insns,
 			   PAGE_SIZE, false, c->sym);
-out:
-	mutex_unlock(&c->mutex);
-	return slot;
+
+	return kip->insns;
 }
 
 /* Return true if all garbages are collected, otherwise false. */
@@ -256,7 +252,7 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
 	struct kprobe_insn_page *kip;
 	long idx;
 
-	mutex_lock(&c->mutex);
+	guard(mutex)(&c->mutex);
 	rcu_read_lock();
 	list_for_each_entry_rcu(kip, &c->pages, list) {
 		idx = ((long)slot - (long)kip->insns) /
@@ -282,7 +278,6 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
 			collect_one_slot(kip, idx);
 		}
 	}
-	mutex_unlock(&c->mutex);
 }
 
 /*
@@ -638,10 +633,9 @@ static void kprobe_optimizer(struct work_struct *work)
 	mutex_unlock(&kprobe_mutex);
 }
 
-/* Wait for completing optimization and unoptimization */
-void wait_for_kprobe_optimizer(void)
+static void wait_for_kprobe_optimizer_locked(void)
 {
-	mutex_lock(&kprobe_mutex);
+	lockdep_assert_held(&kprobe_mutex);
 
 	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
 		mutex_unlock(&kprobe_mutex);
@@ -653,8 +647,14 @@ void wait_for_kprobe_optimizer(void)
 
 		mutex_lock(&kprobe_mutex);
 	}
+}
 
-	mutex_unlock(&kprobe_mutex);
+/* Wait for completing optimization and unoptimization */
+void wait_for_kprobe_optimizer(void)
+{
+	guard(mutex)(&kprobe_mutex);
+
+	wait_for_kprobe_optimizer_locked();
 }
 
 bool optprobe_queued_unopt(struct optimized_kprobe *op)
@@ -884,10 +884,10 @@ static void optimize_all_kprobes(void)
 	struct kprobe *p;
 	unsigned int i;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 	/* If optimization is already allowed, just return. */
 	if (kprobes_allow_optimization)
-		goto out;
+		return;
 
 	cpus_read_lock();
 	kprobes_allow_optimization = true;
@@ -899,8 +899,6 @@ static void optimize_all_kprobes(void)
 	}
 	cpus_read_unlock();
 	pr_info("kprobe jump-optimization is enabled. All kprobes are optimized if possible.\n");
-out:
-	mutex_unlock(&kprobe_mutex);
 }
 
 #ifdef CONFIG_SYSCTL
@@ -910,12 +908,10 @@ static void unoptimize_all_kprobes(void)
 	struct kprobe *p;
 	unsigned int i;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 	/* If optimization is already prohibited, just return. */
-	if (!kprobes_allow_optimization) {
-		mutex_unlock(&kprobe_mutex);
+	if (!kprobes_allow_optimization)
 		return;
-	}
 
 	cpus_read_lock();
 	kprobes_allow_optimization = false;
@@ -927,10 +923,8 @@ static void unoptimize_all_kprobes(void)
 		}
 	}
 	cpus_read_unlock();
-	mutex_unlock(&kprobe_mutex);
-
 	/* Wait for unoptimizing completion. */
-	wait_for_kprobe_optimizer();
+	wait_for_kprobe_optimizer_locked();
 	pr_info("kprobe jump-optimization is disabled. All kprobes are based on software breakpoint.\n");
 }
 
@@ -942,7 +936,7 @@ static int proc_kprobes_optimization_handler(const struct ctl_table *table,
 {
 	int ret;
 
-	mutex_lock(&kprobe_sysctl_mutex);
+	guard(mutex)(&kprobe_sysctl_mutex);
 	sysctl_kprobes_optimization = kprobes_allow_optimization ? 1 : 0;
 	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
 
@@ -950,7 +944,6 @@ static int proc_kprobes_optimization_handler(const struct ctl_table *table,
 		optimize_all_kprobes();
 	else
 		unoptimize_all_kprobes();
-	mutex_unlock(&kprobe_sysctl_mutex);
 
 	return ret;
 }
@@ -1025,7 +1018,8 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 #define __arm_kprobe(p)				arch_arm_kprobe(p)
 #define __disarm_kprobe(p, o)			arch_disarm_kprobe(p)
 #define kprobe_disarmed(p)			kprobe_disabled(p)
-#define wait_for_kprobe_optimizer()		do {} while (0)
+#define wait_for_kprobe_optimizer_locked()			\
+	lockdep_assert_held(&kprobe_mutex)
 
 static int reuse_unused_kprobe(struct kprobe *ap)
 {
@@ -1489,6 +1483,7 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 {
 	bool on_func_entry;
+
 	return _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
 }
 
@@ -1523,14 +1518,12 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
  */
 static inline int warn_kprobe_rereg(struct kprobe *p)
 {
-	int ret = 0;
+	guard(mutex)(&kprobe_mutex);
 
-	mutex_lock(&kprobe_mutex);
 	if (WARN_ON_ONCE(__get_valid_kprobe(p)))
-		ret = -EINVAL;
-	mutex_unlock(&kprobe_mutex);
+		return -EINVAL;
 
-	return ret;
+	return 0;
 }
 
 static int check_ftrace_location(struct kprobe *p)
@@ -1618,44 +1611,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	return ret;
 }
 
-int register_kprobe(struct kprobe *p)
+static int __register_kprobe(struct kprobe *p)
 {
 	int ret;
 	struct kprobe *old_p;
-	struct module *probed_mod;
-	kprobe_opcode_t *addr;
-	bool on_func_entry;
-
-	/* Adjust probe address from symbol */
-	addr = _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
-	if (IS_ERR(addr))
-		return PTR_ERR(addr);
-	p->addr = addr;
-
-	ret = warn_kprobe_rereg(p);
-	if (ret)
-		return ret;
 
-	/* User can pass only KPROBE_FLAG_DISABLED to register_kprobe */
-	p->flags &= KPROBE_FLAG_DISABLED;
-	p->nmissed = 0;
-	INIT_LIST_HEAD(&p->list);
-
-	ret = check_kprobe_address_safe(p, &probed_mod);
-	if (ret)
-		return ret;
-
-	mutex_lock(&kprobe_mutex);
-
-	if (on_func_entry)
-		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
+	guard(mutex)(&kprobe_mutex);
 
 	old_p = get_kprobe(p->addr);
-	if (old_p) {
+	if (old_p)
 		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
-		ret = register_aggr_kprobe(old_p, p);
-		goto out;
-	}
+		return register_aggr_kprobe(old_p, p);
 
 	cpus_read_lock();
 	/* Prevent text modification */
@@ -1664,7 +1630,7 @@ int register_kprobe(struct kprobe *p)
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 	if (ret)
-		goto out;
+		return ret;
 
 	INIT_HLIST_NODE(&p->hlist);
 	hlist_add_head_rcu(&p->hlist,
@@ -1675,14 +1641,43 @@ int register_kprobe(struct kprobe *p)
 		if (ret) {
 			hlist_del_rcu(&p->hlist);
 			synchronize_rcu();
-			goto out;
 		}
 	}
 
 	/* Try to optimize kprobe */
 	try_to_optimize_kprobe(p);
-out:
-	mutex_unlock(&kprobe_mutex);
+	return 0;
+}
+
+int register_kprobe(struct kprobe *p)
+{
+	int ret;
+	struct module *probed_mod;
+	kprobe_opcode_t *addr;
+	bool on_func_entry;
+
+	/* Canonicalize probe address from symbol */
+	addr = _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
+	p->addr = addr;
+
+	ret = warn_kprobe_rereg(p);
+	if (ret)
+		return ret;
+
+	/* User can pass only KPROBE_FLAG_DISABLED to register_kprobe */
+	p->flags &= KPROBE_FLAG_DISABLED;
+	if (on_func_entry)
+		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
+	p->nmissed = 0;
+	INIT_LIST_HEAD(&p->list);
+
+	ret = check_kprobe_address_safe(p, &probed_mod);
+	if (ret)
+		return ret;
+
+	ret = __register_kprobe(p);
 
 	if (probed_mod)
 		module_put(probed_mod);
@@ -1858,12 +1853,11 @@ void unregister_kprobes(struct kprobe **kps, int num)
 
 	if (num <= 0)
 		return;
-	mutex_lock(&kprobe_mutex);
-	for (i = 0; i < num; i++)
-		if (__unregister_kprobe_top(kps[i]) < 0)
-			kps[i]->addr = NULL;
-	mutex_unlock(&kprobe_mutex);
-
+	scoped_guard(mutex, &kprobe_mutex) {
+		for (i = 0; i < num; i++)
+			if (__unregister_kprobe_top(kps[i]) < 0)
+				kps[i]->addr = NULL;
+	}
 	synchronize_rcu();
 	for (i = 0; i < num; i++)
 		if (kps[i]->addr)
@@ -2302,8 +2296,9 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 
 	if (num <= 0)
 		return;
-	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < num; i++) {
+		guard(mutex)(&kprobe_mutex);
+
 		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
 			rps[i]->kp.addr = NULL;
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
@@ -2312,7 +2307,6 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 		rcu_assign_pointer(rps[i]->rph->rp, NULL);
 #endif
 	}
-	mutex_unlock(&kprobe_mutex);
 
 	synchronize_rcu();
 	for (i = 0; i < num; i++) {
@@ -2393,18 +2387,14 @@ static void kill_kprobe(struct kprobe *p)
 /* Disable one kprobe */
 int disable_kprobe(struct kprobe *kp)
 {
-	int ret = 0;
 	struct kprobe *p;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* Disable this kprobe */
 	p = __disable_kprobe(kp);
-	if (IS_ERR(p))
-		ret = PTR_ERR(p);
 
-	mutex_unlock(&kprobe_mutex);
-	return ret;
+	return IS_ERR(p) ? PTR_ERR(p) : 0;
 }
 EXPORT_SYMBOL_GPL(disable_kprobe);
 
@@ -2414,20 +2404,16 @@ int enable_kprobe(struct kprobe *kp)
 	int ret = 0;
 	struct kprobe *p;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* Check whether specified probe is valid. */
 	p = __get_valid_kprobe(kp);
-	if (unlikely(p == NULL)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (unlikely(p == NULL))
+		return -EINVAL;
 
-	if (kprobe_gone(kp)) {
+	if (kprobe_gone(kp))
 		/* This kprobe has gone, we couldn't enable it. */
-		ret = -EINVAL;
-		goto out;
-	}
+		return -EINVAL;
 
 	if (p != kp)
 		kp->flags &= ~KPROBE_FLAG_DISABLED;
@@ -2441,8 +2427,6 @@ int enable_kprobe(struct kprobe *kp)
 				kp->flags |= KPROBE_FLAG_DISABLED;
 		}
 	}
-out:
-	mutex_unlock(&kprobe_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(enable_kprobe);
@@ -2630,11 +2614,11 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	unsigned int i;
 	int checkcore = (val == MODULE_STATE_GOING);
 
-	if (val == MODULE_STATE_COMING) {
-		mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
+
+	if (val == MODULE_STATE_COMING)
 		add_module_kprobe_blacklist(mod);
-		mutex_unlock(&kprobe_mutex);
-	}
+
 	if (val != MODULE_STATE_GOING && val != MODULE_STATE_LIVE)
 		return NOTIFY_DONE;
 
@@ -2644,7 +2628,6 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	 * notified, only '.init.text' section would be freed. We need to
 	 * disable kprobes which have been inserted in the sections.
 	 */
-	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
 		hlist_for_each_entry(p, head, hlist)
@@ -2667,7 +2650,6 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	}
 	if (val == MODULE_STATE_GOING)
 		remove_module_kprobe_blacklist(mod);
-	mutex_unlock(&kprobe_mutex);
 	return NOTIFY_DONE;
 }
 
@@ -2695,7 +2677,7 @@ void kprobe_free_init_mem(void)
 	struct kprobe *p;
 	int i;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* Kill all kprobes on initmem because the target code has been freed. */
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
@@ -2705,8 +2687,6 @@ void kprobe_free_init_mem(void)
 				kill_kprobe(p);
 		}
 	}
-
-	mutex_unlock(&kprobe_mutex);
 }
 
 static int __init init_kprobes(void)
@@ -2902,11 +2882,11 @@ static int arm_all_kprobes(void)
 	unsigned int i, total = 0, errors = 0;
 	int err, ret = 0;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* If kprobes are armed, just return */
 	if (!kprobes_all_disarmed)
-		goto already_enabled;
+		return 0;
 
 	/*
 	 * optimize_kprobe() called by arm_kprobe() checks
@@ -2936,8 +2916,6 @@ static int arm_all_kprobes(void)
 	else
 		pr_info("Kprobes globally enabled\n");
 
-already_enabled:
-	mutex_unlock(&kprobe_mutex);
 	return ret;
 }
 
@@ -2948,13 +2926,11 @@ static int disarm_all_kprobes(void)
 	unsigned int i, total = 0, errors = 0;
 	int err, ret = 0;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* If kprobes are already disarmed, just return */
-	if (kprobes_all_disarmed) {
-		mutex_unlock(&kprobe_mutex);
+	if (kprobes_all_disarmed)
 		return 0;
-	}
 
 	kprobes_all_disarmed = true;
 
@@ -2979,11 +2955,8 @@ static int disarm_all_kprobes(void)
 	else
 		pr_info("Kprobes globally disabled\n");
 
-	mutex_unlock(&kprobe_mutex);
-
 	/* Wait for disarming all kprobes by optimizer */
-	wait_for_kprobe_optimizer();
-
+	wait_for_kprobe_optimizer_locked();
 	return ret;
 }
 

