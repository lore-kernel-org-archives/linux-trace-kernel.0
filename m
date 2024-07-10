Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEB1953BB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629204; cv=none; b=ohZZizvUOaRbPDgKmzFLtIVJczNccdtmF2jwVgEF/M/LNdUmS6Fsm6obZLBt33ZwcV5ZiQ2mGXxKm36+/Uf4FWZREOLauc872XS1cVHHQ1fBrboTT4WI9TAHpvvNLEQqRuEk9WOkYCECe1ZD5FLIwIcji6yBOJXC246TRslzZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629204; c=relaxed/simple;
	bh=xSn6aWn2VSQKHTpQ2P/SzpL4K8+RF4WT6iLKwi2Jo88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ1yY3KtS5bWy2CHPkM+A2wL4qMRLktCX6z71ZIpLxydGYMasSsJI/m3wAEzO31Vqmdy/qWmZuuGgaat5+nl1P+jVNRNJ0U49Gkps+T+MI1maRpejmsLGBnpPIIsKBB6m63gz8F8sQknd6c8tz7cj6Zo1ejKmRw6YLanYgP/hO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4hfGr+j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4hfGr+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720629201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbKCCwZUAG8+N7TuFtLLFIVTbn6KobI4S7EYoLAaXBE=;
	b=V4hfGr+jideQtkqUDVfJ2Of+Pvbuw+U2cnl1XQ4zYS3ANU2ifAiL0kv+lO3kxEDiXVp6+T
	E0sLL+CKWriCq5kUincHdv95N0AYecgwtPYDdsv1wgUoqXGdHRUaCHLRptU2EMhkNLdhZR
	85q9m77v7xkROLwkmswV7BbvtP7t380=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-nzynZEw5OtCFZTzOKy9FUw-1; Wed,
 10 Jul 2024 12:33:17 -0400
X-MC-Unique: nzynZEw5OtCFZTzOKy9FUw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C689196CDEF;
	Wed, 10 Jul 2024 16:33:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3EF321955E70;
	Wed, 10 Jul 2024 16:33:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 18:31:38 +0200 (CEST)
Date: Wed, 10 Jul 2024 18:31:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: clm@meta.com, jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe *
Message-ID: <20240710163133.GD13298@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710163022.GA13298@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This way uprobe_unregister() and uprobe_apply() do not need find_uprobe() +
put_uprobe(). And to me this change simplifies the code a bit.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/uprobes.h     | 14 ++++++------
 kernel/events/uprobes.c     | 45 ++++++++++++-------------------------
 kernel/trace/bpf_trace.c    | 12 +++++-----
 kernel/trace/trace_uprobe.c | 28 +++++++++++------------
 4 files changed, 41 insertions(+), 58 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index aa89a8b67039..399509befcf4 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -110,9 +110,9 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
-extern int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
-extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
+extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
+extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -147,18 +147,18 @@ static inline void uprobes_init(void)
 
 #define uprobe_get_trap_addr(regs)	instruction_pointer(regs)
 
-static inline int
+static inline struct uprobe *
 uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
 {
-	return -ENOSYS;
+	return ERR_PTR(-ENOSYS);
 }
 static inline int
-uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
+uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
 {
 	return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e5b7c6239970..dba41403d7b8 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1100,22 +1100,15 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 
 /*
  * uprobe_unregister - unregister an already registered probe.
- * @inode: the file in which the probe has to be removed.
+ * @uprobe: uprobe to remove
  * @offset: offset from the start of the file.
  * @uc: identify which probe if multiple probes are colocated.
  */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
-	struct uprobe *uprobe;
-
-	uprobe = find_uprobe(inode, offset);
-	if (WARN_ON(!uprobe))
-		return;
-
 	down_write(&uprobe->register_rwsem);
 	__uprobe_unregister(uprobe, uc);
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
@@ -1133,41 +1126,39 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
  * refcount is released when the last @uc for the @uprobe
  * unregisters. Caller of uprobe_register() is required to keep @inode
  * (and the containing mount) referenced.
- *
- * Return errno if it cannot successully install probes
- * else return 0 (success)
  */
-int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
-		    struct uprobe_consumer *uc)
+struct uprobe *uprobe_register(struct inode *inode,
+				loff_t offset, loff_t ref_ctr_offset,
+				struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
 
 	/* Uprobe must have at least one set consumer */
 	if (!uc->handler && !uc->ret_handler)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
 	if (!inode->i_mapping->a_ops->read_folio &&
 	    !shmem_mapping(inode->i_mapping))
-		return -EIO;
+		return ERR_PTR(-EIO);
 	/* Racy, just to catch the obvious mistakes */
 	if (offset > i_size_read(inode))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * This ensures that copy_from_page(), copy_to_page() and
 	 * __update_ref_ctr() can't cross page boundary.
 	 */
 	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
  retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (IS_ERR(uprobe))
-		return PTR_ERR(uprobe);
+		return uprobe;
 
 	/*
 	 * We can race with uprobe_unregister()->delete_uprobe().
@@ -1186,35 +1177,27 @@ int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
 
 	if (unlikely(ret == -EAGAIN))
 		goto retry;
-	return ret;
+
+	return ret ? ERR_PTR(ret) : uprobe;
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
 /*
  * uprobe_apply - unregister an already registered probe.
- * @inode: the file in which the probe has to be removed.
- * @offset: offset from the start of the file.
  * @uc: consumer which wants to add more or remove some breakpoints
  * @add: add or remove the breakpoints
  */
-int uprobe_apply(struct inode *inode, loff_t offset,
-			struct uprobe_consumer *uc, bool add)
+int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
 {
-	struct uprobe *uprobe;
 	struct uprobe_consumer *con;
 	int ret = -ENOENT;
 
-	uprobe = find_uprobe(inode, offset);
-	if (WARN_ON(!uprobe))
-		return ret;
-
 	down_write(&uprobe->register_rwsem);
 	for (con = uprobe->consumers; con && con != uc ; con = con->next)
 		;
 	if (con)
 		ret = register_for_each_vma(uprobe, add ? uc : NULL);
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
 
 	return ret;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 467f358c8ce7..7571811127a2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3157,6 +3157,7 @@ struct bpf_uprobe {
 	loff_t offset;
 	unsigned long ref_ctr_offset;
 	u64 cookie;
+	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
 };
 
@@ -3180,10 +3181,8 @@ static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
 {
 	u32 i;
 
-	for (i = 0; i < cnt; i++) {
-		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
-				  &uprobes[i].consumer);
-	}
+	for (i = 0; i < cnt; i++)
+		uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer);
 }
 
 static void bpf_uprobe_multi_link_release(struct bpf_link *link)
@@ -3477,11 +3476,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		      &bpf_uprobe_multi_link_lops, prog);
 
 	for (i = 0; i < cnt; i++) {
-		err = uprobe_register(d_real_inode(link->path.dentry),
+		uprobes[i].uprobe = uprobe_register(d_real_inode(link->path.dentry),
 					     uprobes[i].offset,
 					     uprobes[i].ref_ctr_offset,
 					     &uprobes[i].consumer);
-		if (err) {
+		if (IS_ERR(uprobes[i].uprobe)) {
+			err = PTR_ERR(uprobes[i].uprobe);
 			bpf_uprobe_unregister(&path, uprobes, i);
 			goto error_free;
 		}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 78a5c40e885a..2872955da202 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -58,8 +58,8 @@ struct trace_uprobe {
 	struct dyn_event		devent;
 	struct uprobe_consumer		consumer;
 	struct path			path;
-	struct inode			*inode;
 	char				*filename;
+	struct uprobe			*uprobe;
 	unsigned long			offset;
 	unsigned long			ref_ctr_offset;
 	unsigned long			nhit;
@@ -1084,17 +1084,17 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 
 static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 {
-	int ret;
+	struct inode *inode = d_real_inode(tu->path.dentry);
+	struct uprobe *uprobe;
 
 	tu->consumer.filter = filter;
-	tu->inode = d_real_inode(tu->path.dentry);
-
-	ret = uprobe_register(tu->inode, tu->offset, tu->ref_ctr_offset,
-			      &tu->consumer);
-	if (ret)
-		tu->inode = NULL;
+	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset,
+				&tu->consumer);
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
 
-	return ret;
+	tu->uprobe = uprobe;
+	return 0;
 }
 
 static void __probe_event_disable(struct trace_probe *tp)
@@ -1105,11 +1105,11 @@ static void __probe_event_disable(struct trace_probe *tp)
 	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
 
 	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
-		if (!tu->inode)
+		if (!tu->uprobe)
 			continue;
 
-		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
-		tu->inode = NULL;
+		uprobe_unregister(tu->uprobe, &tu->consumer);
+		tu->uprobe = NULL;
 	}
 }
 
@@ -1306,7 +1306,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
 		return 0;
 
 	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
-		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
+		ret = uprobe_apply(tu->uprobe, &tu->consumer, false);
 		if (ret)
 			break;
 	}
@@ -1330,7 +1330,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 		return 0;
 
 	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
-		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
+		err = uprobe_apply(tu->uprobe, &tu->consumer, true);
 		if (err) {
 			uprobe_perf_close(call, event);
 			break;
-- 
2.25.1.362.g51ebf55


