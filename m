Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E81A3BBF
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518867; cv=none; b=M/F/l4pS29w8+hyOD+RlxL7fOR5zrD4Fzx3oBMVg/eway4xozuQ5Nt2lKnnihcmMmLKAZw+pR2Tei/go31AMKqHPYWjcuVj6y9S4BgoeoUePwOLSmQzvRsGZfahjdrEiGUUEYRgLPDm73hRJOqKTSP7zFIJqwvBepKaeWGdCwVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518867; c=relaxed/simple;
	bh=71O5x5YAGJpII1BCIZlq4QX8RwKr8kK91D5R2Nx7nEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZXlE+00muedURwPYVbV0wizburBU1Eaq23Tn9hKs29b29YjWhV8wKDMaEMXPr7m267G4e6w5MNTw6u5J+RSZUIQKSZMWeHBssJ52ZEtA/BZ5XTiAIRkYEzhpzUgDV1rOqzowV3cPd5ujVpJ5kAKlBlXr4RYt4Vk3Cns0dRSn0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TPASS6vI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPASS6vI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=ioXSxtEAXvPsvMjs0eVh/THRQlAw/m8xqgMf08c5v/g=;
	b=TPASS6vIl+Znb6MLk+iOnByPClFR4jY0+IcSQCt2xXu0xj63RNDO+gYUlnEHgZWVgLNd0v
	hK84P7pAo/IuM+1ldioDKi/+yGcyDsiKGeKfZf7P97GiJD+LsYX/veFpONCJ0XimvIjYpV
	vxUFJFcsAHY+0yWlGNoYroDQGjZovQg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-RC26f5DlMfyvCaFazqD8Rg-1; Thu,
 01 Aug 2024 09:27:41 -0400
X-MC-Unique: RC26f5DlMfyvCaFazqD8Rg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A1B51955BED;
	Thu,  1 Aug 2024 13:27:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 14AC61955D44;
	Thu,  1 Aug 2024 13:27:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:39 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] uprobes: make uprobe_register() return struct uprobe *
Message-ID: <20240801132734.GA8803@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801132638.GA8759@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This way uprobe_unregister() and uprobe_apply() can use "struct uprobe *"
rather than inode + offset. This simplifies the code and allows to avoid
the unnecessary find_uprobe() + put_uprobe() in these functions.

TODO: uprobe_unregister() still needs get_uprobe/put_uprobe to ensure that
this uprobe can't be freed before up_write(&uprobe->register_rwsem).

Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h                       | 15 ++---
 kernel/events/uprobes.c                       | 56 ++++++++-----------
 kernel/trace/bpf_trace.c                      | 25 ++++-----
 kernel/trace/trace_uprobe.c                   | 26 ++++-----
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 25 ++++-----
 5 files changed, 67 insertions(+), 80 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 440316fbf3c6..137ddfc0b2f8 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
+struct uprobe;
 struct vm_area_struct;
 struct mm_struct;
 struct inode;
@@ -110,9 +111,9 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
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
@@ -150,18 +151,18 @@ static inline void uprobes_init(void)
 
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
index b7f40bad8abc..974474680820 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1099,20 +1099,14 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 		delete_uprobe(uprobe);
 }
 
