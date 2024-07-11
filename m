Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90515A874;
	Thu, 11 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696050; cv=none; b=lA3a6RL2A2p/hppTrGcnWG5srawKTGIB6zbjwFh6BXOcil3Cl1nS78DniKOgzSCN9z1n/Xv89ASpsxHdAEzCQHSjt4cs3drmVKRmJvmd41nwuiJ3fqz0aaGrwd5R4knb3fTp1D7KMAClDsjibW4f0ajsweqO9hixmTWnpDiV/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696050; c=relaxed/simple;
	bh=namzImpKkAE0SeDauxvgo7e0qpH+mTqxwz/WBAvffQw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZEItV1K+XTJHl5zqLY8VVA1sbuiViadYboaXI3fEm9TBpTa36H7ux+jQk7Zb64uYrxIK93RqfJ/CKTfNl5l8zi2NJH889IuUDdoGRSkWOHMwJK8qRSoF+pVeq6qr/wCtEOyhzF0iyiTLO6fN1TC++GQkGkg9OoMSrOKIPqzIkCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j9RYO7cl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j9RYO7cl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=6enVwtxrhKY9z473ycfT5rwTE1B57qqsh+H+nST3cXo=; b=j9RYO7clZB4u3MSfWuo6QarfqL
	g3fesYOQpUjOrvUFPJSaLKFf3CoX9IcSzasNr3plfgpWx33Tu87SOV3mtZR8drNmygV0azoTNQk3U
	o/krgOwILVlvsXGUAUrWnpX0omF1MKpcbTCCy92kiJyf3AZYG0JEMO7KF/yDSmih9y/bfMEyt2XOh
	4rmL/+GlqJtbPYMBGpyJqCU510Avjaz8RXDt2xW41+2PnPpzEMbSD1eB40M9J3v/UNM4Q/gkaQ/Be
	gJ811YzpFRsvZMOW8MfIZ1i90lMDBJcEv4bbdVEt10VuoqOBnAmZND8ksrP7Vjb+1phnH1PQIwRr9
	/fxd45Dw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRrdz-0000000Ax6R-22mg;
	Thu, 11 Jul 2024 11:07:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C1463302182; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110400.635302571@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:39 +0200
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
Subject: [PATCH v2 04/11] perf/uprobe: RCU-ify find_uprobe()
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With handle_swbp() triggering concurrently on (all) CPUs, tree_lock
becomes a bottleneck. Avoid treelock by doing RCU lookups of the
uprobe.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   49 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -40,6 +40,7 @@ static struct rb_root uprobes_tree = RB_
 #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
 
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
+static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
 
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
@@ -54,6 +55,7 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem)
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
 	refcount_t		ref;
+	struct rcu_head		rcu;
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
 	struct list_head	pending_list;
@@ -587,12 +589,25 @@ set_orig_insn(struct arch_uprobe *auprob
 			*(uprobe_opcode_t *)&auprobe->insn);
 }
 
+static struct uprobe *try_get_uprobe(struct uprobe *uprobe)
+{
+	if (refcount_inc_not_zero(&uprobe->ref))
+		return uprobe;
+	return NULL;
+}
+
 static struct uprobe *get_uprobe(struct uprobe *uprobe)
 {
 	refcount_inc(&uprobe->ref);
 	return uprobe;
 }
 
+static void uprobe_free_rcu(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+	kfree(uprobe);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
 	if (refcount_dec_and_test(&uprobe->ref)) {
@@ -604,7 +619,7 @@ static void put_uprobe(struct uprobe *up
 		mutex_lock(&delayed_uprobe_lock);
 		delayed_uprobe_remove(uprobe, NULL);
 		mutex_unlock(&delayed_uprobe_lock);
-		kfree(uprobe);
+		call_rcu(&uprobe->rcu, uprobe_free_rcu);
 	}
 }
 
@@ -653,10 +668,10 @@ static struct uprobe *__find_uprobe(stru
 		.inode = inode,
 		.offset = offset,
 	};
-	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
+	struct rb_node *node = rb_find_rcu(&key, &uprobes_tree, __uprobe_cmp_key);
 
 	if (node)
-		return get_uprobe(__node_2_uprobe(node));
+		return try_get_uprobe(__node_2_uprobe(node));
 
 	return NULL;
 }
@@ -667,20 +682,32 @@ static struct uprobe *__find_uprobe(stru
  */
 static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
 {
-	struct uprobe *uprobe;
+	unsigned int seq;
 
-	read_lock(&uprobes_treelock);
-	uprobe = __find_uprobe(inode, offset);
-	read_unlock(&uprobes_treelock);
+	guard(rcu)();
 
-	return uprobe;
+	do {
+		seq = read_seqcount_begin(&uprobes_seqcount);
+		struct uprobe *uprobe = __find_uprobe(inode, offset);
+		if (uprobe) {
+			/*
+			 * Lockless RB-tree lookups are prone to false-negatives.
+			 * If they find something, it's good. If they do not find,
+			 * it needs to be validated.
+			 */
+			return uprobe;
+		}
+	} while (read_seqcount_retry(&uprobes_seqcount, seq));
+
+	/* Really didn't find anything. */
+	return NULL;
 }
 
 static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 {
 	struct rb_node *node;
 
-	node = rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
+	node = rb_find_add_rcu(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
 	if (node)
 		return get_uprobe(__node_2_uprobe(node));
 
@@ -702,7 +729,9 @@ static struct uprobe *insert_uprobe(stru
 	struct uprobe *u;
 
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	u = __insert_uprobe(uprobe);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
 
 	return u;
@@ -936,7 +965,9 @@ static void delete_uprobe(struct uprobe
 		return;
 
 	write_lock(&uprobes_treelock);
+	write_seqcount_begin(&uprobes_seqcount);
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
+	write_seqcount_end(&uprobes_seqcount);
 	write_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
 	put_uprobe(uprobe);


