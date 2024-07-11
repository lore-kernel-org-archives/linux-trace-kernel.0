Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B77115B0FA;
	Thu, 11 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696050; cv=none; b=HoGLQUY/ZOXpPItxp5oY4/aJ0/LHw3O0iKluw1hAUbHhis9GW9Pm2fkpcgiJBrhCWG75hc7IC2Nlx1SS9yltm4MKckYEm62GDI0YhfUDnUMHYY1cx4UdEXNPTBBPRwikNtrYA4BLWiaGULNgoBgtllum/B+/gUd3xreDjDVYFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696050; c=relaxed/simple;
	bh=1M+rhtc/qaJHoSvWssThVK2Vgx9AVwkdXE4otbqqAQE=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WGqnNLOklXS3K8H79DFORko4LCs/hsKN+JHeDgBO8lq6yT+cixY3/++FkxGTrWYwiZNIPv0UGCilmOwJVVq/gLhog70ocETaoyQ4h9/lhdewPuu5H95RT9mykU61PrrrfA2DUzMvRQ2MsYn8XOJMU89Xs0mlqTtri4USmEYRc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=opIittmj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="opIittmj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=oSWYpy59uOkf0yV2H/rgoKV+1idp02ib0EduwVb/ADY=; b=opIittmjzxeKvzGOiAX757Yf4/
	ZE0VyqFSma3GLdV27tVOFaD7BrmuNz4gBpqZfWrunSXcNuUUXkP1Di5f2ptkV1qAwFd5H9DFL7PEJ
	L2TS+FoAWabsx9MMJZQW1j0lezTIBPRy5H7jPmRHaFVzVO9FBL52TpNLo6Se8lWs/ZU/Ki/yNPfZJ
	G9w39uGMO9drhG7EJHIrVaZUdjHJkhEF0CF2rJwCAcAarpqN/L8Mm0kVFQzrNqes54lXKop55Y7j8
	yghDfx2eH2E9gBLnysbMpSI41yN7p1UwXlYJkKU7w01lBU6jwvatPMo41cAa8uB2JCxEEA0POAd3t
	JMTxIhmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRre0-000000015VW-0J2D;
	Thu, 11 Jul 2024 11:07:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D27A7302DCD; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110401.096506262@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:43 +0200
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
Subject: [PATCH v2 08/11] perf/uprobe: Convert (some) uprobe->refcount to SRCU
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With handle_swbp() hitting concurrently on (all) CPUs, potentially on
the same uprobe, the uprobe->refcount can get *very* hot. Move the
struct uprobe lifetime into uprobes_srcu such that it covers both the
uprobe and the uprobe->consumers list.

With this, handle_swbp() can use a single large SRCU critical section
to avoid taking a refcount on the uprobe for it's duration.

Notably, the single-step and uretprobe paths need a reference that
leaves handle_swbp() and will, for now, still use ->refcount.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   68 ++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -51,7 +51,7 @@ static struct mutex uprobes_mmap_mutex[U
 DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 
 /*
- * Covers uprobe->consumers lifetime.
+ * Covers uprobe->consumers lifetime as well as struct uprobe.
  */
 DEFINE_STATIC_SRCU(uprobes_srcu);
 
@@ -626,7 +626,7 @@ static void put_uprobe(struct uprobe *up
 		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
 		mutex_unlock(&delayed_uprobe_lock);
-		call_rcu(&uprobe->rcu, uprobe_free_rcu);
+		call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
 	}
 }
 
@@ -678,7 +678,7 @@ static struct uprobe *__find_uprobe(stru
 	struct rb_node *node = rb_find_rcu(&key, &uprobes_tree, __uprobe_cmp_key);
 
 	if (node)
-		return try_get_uprobe(__node_2_uprobe(node));
+		return __node_2_uprobe(node);
 
 	return NULL;
 }
