Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5064AEEC
	for <linux-trace-kernel@vger.kernel.org>; Sat,  6 Apr 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425038; cv=none; b=lV2WMjQnqBGUheYgiVHPKNJNo58kIl11f0Nz+1Xw9bpK85AXMqi55M+zzJ3tqWshdUgB1XYe8e5BufN/bal+hOLztzk+kra0KV/JTldSuxb76wdiHnthYfUIk6RKrF4uUYVq/v3LR4Haa5/3IO1ASHBHACHOPmTLiZMOMTkWmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425038; c=relaxed/simple;
	bh=Lvoqrrw6aRBYXRrzMVyPphgJZjVxj5geYg2eQwwuYcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nI47Kdjuipyd2pOW9enrtz/W9cvFCnKfhVlWdu3/MDPK15m6WfnpNUU6BEvPtRbIH7spnFu7Y375Qb2w4YuiV9bK2YGOCKMG1ALe8BFt9JQMOO8T45UUg32R4fpdQtxUxTwopOEftMdf7ZAvkLlAU5EWmJrirTCnL+T9twksiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3G2bkiry; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3G2bkiry"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343f08542f8so871509f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Apr 2024 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712425035; x=1713029835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=72Zhe8jfvgxef0iyuPAsGeg/MBc9zR+e0H1uunA/IEs=;
        b=3G2bkiry3EMo6luTVYfEc7Mh8rZP/Od+4/Kb0FrdsGC4UPrpN5l+8ZLUMKwLZ8T+23
         hVPYRnFF+4gsq81Jk9U3oSRQKM9CFY5aADxnVXJVd6uIUFOKh54z4mOLc8b70I/0kIGb
         iRR3TnXIheHQsV3yEDe0IZMo1Y6/VUx0vmHqwpgU0lka+JA/8RaflfCO1PCbVSrNaGcu
         3CSxeBaSr7sMjDhaILeqtox0pVSd6SIdWo6cZWrevGAUi5aCpBHclU125IwtxQ4zgw4W
         lq6b3Op55eb2jYE5+7Cr5s+nEVqe2ZtiRggK8laPob1Yrj9KKmDmiILE6bj365k2CHG6
         yezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712425035; x=1713029835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72Zhe8jfvgxef0iyuPAsGeg/MBc9zR+e0H1uunA/IEs=;
        b=XhxW3ROaoDCsWitwwwAxJRsoLO8UgR36JsyPyoTEqmMUhywD+a3CJxt7woqEVvVs+V
         Xv5HwG5k3rhNzSYJxmv3hTJOHbJPpIV5tFQ7Eihi3M+er+5kHuijeOw13PCBraaqQRER
         InioN5GViAM1+BlfRXu16h7b5ip/8VxSH+4bcj2EoiFkYMCLg+F64RW78MRXWiMJWaPX
         bju3ibLl7kQvivNJ/8NuyR/Fe0NNbuqnBc613P/MyuOfOe2Uau93atSMBi4NQ1SFl/O3
         qZo2QJqBrUUiDiLP0XT7JRYsEfnfJn46E+TDp/x6ab56a7xmsQfs8oxlxAjz3weAdNuW
         UpIA==
X-Forwarded-Encrypted: i=1; AJvYcCVhM6DvqOQPejDiIDGWvv8spfn/sggY59ZLGCpOMJfutOXg0NsnzswQ9t/0143JOlxTX7yRV8R33Iqou95qEe1wb0udZgQa0ot2J4gKrbu0jXeE
X-Gm-Message-State: AOJu0Yyn9e22RjT0L0/eDqKI/XTixT6eo8b0c5UcFen1Avav1I/Z9oEJ
	sg+EhVcMegYkqzt48a7LchS8SryR8weVsJSaLSl/tUU6A6rT7KJ8zXIvVphndrhuy6ShJ+c333s
	cruT27bLX2hh7zIXO5g==
X-Google-Smtp-Source: AGHT+IGiDvc+/BkaShTc5qPfjfkPWDIrx/Pw/cQ9puA5MwbRRuMEO4JPSTNTgVUJ8vLGJlfy/dHi3mkpuxYFwMrp
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:f04a:0:b0:343:ebd3:c444 with SMTP
 id t10-20020adff04a000000b00343ebd3c444mr8807wro.5.1712425035369; Sat, 06 Apr
 2024 10:37:15 -0700 (PDT)
Date: Sat,  6 Apr 2024 18:36:47 +0100
In-Reply-To: <20240406173649.3210836-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240406173649.3210836-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240406173649.3210836-4-vdonnefort@google.com>
Subject: [PATCH v20 3/5] tracing: Allow user-space mapping of the ring-buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, Vincent Donnefort <vdonnefort@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Currently, user-space extracts data from the ring-buffer via splice,
which is handy for storage or network sharing. However, due to splice
limitations, it is imposible to do real-time analysis without a copy.

