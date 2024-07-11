Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F515B0E6;
	Thu, 11 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696050; cv=none; b=rntd83IU0rTTd9xqmwuarZ1insESjK3dvzVYduuu4o+oBdl7s1ydosGo6OpMx0mcv6tQhvl6sFKrrYZAdVL+GrrBs/Aq9pC7uv3eqSSRGPDc906y0WMJDWqotlMLgCFNK6+P6Dy+vSfS2C4et6bMzPolApe0RZS/SNhR2qJgbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696050; c=relaxed/simple;
	bh=V4VGBP/Aj8yPyI/IWKopehT3xnqmyYE9lEkZlZ4eNbc=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CxQRaPL7NqtCOTl5cTIh8978Wd++3wuWyZx5LegPT9q5qyDFMBPZg5EKeIvtibLhtMF75j3+J2bSJpFy06W+m4HEqe0ATFvjiCfWZkAGE6frv+vvA0PlLJl3mZwfhlZdGq9pS7wLmDRgdP6D4/ivI77scr5mLxtDgCW7LkgMQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cBTbgars; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cBTbgars"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Ny8uqMTS6OmqyT/DzZEZHx/QBmd5E9Ugn7LCsaDF+b4=; b=cBTbgars7f8Y40nO86kVz5kgFX
	AgtvFMckaBT6iy89IDDORTrYKjmhfn+EZfVb6ROcfoC6nGC4uEsFavIPIuP8/iuyEIRpGYIqelkdN
	Bl+dQU0eIW5wxRSaBvCUBJPx0XvXLsTLFg4jHBSzPgeQNXdf/CYIdj0F7ESkrbp1kItLagN4w8viL
	bkO4we6zguzEkuaTTI4xzzU7OHlNklE92xbyqjAFdtuyxpm1zDmbVmLH21QlGLeTpfPGDvnTYv6IU
	BL260nUD937hh2kcSb/v3JuKxIgewiKoudgsJ0Spz7YVlW5n5Sg8o8mHmaRODFV5F7rak5MjDYUw+
	gKaQ4LqA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRre0-000000015VV-0GeD;
	Thu, 11 Jul 2024 11:07:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CA50A302440; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110400.880800153@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:41 +0200
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
Subject: [PATCH v2 06/11] perf/uprobe: SRCU-ify uprobe->consumer list
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With handle_swbp() hitting concurrently on (all) CPUs the
uprobe->register_rwsem can get very contended. Add an SRCU instance to
cover the consumer list and consumer lifetime.

Since the consumer are externally embedded structures, unregister will
have to suffer a synchronize_srcu().

A notably complication is the UPROBE_HANDLER_REMOVE logic which can
race against uprobe_register() such that it might want to remove a
freshly installer handler that didn't get called. In order to close
this hole, a seqcount is added. With that, the removal path can tell
if anything changed and bail out of the removal.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   60 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 10 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -26,6 +26,7 @@
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
+#include <linux/srcu.h>
 
 #include <linux/uprobes.h>
 
