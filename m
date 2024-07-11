Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885C15A868;
	Thu, 11 Jul 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696051; cv=none; b=o6DPjqel2iFltOR4UeN1w1tvjzBHU1GQYbbuihfuK+cINYUa1vme5VyCvPGh2npO6q7Xg6qlbpvgbunDIj94Qm0Ltmc2sXNSaeJEyGe9brcNfzGQFaZFkuGb6RUydE8B4MZjGTFrjvAqJqzpunJqYKymIjTTFHzdkL7c+XVqCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696051; c=relaxed/simple;
	bh=eKrnWxEQ7mJat9bK7hztaGayVd7Ezz7aRwEv9LVNEhs=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KkiKEW2fdwVRPF3uRf2WCJXpK5/mtMuBifZrgwWDRii0wd+V2ZMY1iezOzjjfpxt84UCkNMlzjt1TZekufVPZoPnv4290bfcNFudfIsGWqxtEJ10F0kANoFx6gmbCbz6U9IWIdPnxG8nZAxtgi4OrK4cSPaDVMEXvqoHaJJ8hhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HVg9SoDa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HVg9SoDa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=oJyO4fVmvgndm2CNyTnHKfKK4j72bWwI2b0ZVWus99U=; b=HVg9SoDaQDbBa8tLIo2j1Pg8a3
	5ubXeE/VRU/5VS9Q2vui4H2BPsgTJQKcYaicHUfsR2H0SiNSHNkPxhCVyTvQrBmKcmRfhVJig2iTe
	C93fvhouWLYLeW0Irm0AzIWa3AIi8RY/H1etH//g/rAhTecwdHlr4B2YhjmlklCkswdRsSWEkOeaY
	Djl0K5eSJtZTPM7VJFPtwT8HQyyh0Ss5kJy9hW3EnhW42xffRezLcr/s1De9xtBnfcO4jzkXyi/ew
	n7nh5PrGXrqJR2pxe4UgDuV2PAIB0IcWVttmwj6f9OL54pa9xsMWq3iHyk5IsXsoBYIw0F8IVzTAB
	eyOTt4/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRre0-0000000Ax6a-0kbN;
	Thu, 11 Jul 2024 11:07:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DEAAB30614E; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110401.412779774@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:46 +0200
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
Subject: [PATCH v2 11/11] perf/uprobe: Add uretprobe timer
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to put a bound on the uretprobe_srcu critical section, add a
timer to uprobe_task. Upon every RI added or removed the timer is
pushed forward to now + 1s. If the timer were ever to fire, it would
convert the SRCU 'reference' to a refcount reference if possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/uprobes.h |    8 +++++
 kernel/events/uprobes.c |   67 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 69 insertions(+), 6 deletions(-)

--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -15,6 +15,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/timer.h>
 
 struct vm_area_struct;
 struct mm_struct;