A solution for that problem is to let the user-space map the ring-buffer
directly.

The mapping is exposed via the per-CPU file trace_pipe_raw. The first
element of the mapping is the meta-page. It is followed by each
subbuffer constituting the ring-buffer, ordered by their unique page ID:

  * Meta-page -- include/uapi/linux/trace_mmap.h for a description
  * Subbuf ID 0
  * Subbuf ID 1
     ...

It is therefore easy to translate a subbuf ID into an offset in the
mapping:

  reader_id = meta->reader->id;
  reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;

When new data is available, the mapper must call a newly introduced ioctl:
TRACE_MMAP_IOCTL_GET_READER. This will update the Meta-page reader ID to
point to the next reader containing unread data.

Mapping will prevent snapshot and buffer size modifications.

CC: <linux-mm@kvack.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index ffcd8dfcaa4f..d25b9d504a7c 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -43,4 +43,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+
 #endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 233d1af39fff..83194bf7b1df 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1191,6 +1191,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
 		return;
 	}
 
+	if (tr->mapped) {
+		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
+		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
+		return;
+	}
+
 	local_irq_save(flags);
 	update_max_tr(tr, current, smp_processor_id(), cond_data);
 	local_irq_restore(flags);
@@ -1323,7 +1329,7 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
 	lockdep_assert_held(&trace_types_lock);
 
 	spin_lock(&tr->snapshot_trigger_lock);
-	if (tr->snapshot == UINT_MAX) {
+	if (tr->snapshot == UINT_MAX || tr->mapped) {
 		spin_unlock(&tr->snapshot_trigger_lock);
 		return -EBUSY;
 	}
@@ -6068,7 +6074,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8194,15 +8200,32 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
-/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
 static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
+	int err;
 
-	if (cmd)
-		return -ENOIOCTLCMD;
+	if (cmd == TRACE_MMAP_IOCTL_GET_READER) {
+		if (!(file->f_flags & O_NONBLOCK)) {
+			err = ring_buffer_wait(iter->array_buffer->buffer,
+					       iter->cpu_file,
+					       iter->tr->buffer_percent,
+					       NULL, NULL);
+			if (err)
+				return err;
+		}
 
+		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
+						  iter->cpu_file);
+	} else if (cmd) {
+		return -ENOTTY;
+	}
+
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	/* Make sure the waiters see the new wait_index */
@@ -8214,6 +8237,85 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
+#ifdef CONFIG_TRACER_MAX_TRACE
+static int get_snapshot_map(struct trace_array *tr)
+{
+	int err = 0;
+
+	/*
+	 * Called with mmap_lock held. lockdep would be unhappy if we would now
+	 * take trace_types_lock. Instead use the specific
+	 * snapshot_trigger_lock.
+	 */
+	spin_lock(&tr->snapshot_trigger_lock);
+
+	if (tr->snapshot || tr->mapped == UINT_MAX)
+		err = -EBUSY;
+	else
+		tr->mapped++;
+
+	spin_unlock(&tr->snapshot_trigger_lock);
+
+	/* Wait for update_max_tr() to observe iter->tr->mapped */
+	if (tr->mapped == 1)
+		synchronize_rcu();
+
+	return err;
+
+}
+static void put_snapshot_map(struct trace_array *tr)
+{
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (!WARN_ON(!tr->mapped))
+		tr->mapped--;
+	spin_unlock(&tr->snapshot_trigger_lock);
+}
+#else
+static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
+static inline void put_snapshot_map(struct trace_array *tr) { }
+#endif
+
+static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	WARN_ON(ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file));
+	put_snapshot_map(iter->tr);
+}
+
+static const struct vm_operations_struct tracing_buffers_vmops = {
+	.close		= tracing_buffers_mmap_close,
+};
+
+static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = filp->private_data;
+	struct trace_iterator *iter = &info->iter;
+	int ret = 0;
+
+	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
+	    !(vma->vm_flags & VM_MAYSHARE))
+		return -EPERM;
+
+	vm_flags_mod(vma,
+		     VM_MIXEDMAP | VM_PFNMAP |
+		     VM_DONTCOPY | VM_DONTDUMP | VM_DONTEXPAND | VM_IO,
+		     VM_MAYWRITE);
+
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	ret = get_snapshot_map(iter->tr);
+	if (ret)
+		return ret;
+
+	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file, vma);
+	if (ret)
+		put_snapshot_map(iter->tr);
+
+	return ret;
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8223,6 +8325,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 64450615ca0c..749a182dab48 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -336,6 +336,7 @@ struct trace_array {
 	bool			allocated_snapshot;
 	spinlock_t		snapshot_trigger_lock;
 	unsigned int		snapshot;
+	unsigned int		mapped;
 	unsigned long		max_latency;
 #ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
-- 
2.44.0.478.gd926399ef9-goog

