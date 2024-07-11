Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766615B10F;
	Thu, 11 Jul 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696052; cv=none; b=kolGEzBNiPgqmlE5HEyJSVa9xPoLY86vWXCUmJ6XZ7AHdX9sKhGYtwMMcb65YgLVNsITKT4AY3ibDZ9EPZiUdH4BfTXBABuxa/5qApYsZQzGTdg09JYexuUUkXfxwsLIKj2ct/CWm0Q635AKS3eXv09FO9m6x7YUSAVGcbei/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696052; c=relaxed/simple;
	bh=2T0ZeaCuHyE7S1MQjICNRCQqp1yquQA9xYneZhcf7yA=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gCQj1qs7I7L8dC/0E+Vhn6VWllRZ/C6N+eytVoAZp74avJf8VJmPU9U8TFZVFXbLRNtBUwUsJiY4aKdHzZuvKtAF68PMINLN3NvNqbMPjvbqN3gOWqWzI95337WrXGPH5/EVba6SeGjC9Fl1fizpPQ2KUSkXyjRQgH1dxQkFLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gvf8k7lx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gvf8k7lx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=JGAQJ9O4GQNJ+lSrwckhmSvTl5Z3WnOhBl9Cbykx5eM=; b=gvf8k7lxxuojFBCwj8OPBpbV5y
	AXwBogmVlq5Ub110X0UB/t+tI0XMWU2pK80XoOy0UMkxEVHsKmcj5tjiz67BfFOPMNl8LJ9U7/oHE
	M5XLS8EJtYrQ5V+FFWSp1Vi7ZZ8yGV4mBw/kYM8EDsMhnHXjBgkGIWuss27LVnz4OzZYV3YMCscYV
	OdIe+JwhzStMl6Au4saLNYqp3S4KO++lSdLvxDgb69TTrWL5OOFt032cKIV3+Yowo8lsLnQmoK7L2
	E8verntSNWxJK0TCdyfmkIrgpbQaPAHO9ZyVzzEISK7Ti9DreovSScemLUCdiDUtxfhzPIn8nQBV7
	VpbjxThg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRre0-000000015VX-0L3j;
	Thu, 11 Jul 2024 11:07:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D9F793034B0; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110401.311168524@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org,
 oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH v2 10/11] perf/uprobe: Convert single-step and uretprobe to SRCU
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Both single-step and uretprobes take a refcount on struct uprobe in
handle_swbp() in order to ensure struct uprobe stays extant until a
next trap.

Since uprobe_unregister() only cares about the uprobe_consumer
life-time, and these intra-trap sections can be arbitrarily large,
create a second SRCU domain to cover these.

Notably, a uretprobe with a registered return_instance that never
triggers -- because userspace -- will currently pin the
return_instance and related uprobe until the task dies. With this
convertion to SRCU this behaviour will inhibit freeing of all uprobes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/uprobes.h |    2 +
 kernel/events/uprobes.c |   60 +++++++++++++++++++++++-------------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -78,6 +78,7 @@ struct uprobe_task {
 
 	struct return_instance		*return_instances;
 	unsigned int			depth;
+	unsigned int			active_srcu_idx;
 };
 
 struct return_instance {
@@ -86,6 +87,7 @@ struct return_instance {
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
+	int			srcu_idx;
 
 	struct return_instance	*next;		/* keep as stack */
 };
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -54,6 +54,15 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem)
  * Covers uprobe->consumers lifetime as well as struct uprobe.
  */
 DEFINE_STATIC_SRCU(uprobes_srcu);
+/*
+ * Covers return_instance->uprobe and utask->active_uprobe. Separate from
+ * uprobe_srcu because uprobe_unregister() doesn't need to wait for this
+ * and these lifetimes can be fairly long.
+ *
+ * Notably, these sections span userspace and as such use
+ * __srcu_read_{,un}lock() to elide lockdep.
+ */
+DEFINE_STATIC_SRCU(uretprobes_srcu);
 
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
@@ -596,25 +605,24 @@ set_orig_insn(struct arch_uprobe *auprob
 			*(uprobe_opcode_t *)&auprobe->insn);
 }
 
-static struct uprobe *try_get_uprobe(struct uprobe *uprobe)
-{
-	if (refcount_inc_not_zero(&uprobe->ref))
-		return uprobe;
-	return NULL;
-}
-
 static struct uprobe *get_uprobe(struct uprobe *uprobe)
 {
 	refcount_inc(&uprobe->ref);
 	return uprobe;
 }
 
