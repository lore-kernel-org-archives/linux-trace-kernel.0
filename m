Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63F15530F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260740; cv=none; b=jEyc/lc8j23E2zYKvsV9RfJS1AJhHD8OYFZXolaDMwqTR/TIcIz1n9SwrdwR/I/8i0jiUmSBxoQzcLoO9m5JdWZntQsBjBG4PN+gYG7ffA8E5xytQALDiK+yy07laynS6d9voTHnLkLXc2goIMyIf9001lxkG+rxHPUgnwjQ4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260740; c=relaxed/simple;
	bh=5Zex47x9Yo3uhlo4IPZClngehgjxBTuek1XwGUHYWzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jRUK65z+kuDqVDfhtUoGhOFZ1yZuHyxOG1zd0lcNXWiTA3f3nFa//WYsJsuysDdyDgr77pEGfx5+EPwIyiHbzAwJcni+oZNPDdznFu1coK5UPZA4/V6X1wuaMw7zRrzy+mVHy1V19BjtdEsjQFtEN8kFR2gxf5UAUi9Zd+vEPQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpbqLzPH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpbqLzPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722260738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=GljItekCZbgj9EI2Gjp6phtbEQZhx+nhGuyR2X5v23M=;
	b=TpbqLzPHlHPdYfsT8+HnVdkh+Qw+TAMduS56yOOVZOwx/5XocNlCNpfB5f4CSj3GCl3K8i
	KuYKEksjTRyQhSLGUN/Hnysh7OmOw+ZuAnGlQt3tdzIeeWFthu88f6S2iMyPhbW7zPbj9u
	7u+yW6CZEvuPaQIJmdXcLb55vCQwric=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-TFltjkw1N3-4hsJX13xbjA-1; Mon,
 29 Jul 2024 09:45:35 -0400
X-MC-Unique: TFltjkw1N3-4hsJX13xbjA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 201EA1955D50;
	Mon, 29 Jul 2024 13:45:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.232])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1EB7B300018D;
	Mon, 29 Jul 2024 13:45:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Jul 2024 15:45:34 +0200 (CEST)
Date: Mon, 29 Jul 2024 15:45:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] uprobes: kill uprobe_register_refctr()
Message-ID: <20240729134530.GA12318@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729134444.GA12293@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

It doesn't make any sense to have 2 versions of _register(). Note that
trace_uprobe_enable(), the only user of uprobe_register(), doesn't need
to check tu->ref_ctr_offset to decide which one should be used, it could
safely pass ref_ctr_offset == 0 to uprobe_register_refctr().

Add this argument to uprobe_register(), update the callers, and kill
uprobe_register_refctr().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h     |  9 ++-------
 kernel/events/uprobes.c     | 24 ++++++------------------
 kernel/trace/bpf_trace.c    |  8 ++++----
 kernel/trace/trace_uprobe.c |  7 +------
 4 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b503fafb7fb3..440316fbf3c6 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -110,8 +110,7 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
-extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
-extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
+extern int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_mmap(struct vm_area_struct *vma);
@@ -152,11 +151,7 @@ static inline void uprobes_init(void)
 #define uprobe_get_trap_addr(regs)	instruction_pointer(regs)
 
 static inline int
-uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
-{
-	return -ENOSYS;
-}
-static inline int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
+uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
 {
 	return -ENOSYS;
 }
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index dfe6306a63b1..b7f40bad8abc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1121,25 +1121,26 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
 /*
- * __uprobe_register - register a probe
+ * uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
  * @offset: offset from the start of the file.
+ * @ref_ctr_offset: offset of SDT marker / reference counter
  * @uc: information on howto handle the probe..
  *
- * Apart from the access refcount, __uprobe_register() takes a creation
+ * Apart from the access refcount, uprobe_register() takes a creation
  * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
  * inserted into the rbtree (i.e first consumer for a @inode:@offset
  * tuple).  Creation refcount stops uprobe_unregister from freeing the
  * @uprobe even before the register operation is complete. Creation
  * refcount is released when the last @uc for the @uprobe
- * unregisters. Caller of __uprobe_register() is required to keep @inode
+ * unregisters. Caller of uprobe_register() is required to keep @inode
  * (and the containing mount) referenced.
  *
  * Return errno if it cannot successully install probes
  * else return 0 (success)
  */
-static int __uprobe_register(struct inode *inode, loff_t offset,
-			     loff_t ref_ctr_offset, struct uprobe_consumer *uc)
+int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
+		    struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
@@ -1189,21 +1190,8 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 		goto retry;
 	return ret;
 }
-
-int uprobe_register(struct inode *inode, loff_t offset,
-		    struct uprobe_consumer *uc)
-{
-	return __uprobe_register(inode, offset, 0, uc);
-}
 EXPORT_SYMBOL_GPL(uprobe_register);
 
-int uprobe_register_refctr(struct inode *inode, loff_t offset,
-			   loff_t ref_ctr_offset, struct uprobe_consumer *uc)
-{
-	return __uprobe_register(inode, offset, ref_ctr_offset, uc);
-}
-EXPORT_SYMBOL_GPL(uprobe_register_refctr);
-
 /*
  * uprobe_apply - unregister an already registered probe.
  * @inode: the file in which the probe has to be removed.
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..afa909e17824 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3480,10 +3480,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		      &bpf_uprobe_multi_link_lops, prog);
 
 	for (i = 0; i < cnt; i++) {
-		err = uprobe_register_refctr(d_real_inode(link->path.dentry),
-					     uprobes[i].offset,
-					     uprobes[i].ref_ctr_offset,
-					     &uprobes[i].consumer);
+		err = uprobe_register(d_real_inode(link->path.dentry),
+				      uprobes[i].offset,
+				      uprobes[i].ref_ctr_offset,
+				      &uprobes[i].consumer);
 		if (err) {
 			bpf_uprobe_unregister(&path, uprobes, i);
 			goto error_free;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c98e3b3386ba..1f590f989c1e 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1089,12 +1089,7 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 	tu->consumer.filter = filter;
 	tu->inode = d_real_inode(tu->path.dentry);
 
-	if (tu->ref_ctr_offset)
-		ret = uprobe_register_refctr(tu->inode, tu->offset,
-				tu->ref_ctr_offset, &tu->consumer);
-	else
-		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
-
+	ret = uprobe_register(tu->inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
 	if (ret)
 		tu->inode = NULL;
 
-- 
2.25.1.362.g51ebf55