@@ -49,6 +50,11 @@ static struct mutex uprobes_mmap_mutex[U
 
 DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 
+/*
+ * Covers uprobe->consumers lifetime.
+ */
+DEFINE_STATIC_SRCU(uprobes_srcu);
+
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
@@ -57,6 +63,7 @@ struct uprobe {
 	refcount_t		ref;
 	struct rcu_head		rcu;
 	struct rw_semaphore	register_rwsem;
+	seqcount_t		register_seq;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
 	struct uprobe_consumer	*consumers;
@@ -760,6 +767,7 @@ static struct uprobe *alloc_uprobe(struc
 	uprobe->offset = offset;
 	uprobe->ref_ctr_offset = ref_ctr_offset;
 	init_rwsem(&uprobe->register_rwsem);
+	seqcount_init(&uprobe->register_seq);
 	init_rwsem(&uprobe->consumer_rwsem);
 
 	/* add to uprobes_tree, sorted on inode:offset */
@@ -782,8 +790,8 @@ static struct uprobe *alloc_uprobe(struc
 static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	down_write(&uprobe->consumer_rwsem);
-	uc->next = uprobe->consumers;
-	uprobe->consumers = uc;
+	WRITE_ONCE(uc->next, uprobe->consumers);
+	rcu_assign_pointer(uprobe->consumers, uc);
 	up_write(&uprobe->consumer_rwsem);
 }
 
@@ -800,7 +808,7 @@ static bool consumer_del(struct uprobe *
 	down_write(&uprobe->consumer_rwsem);
 	for (con = &uprobe->consumers; *con; con = &(*con)->next) {
 		if (*con == uc) {
-			*con = uc->next;
+			WRITE_ONCE(*con, uc->next);
 			ret = true;
 			break;
 		}
@@ -1139,9 +1147,13 @@ void uprobe_unregister(struct inode *ino
 		return;
 
 	down_write(&uprobe->register_rwsem);
+	raw_write_seqcount_begin(&uprobe->register_seq);
 	__uprobe_unregister(uprobe, uc);
+	raw_write_seqcount_end(&uprobe->register_seq);
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
+
+	synchronize_srcu(&uprobes_srcu);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
@@ -1204,10 +1216,12 @@ static int __uprobe_register(struct inod
 	down_write(&uprobe->register_rwsem);
 	ret = -EAGAIN;
 	if (likely(uprobe_is_active(uprobe))) {
+		raw_write_seqcount_begin(&uprobe->register_seq);
 		consumer_add(uprobe, uc);
 		ret = register_for_each_vma(uprobe, uc);
 		if (ret)
 			__uprobe_unregister(uprobe, uc);
+		raw_write_seqcount_end(&uprobe->register_seq);
 	}
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
@@ -1250,10 +1264,12 @@ int uprobe_apply(struct inode *inode, lo
 		return ret;
 
 	down_write(&uprobe->register_rwsem);
+	raw_write_seqcount_begin(&uprobe->register_seq);
 	for (con = uprobe->consumers; con && con != uc ; con = con->next)
 		;
 	if (con)
 		ret = register_for_each_vma(uprobe, add ? uc : NULL);
+	raw_write_seqcount_end(&uprobe->register_seq);
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 
@@ -2096,15 +2112,23 @@ static struct uprobe *find_active_uprobe
 	return uprobe;
 }
 
+#define for_each_consumer_rcu(pos, head) \
+	for (pos = rcu_dereference_raw(head); pos; \
+	     pos = rcu_dereference_raw(pos->next))
+
 static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 {
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
 	bool had_handler = false;
+	unsigned int seq;
 
-	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	guard(srcu)(&uprobes_srcu);
+
+	seq = raw_read_seqcount_begin(&uprobe->register_seq);
+
+	for_each_consumer_rcu(uc, uprobe->consumers) {
 		int rc = 0;
 
 		if (uc->handler) {
@@ -2134,9 +2158,25 @@ static void handler_chain(struct uprobe
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
 
-	if (remove)
+	if (remove) {
+		/*
+		 * Removing uprobes is a slow path, after all, the more probes
+		 * you remove, the less probe hits you get.
+		 *
+		 * This needs to serialize against uprobe_register(), such that
+		 * if the above RCU iteration missed a new handler that
+		 * would've liked to keep the probe, we don't go uninstall the
+		 * probe after it already ran register_for_each_vma().
+		 *
+		 * The rwsem ensures exclusivity against uprobe_register()
+		 * while the seqcount will avoid the removal if anything has
+		 * changed since we started.
+		 */
+		guard(rwsem_read)(&uprobe->register_rwsem);
+		if (read_seqcount_retry(&uprobe->register_seq, seq))
+			return;
 		unapply_uprobe(uprobe, current->mm);
-	up_read(&uprobe->register_rwsem);
+	}
 }
 
 static void
@@ -2145,12 +2185,12 @@ handle_uretprobe_chain(struct return_ins
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
 
-	down_read(&uprobe->register_rwsem);
-	for (uc = uprobe->consumers; uc; uc = uc->next) {
+	guard(srcu)(&uprobes_srcu);
+
+	for_each_consumer_rcu(uc, uprobe->consumers) {
 		if (uc->ret_handler)
 			uc->ret_handler(uc, ri->func, regs);
 	}
-	up_read(&uprobe->register_rwsem);
 }
 
 static struct return_instance *find_next_ret_chain(struct return_instance *ri)


