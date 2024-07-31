Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22A1A7206
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413429; cv=none; b=nBSCH9JNBGaAfndaMjDmT3vzSrCO5BehzwtMAUgZz/p1TmRTamJrksIFzReimcLCZX5AD5d56061e1plDv2p73z7FYhQ02gqQergd30fyJ6zOVm00M43EI7V5BoRSS5EEf/wnKV6bo/HeiE9qCcO0hS7Wgm8SGORHTzcy7GUFAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413429; c=relaxed/simple;
	bh=glgPFwmR31L8rIn/sadIkIZtyqWXy2j8TAYzrwb2cC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsHtjNXC4PwQlkTbBG/u/wIi5pHl9cF803dX5lNLhAcq4iQpa7D5CroQ+5yGbdcuQovowTFBn9RGRf6FaiQxxtGzLQ51GftnF3tZdatyRMgJXYnMjo1+onhYOnnJp1qgB3F9xJcMEAWpyiXcaTyNndQYw4//N9VW2qmY1e7gZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLdC4cLF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLdC4cLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722413426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6QtFFxRVfRNy+RE/1vwcURKkg2d+dBiPjiEmg9auM+0=;
	b=hLdC4cLFB7NX+3W0IyAiFqCuLq3bhgR/KcSoqXRbKljWn50zaxc8F7SMNCb1CbhFcxEu6U
	7b/qTAv906g3OKbbuzlVNVSDVZcHqKAF89TwEzPHutBWRy3iaYmoI0aV8t0suNJxsIhnVE
	+aaEiFy9g8Ss93BSUhUTERsUTSjGym0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-dkkBZ4oXOTaftdMxBYuApQ-1; Wed,
 31 Jul 2024 04:10:18 -0400
X-MC-Unique: dkkBZ4oXOTaftdMxBYuApQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCAB119560BF;
	Wed, 31 Jul 2024 08:10:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.143])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C199B19560AA;
	Wed, 31 Jul 2024 08:10:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 10:10:16 +0200 (CEST)
Date: Wed, 31 Jul 2024 10:10:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] uprobes: kill uprobe_register_refctr()
Message-ID: <20240731081012.GA13690@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134530.GA12318@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729134530.GA12318@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

It doesn't make any sense to have 2 versions of _register(). Note that
trace_uprobe_enable(), the only user of uprobe_register(), doesn't need
to check tu->ref_ctr_offset to decide which one should be used, it could
safely pass ref_ctr_offset == 0 to uprobe_register_refctr().

Add this argument to uprobe_register(), update the callers, and kill
uprobe_register_refctr().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h                       |  9 ++-----
 kernel/events/uprobes.c                       | 24 +++++--------------
 kernel/trace/bpf_trace.c                      |  8 +++----
 kernel/trace/trace_uprobe.c                   |  7 +-----
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  4 ++--
 5 files changed, 15 insertions(+), 37 deletions(-)

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
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index fd28c1157bd3..86babdd6f850 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -458,8 +458,8 @@ static int testmod_register_uprobe(loff_t offset)
 	if (err)
 		goto out;
 
-	err = uprobe_register_refctr(d_real_inode(uprobe.path.dentry),
-				     offset, 0, &uprobe.consumer);
+	err = uprobe_register(d_real_inode(uprobe.path.dentry),
+			      offset, 0, &uprobe.consumer);
 	if (err)
 		path_put(&uprobe.path);
 	else
-- 
2.25.1.362.g51ebf55


