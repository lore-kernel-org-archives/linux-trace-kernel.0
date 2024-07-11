Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803ED15A858;
	Thu, 11 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696051; cv=none; b=PjjheLIB8aaao8vKIzX83ZOqTsO95Sz5SIYbRdYoHG5kV8scZS9mR8fhXZ39gwwaDVhil1sNAgdfAD2Ak1A0491IKpciNagSnBEnOgvWHNZoKghX+3f+SAGpH6vj4An8NLooTtM8Ol6pAwX8ZnKLgAI1rZUhrfsf20ZTXEvjVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696051; c=relaxed/simple;
	bh=yWhZob/BPdfmsu4sMDxRN0GS62Spdk2BlA3DKMfmucc=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Jimirk//bTdQFoNkD4hSrOlyvpLtIrVRGTHM60rHagRKhHVAzhPv35HyqsJ4XMtS7nmv1Ndw5A8AMvT6jW6SN+BVg0hsZkQaMLHZcpecstjbQ9vXbP6cvWb/cvmVKv8WC+LJ9cnj+VqObyTqQUeaGUNYm4253kgk3a6Mhy7dr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UxG5cgI2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UxG5cgI2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=s3nlTehZi84BQk5xkIwuRvVH+7l2BKBHmhJ6dERK42A=; b=UxG5cgI2PlV+kN2BaMvLp2uti+
	SivKGvdWfRU5ftI6DRrV00GogYI7/qEdn5itwzJzGZTgYMChpZkcaQepMAe61HanCd+65s73Vb5gK
	uEhsBthleKNzi3kHJceVE/JXA3Esfs/I2qHJmKjCAN1ULYrmMRA0Kt0R5d3MRjCZzgZUseNNJTvgV
	7xqKTpj5W5cpW+0W8hRyxjRvL0lCMKkt1o4rktrUuxcoUj562iVIMVz8kHonwQGkI59J6Q0Q+XRIw
	813658CY1VH6+QJg4jKaHwqCiGDFWp+wUqsRN5JfFL0SLanLDSlUX7+lPu/8/zjd4nHRl5MCNZtlu
	pKqdusJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRre0-0000000Ax6Y-0FWb;
	Thu, 11 Jul 2024 11:07:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CE7C2302DCC; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110400.987380024@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:42 +0200
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
Subject: [PATCH v2 07/11] perf/uprobe: Split uprobe_unregister()
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With uprobe_unregister() having grown a synchronize_srcu(), it becomes
fairly slow to call. Esp. since both users of this API call it in a
loop.

Peel off the sync_srcu() and do it once, after the loop.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/uprobes.h     |    8 ++++++--
 kernel/events/uprobes.c     |    8 ++++++--
 kernel/trace/bpf_trace.c    |    6 ++++--
 kernel/trace/trace_uprobe.c |    6 +++++-
 4 files changed, 21 insertions(+), 7 deletions(-)

--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -113,7 +113,8 @@ extern int uprobe_write_opcode(struct ar
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern void uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern void uprobe_unregister_sync(void);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -163,7 +164,10 @@ uprobe_apply(struct inode *inode, loff_t
 	return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+{
+}
+static inline void uprobes_unregister_sync(void)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1138,7 +1138,7 @@ __uprobe_unregister(struct uprobe *uprob
  * @offset: offset from the start of the file.
  * @uc: identify which probe if multiple probes are colocated.
  */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+void uprobe_unregister_nosync(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 
@@ -1152,10 +1152,14 @@ void uprobe_unregister(struct inode *ino
 	raw_write_seqcount_end(&uprobe->register_seq);
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
 
+void uprobe_unregister_sync(void)
+{
 	synchronize_srcu(&uprobes_srcu);
 }
-EXPORT_SYMBOL_GPL(uprobe_unregister);
+EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
 /*
  * __uprobe_register - register a probe
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3181,9 +3181,11 @@ static void bpf_uprobe_unregister(struct
 	u32 i;
 
 	for (i = 0; i < cnt; i++) {
-		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
-				  &uprobes[i].consumer);
+		uprobe_unregister_nosync(d_real_inode(path->dentry), uprobes[i].offset,
+					 &uprobes[i].consumer);
 	}
+	if (cnt)
+		uprobe_unregister_sync();
 }
 
 static void bpf_uprobe_multi_link_release(struct bpf_link *link)
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1104,6 +1104,7 @@ static int trace_uprobe_enable(struct tr
 static void __probe_event_disable(struct trace_probe *tp)
 {
 	struct trace_uprobe *tu;
+	bool sync = false;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
 	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
@@ -1112,9 +1113,12 @@ static void __probe_event_disable(struct
 		if (!tu->inode)
 			continue;
 
-		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+		uprobe_unregister_nosync(tu->inode, tu->offset, &tu->consumer);
+		sync = true;
 		tu->inode = NULL;
 	}
+	if (sync)
+		uprobe_unregister_sync();
 }
 
 static int probe_event_enable(struct trace_event_call *call,