@@ -691,7 +691,7 @@ static struct uprobe *find_uprobe(struct
 {
 	unsigned int seq;
 
-	guard(rcu)();
+	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
 
 	do {
 		seq = read_seqcount_begin(&uprobes_seqcount);
@@ -1142,6 +1142,8 @@ void uprobe_unregister_nosync(struct ino
 {
 	struct uprobe *uprobe;
 
+	guard(srcu)(&uprobes_srcu);
+
 	uprobe = find_uprobe(inode, offset);
 	if (WARN_ON(!uprobe))
 		return;
@@ -1151,7 +1153,6 @@ void uprobe_unregister_nosync(struct ino
 	__uprobe_unregister(uprobe, uc);
 	raw_write_seqcount_end(&uprobe->register_seq);
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
 
@@ -1263,6 +1264,8 @@ int uprobe_apply(struct inode *inode, lo
 	struct uprobe_consumer *con;
 	int ret = -ENOENT;
 
+	guard(srcu)(&uprobes_srcu);
+
 	uprobe = find_uprobe(inode, offset);
 	if (WARN_ON(!uprobe))
 		return ret;
@@ -1275,7 +1278,6 @@ int uprobe_apply(struct inode *inode, lo
 		ret = register_for_each_vma(uprobe, add ? uc : NULL);
 	raw_write_seqcount_end(&uprobe->register_seq);
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
 
 	return ret;
 }
@@ -1929,10 +1931,14 @@ static void prepare_uretprobe(struct upr
 	if (!ri)
 		return;
 
+	ri->uprobe = try_get_uprobe(uprobe);
+	if (!ri->uprobe)
+		goto err_mem;
+
 	trampoline_vaddr = get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
-		goto fail;
+		goto err_uprobe;
 
 	/* drop the entries invalidated by longjmp() */
 	chained = (orig_ret_vaddr == trampoline_vaddr);
@@ -1950,12 +1956,11 @@ static void prepare_uretprobe(struct upr
 			 * attack from user-space.
 			 */
 			uprobe_warn(current, "handle tail call");
-			goto fail;
+			goto err_uprobe;
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
 
-	ri->uprobe = get_uprobe(uprobe);
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
@@ -1966,7 +1971,10 @@ static void prepare_uretprobe(struct upr
 	utask->return_instances = ri;
 
 	return;
-fail:
+
+err_uprobe:
+	uprobe_put(ri->uprobe);
+err_mem:
 	kfree(ri);
 }
 
@@ -1982,22 +1990,31 @@ pre_ssout(struct uprobe *uprobe, struct
 	if (!utask)
 		return -ENOMEM;
 
+	utask->active_uprobe = try_get_uprobe(uprobe);
+	if (!utask->active_uprobe)
+		return -ESRCH;
+
 	xol_vaddr = xol_get_insn_slot(uprobe);
-	if (!xol_vaddr)
-		return -ENOMEM;
+	if (!xol_vaddr) {
+		err = -ENOMEM;
+		goto err_uprobe;
+	}
 
 	utask->xol_vaddr = xol_vaddr;
 	utask->vaddr = bp_vaddr;
 
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
-	if (unlikely(err)) {
-		xol_free_insn_slot(current);
-		return err;
-	}
+	if (unlikely(err))
+		goto err_xol;
 
-	utask->active_uprobe = uprobe;
 	utask->state = UTASK_SSTEP;
 	return 0;
+
+err_xol:
+	xol_free_insn_slot(current);
+err_uprobe:
+	put_uprobe(utask->active_uprobe);
+	return err;
 }
 
 /*
@@ -2128,7 +2145,7 @@ static void handler_chain(struct uprobe
 	bool had_handler = false;
 	unsigned int seq;
 
-	guard(srcu)(&uprobes_srcu);
+	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
 
 	seq = raw_read_seqcount_begin(&uprobe->register_seq);
 
@@ -2276,6 +2293,8 @@ static void handle_swbp(struct pt_regs *
 	if (bp_vaddr == get_trampoline_vaddr())
 		return handle_trampoline(regs);
 
+	guard(srcu)(&uprobes_srcu);
+
 	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
 	if (!uprobe) {
 		if (is_swbp > 0) {
@@ -2304,7 +2323,7 @@ static void handle_swbp(struct pt_regs *
 	 * new and not-yet-analyzed uprobe at the same address, restart.
 	 */
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
-		goto out;
+		return;
 
 	/*
 	 * Pairs with the smp_wmb() in prepare_uprobe().
@@ -2317,22 +2336,17 @@ static void handle_swbp(struct pt_regs *
 
 	/* Tracing handlers use ->utask to communicate with fetch methods */
 	if (!get_utask())
-		goto out;
+		return;
 
 	if (arch_uprobe_ignore(&uprobe->arch, regs))
-		goto out;
+		return;
 
 	handler_chain(uprobe, regs);
 
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
-		goto out;
-
-	if (!pre_ssout(uprobe, regs, bp_vaddr))
 		return;
 
-	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
-out:
-	put_uprobe(uprobe);
+	pre_ssout(uprobe, regs, bp_vaddr);
 }
 
 /*