-/*
+/**
  * uprobe_unregister - unregister an already registered probe.
- * @inode: the file in which the probe has to be removed.
- * @offset: offset from the start of the file.
+ * @uprobe: uprobe to remove
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
+	get_uprobe(uprobe);
 	down_write(&uprobe->register_rwsem);
 	__uprobe_unregister(uprobe, uc);
 	up_write(&uprobe->register_rwsem);
@@ -1120,7 +1114,7 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
-/*
+/**
  * uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
  * @offset: offset from the start of the file.
@@ -1136,40 +1130,40 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
  * unregisters. Caller of uprobe_register() is required to keep @inode
  * (and the containing mount) referenced.
  *
- * Return errno if it cannot successully install probes
- * else return 0 (success)
+ * Return: pointer to the new uprobe on success or an ERR_PTR on failure.
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
@@ -1188,35 +1182,29 @@ int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
 
 	if (unlikely(ret == -EAGAIN))
 		goto retry;
-	return ret;
+
+	return ret ? ERR_PTR(ret) : uprobe;
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
-/*
- * uprobe_apply - unregister an already registered probe.
- * @inode: the file in which the probe has to be removed.
- * @offset: offset from the start of the file.
+/**
+ * uprobe_apply - add or remove the breakpoints according to @uc->filter
+ * @uprobe: uprobe which "owns" the breakpoint
  * @uc: consumer which wants to add more or remove some breakpoints
  * @add: add or remove the breakpoints
+ * Return: 0 on success or negative error code.
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
index afa909e17824..4e391daafa64 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3160,6 +3160,7 @@ struct bpf_uprobe {
 	loff_t offset;
 	unsigned long ref_ctr_offset;
 	u64 cookie;
+	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
 };
 
@@ -3178,15 +3179,12 @@ struct bpf_uprobe_multi_run_ctx {
 	struct bpf_uprobe *uprobe;
 };
 
-static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
-				  u32 cnt)
+static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
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
@@ -3194,7 +3192,7 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 	struct bpf_uprobe_multi_link *umulti_link;
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
-	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+	bpf_uprobe_unregister(umulti_link->uprobes, umulti_link->cnt);
 	if (umulti_link->task)
 		put_task_struct(umulti_link->task);
 	path_put(&umulti_link->path);
@@ -3480,12 +3478,13 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		      &bpf_uprobe_multi_link_lops, prog);
 
 	for (i = 0; i < cnt; i++) {
-		err = uprobe_register(d_real_inode(link->path.dentry),
-				      uprobes[i].offset,
-				      uprobes[i].ref_ctr_offset,
-				      &uprobes[i].consumer);
-		if (err) {
-			bpf_uprobe_unregister(&path, uprobes, i);
+		uprobes[i].uprobe = uprobe_register(d_real_inode(link->path.dentry),
+						    uprobes[i].offset,
+						    uprobes[i].ref_ctr_offset,
+						    &uprobes[i].consumer);
+		if (IS_ERR(uprobes[i].uprobe)) {
+			err = PTR_ERR(uprobes[i].uprobe);
+			bpf_uprobe_unregister(uprobes, i);
 			goto error_free;
 		}
 	}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 1f590f989c1e..52e76a73fa7c 100644
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
@@ -1084,16 +1084,16 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 
 static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 {
-	int ret;
+	struct inode *inode = d_real_inode(tu->path.dentry);
+	struct uprobe *uprobe;
 
 	tu->consumer.filter = filter;
-	tu->inode = d_real_inode(tu->path.dentry);
-
-	ret = uprobe_register(tu->inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
-	if (ret)
-		tu->inode = NULL;
+	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
 
-	return ret;
+	tu->uprobe = uprobe;
+	return 0;
 }
 
 static void __probe_event_disable(struct trace_probe *tp)
@@ -1104,11 +1104,11 @@ static void __probe_event_disable(struct trace_probe *tp)
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
 
@@ -1305,7 +1305,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
 		return 0;
 
 	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
-		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
+		ret = uprobe_apply(tu->uprobe, &tu->consumer, false);
 		if (ret)
 			break;
 	}
@@ -1329,7 +1329,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 		return 0;
 
 	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
-		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
+		err = uprobe_apply(tu->uprobe, &tu->consumer, true);
 		if (err) {
 			uprobe_perf_close(call, event);
 			break;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 55f6905de743..3c0515a27842 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -432,7 +432,7 @@ uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
 
 struct testmod_uprobe {
 	struct path path;
-	loff_t offset;
+	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
 };
 
@@ -446,25 +446,25 @@ static int testmod_register_uprobe(loff_t offset)
 {
 	int err = -EBUSY;
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		return -EBUSY;
 
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		goto out;
 
 	err = kern_path("/proc/self/exe", LOOKUP_FOLLOW, &uprobe.path);
 	if (err)
 		goto out;
 
-	err = uprobe_register(d_real_inode(uprobe.path.dentry),
-			      offset, 0, &uprobe.consumer);
-	if (err)
+	uprobe.uprobe = uprobe_register(d_real_inode(uprobe.path.dentry),
+					offset, 0, &uprobe.consumer);
+	if (IS_ERR(uprobe.uprobe)) {
+		err = PTR_ERR(uprobe.uprobe);
 		path_put(&uprobe.path);
-	else
-		uprobe.offset = offset;
-
+		uprobe.uprobe = NULL;
+	}
 out:
 	mutex_unlock(&testmod_uprobe_mutex);
 	return err;
@@ -474,11 +474,10 @@ static void testmod_unregister_uprobe(void)
 {
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset) {
-		uprobe_unregister(d_real_inode(uprobe.path.dentry),
-				  uprobe.offset, &uprobe.consumer);
+	if (uprobe.uprobe) {
+		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
 		path_put(&uprobe.path);
-		uprobe.offset = 0;
+		uprobe.uprobe = NULL;
 	}
 
 	mutex_unlock(&testmod_uprobe_mutex);
-- 
2.25.1.362.g51ebf55