@@ -79,6 +80,10 @@ struct uprobe_task {
 	struct return_instance		*return_instances;
 	unsigned int			depth;
 	unsigned int			active_srcu_idx;
+
+	struct timer_list		ri_timer;
+	struct callback_head		ri_task_work;
+	struct task_struct		*task;
 };
 
 struct return_instance {
@@ -86,7 +91,8 @@ struct return_instance {
 	unsigned long		func;
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
-	bool			chained;	/* true, if instance is nested */
+	u8			chained;	/* true, if instance is nested */
+	u8			has_ref;
 	int			srcu_idx;
 
 	struct return_instance	*next;		/* keep as stack */
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1761,7 +1761,12 @@ unsigned long uprobe_get_trap_addr(struc
 static struct return_instance *free_ret_instance(struct return_instance *ri)
 {
 	struct return_instance *next = ri->next;
-	__srcu_read_unlock(&uretprobes_srcu, ri->srcu_idx);
+	if (ri->uprobe) {
+		if (ri->has_ref)
+			put_uprobe(ri->uprobe);
+		else
+			__srcu_read_unlock(&uretprobes_srcu, ri->srcu_idx);
+	}
 	kfree(ri);
 	return next;
 }
@@ -1785,11 +1790,48 @@ void uprobe_free_utask(struct task_struc
 	while (ri)
 		ri = free_ret_instance(ri);
 
+	timer_delete_sync(&utask->ri_timer);
+	task_work_cancel(utask->task, &utask->ri_task_work);
 	xol_free_insn_slot(t);
 	kfree(utask);
 	t->utask = NULL;
 }
 
+static void return_instance_task_work(struct callback_head *head)
+{
+	struct uprobe_task *utask = container_of(head, struct uprobe_task, ri_task_work);
+	struct return_instance *ri;
+
+	for (ri = utask->return_instances; ri; ri = ri->next) {
+		if (!ri->uprobe)
+			continue;
+		if (ri->has_ref)
+			continue;
+		if (refcount_inc_not_zero(&ri->uprobe->ref))
+			ri->has_ref = true;
+		else
+			ri->uprobe = NULL;
+		__srcu_read_unlock(&uretprobes_srcu, ri->srcu_idx);
+	}
+}
+
+static void return_instance_timer(struct timer_list *timer)
+{
+	struct uprobe_task *utask = container_of(timer, struct uprobe_task, ri_timer);
+	task_work_add(utask->task, &utask->ri_task_work, TWA_SIGNAL);
+}
+
+static struct uprobe_task *alloc_utask(struct task_struct *task)
+{
+	struct uprobe_task *utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+	if (!utask)
+		return NULL;
+	timer_setup(&utask->ri_timer, return_instance_timer, 0);
+	init_task_work(&utask->ri_task_work, return_instance_task_work);
+	utask->task = task;
+	return utask;
+}
+
 /*
  * Allocate a uprobe_task object for the task if necessary.
  * Called when the thread hits a breakpoint.
@@ -1801,7 +1843,7 @@ void uprobe_free_utask(struct task_struc
 static struct uprobe_task *get_utask(void)
 {
 	if (!current->utask)
-		current->utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+		current->utask = alloc_utask(current);
 	return current->utask;
 }
 
@@ -1810,7 +1852,7 @@ static int dup_utask(struct task_struct
 	struct uprobe_task *n_utask;
 	struct return_instance **p, *o, *n;
 
-	n_utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+	n_utask = alloc_utask(t);
 	if (!n_utask)
 		return -ENOMEM;
 	t->utask = n_utask;
@@ -1822,13 +1864,20 @@ static int dup_utask(struct task_struct
 			return -ENOMEM;
 
 		*n = *o;
-		__srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
+		if (n->uprobe) {
+			if (n->has_ref)
+				get_uprobe(n->uprobe);
+			else
+				__srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
+		}
 		n->next = NULL;
 
 		*p = n;
 		p = &n->next;
 		n_utask->depth++;
 	}
+	if (n_utask->return_instances)
+		mod_timer(&n_utask->ri_timer, jiffies + HZ);
 
 	return 0;
 }
@@ -1967,6 +2016,7 @@ static void prepare_uretprobe(struct upr
 
 	ri->srcu_idx = __srcu_read_lock(&uretprobes_srcu);
 	ri->uprobe = uprobe;
+	ri->has_ref = 0;
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
@@ -1976,6 +2026,8 @@ static void prepare_uretprobe(struct upr
 	ri->next = utask->return_instances;
 	utask->return_instances = ri;
 
+	mod_timer(&utask->ri_timer, jiffies + HZ);
+
 	return;
 
 err_mem:
@@ -2204,6 +2256,9 @@ handle_uretprobe_chain(struct return_ins
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
 
+	if (!uprobe)
+		return;
+
 	guard(srcu)(&uprobes_srcu);
 
 	for_each_consumer_rcu(uc, uprobe->consumers) {
@@ -2250,8 +2305,10 @@ static void handle_trampoline(struct pt_
 
 		instruction_pointer_set(regs, ri->orig_ret_vaddr);
 		do {
-			if (valid)
+			if (valid) {
 				handle_uretprobe_chain(ri, regs);
+				mod_timer(&utask->ri_timer, jiffies + HZ);
+			}
 			ri = free_ret_instance(ri);
 			utask->depth--;
 		} while (ri != next);