-static void uprobe_free_rcu(struct rcu_head *rcu)
+static void uprobe_free_stage2(struct rcu_head *rcu)
 {
 	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
 	kfree(uprobe);
 }
 
+static void uprobe_free_stage1(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+	call_srcu(&uretprobes_srcu, &uprobe->rcu, uprobe_free_stage2);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
 	if (refcount_dec_and_test(&uprobe->ref)) {
@@ -626,7 +634,7 @@ static void put_uprobe(struct uprobe *up
 		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
 		mutex_unlock(&delayed_uprobe_lock);
-		call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
+		call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_stage1);
 	}
 }
 
@@ -1753,7 +1761,7 @@ unsigned long uprobe_get_trap_addr(struc
 static struct return_instance *free_ret_instance(struct return_instance *ri)
 {
 	struct return_instance *next = ri->next;
-	put_uprobe(ri->uprobe);
+	__srcu_read_unlock(&uretprobes_srcu, ri->srcu_idx);
 	kfree(ri);
 	return next;
 }
@@ -1771,7 +1779,7 @@ void uprobe_free_utask(struct task_struc
 		return;
 
 	if (utask->active_uprobe)
-		put_uprobe(utask->active_uprobe);
+		__srcu_read_unlock(&uretprobes_srcu, utask->active_srcu_idx);
 
 	ri = utask->return_instances;
 	while (ri)
@@ -1814,7 +1822,7 @@ static int dup_utask(struct task_struct
 			return -ENOMEM;
 
 		*n = *o;
-		get_uprobe(n->uprobe);
+		__srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
 		n->next = NULL;
 
 		*p = n;
@@ -1931,14 +1939,10 @@ static void prepare_uretprobe(struct upr
 	if (!ri)
 		return;
 
-	ri->uprobe = try_get_uprobe(uprobe);
-	if (!ri->uprobe)
-		goto err_mem;
-
 	trampoline_vaddr = get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
-		goto err_uprobe;
+		goto err_mem;
 
 	/* drop the entries invalidated by longjmp() */
 	chained = (orig_ret_vaddr == trampoline_vaddr);
@@ -1956,11 +1960,13 @@ static void prepare_uretprobe(struct upr
 			 * attack from user-space.
 			 */
 			uprobe_warn(current, "handle tail call");
-			goto err_uprobe;
+			goto err_mem;
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
 
+	ri->srcu_idx = __srcu_read_lock(&uretprobes_srcu);
+	ri->uprobe = uprobe;
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
@@ -1972,8 +1978,6 @@ static void prepare_uretprobe(struct upr
 
 	return;
 
-err_uprobe:
-	uprobe_put(ri->uprobe);
 err_mem:
 	kfree(ri);
 }
@@ -1990,15 +1994,9 @@ pre_ssout(struct uprobe *uprobe, struct
 	if (!utask)
 		return -ENOMEM;
 
-	utask->active_uprobe = try_get_uprobe(uprobe);
-	if (!utask->active_uprobe)
-		return -ESRCH;
-
 	xol_vaddr = xol_get_insn_slot(uprobe);
-	if (!xol_vaddr) {
-		err = -ENOMEM;
-		goto err_uprobe;
-	}
+	if (!xol_vaddr)
+		return -ENOMEM;
 
 	utask->xol_vaddr = xol_vaddr;
 	utask->vaddr = bp_vaddr;
@@ -2007,13 +2005,13 @@ pre_ssout(struct uprobe *uprobe, struct
 	if (unlikely(err))
 		goto err_xol;
 
+	utask->active_srcu_idx = __srcu_read_lock(&uretprobes_srcu);
+	utask->active_uprobe = uprobe;
 	utask->state = UTASK_SSTEP;
 	return 0;
 
 err_xol:
 	xol_free_insn_slot(current);
-err_uprobe:
-	put_uprobe(utask->active_uprobe);
 	return err;
 }
 
@@ -2366,7 +2364,7 @@ static void handle_singlestep(struct upr
 	else
 		WARN_ON_ONCE(1);
 
-	put_uprobe(uprobe);
+	__srcu_read_unlock(&uretprobes_srcu, utask->active_srcu_idx);
 	utask->active_uprobe = NULL;
 	utask->state = UTASK_RUNNING;
 	xol_free_insn_slot(current);


