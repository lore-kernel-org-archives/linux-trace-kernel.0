Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994E14A4F2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460607; cv=none; b=F6QgcMELTTyea7wnkkHunSiM/2AC5LivfYk8V0uFdj6ds/LSNReiA4wfqmc350rP56K3wdJacsdhPX3GzreZOJcdkhL+k+P8lQm9B+hOMsRB/h91Q7DL2AJ0CF75RGs1ew3c10pc9f7QylPDdFlzOPbcxi1ZssaLhVv5svhngig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460607; c=relaxed/simple;
	bh=3SHPrTsh291gPPSJVJYwpI6tTu40xoNN9n+YT4ukuDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iMiJAA1T7h3y9sG0IWddAXH+IRoGIxrKHN9P21USzT1Z0WSupxSPL/lNeg2GUg/5gE863jSap8D0y3ZNsLCfvBTco0KOrld2k7cmgCFIY38skAxp+4J7TMsbw8ykN+dbbc2KzdELYIt3+ibiPNjQZZvtSMt22+DWT+h3MIZ1lq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzN4T4M/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzN4T4M/"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so11056928276.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708460604; x=1709065404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8QdSbGAViukHkPqIszfFAUwep1tq+aZItBmmeT/BG0=;
        b=PzN4T4M/JM9C0wO1w247nch8Ynuh8lB0pacXm3Xshsz+91cyqXgsObQIOkBbWIfQ57
         t8yE4mVUyxwhiKaMA3I7jP0z5prFynpRXRoduS2i9jHqTUyqav+UvnAyi8gDlcQmn5OV
         JY61V6hX7/gzuI8rHeC/pTKHQ9TKRKyh1VJhgSRZ/C7ioRWcR285h3qPCdZZPW8lOPEX
         rY6a+g6RJzKXf6PYe1/2F0Kevz9cM4pSEWbXWUfJZCt+oN7045gcrl8cPNrfkIHkepPv
         9MHSrwypxKa/3CB/4Mwdx5rReBqNOyB6CL4ikGm8+pTP+1zcRdPFcfuqd4GIhScRwVc3
         lioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460604; x=1709065404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8QdSbGAViukHkPqIszfFAUwep1tq+aZItBmmeT/BG0=;
        b=vh7FQqANn21hx9fWzTOSVbA9Zv56zBLjDqLnKMcmaJ0C5KCEXjf/IPQWZdf8n9qI12
         GEtsw901CPHUxpfrHKlRxuJMIRmOEZKlFA1vY7DGWHgLw/XF/HXm5Aw36a0MTJ6X21kK
         u/7W2pqt3ovKthkJ7/rheZb3mGj0OgSD+rAq6mY+4gVQtqyw/Gih9g822B9eKjniPts2
         k4J87Q52mA+G2L1s3MdttiDyF8sAU6+Wiy7sMIvWYi82/oyKkKaKFcnq8w9t5XVZZvS6
         ekySttQo5/TxHRbSljvji6t9/LZmn8mtC+nlGLX5g8fQ15HVVZfbaEAUQ3977xaTvxT3
         9WOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmwkhYmw3cbTVdxHvnFw919852Vy2s3lQBDeFu6ahLYQo9h+gwOP/+RaP2pjLP/dwGOsU+Z4pk1cfhsWvKia5gQHeYg9iuVacY8JdJsUA4z1+S
X-Gm-Message-State: AOJu0YzC1nHavb57ilPYO22MSO4UrpxXbM21v34LRpB9Q/ONppXfWRqj
	4Re6Ps8xkcBT8OlIfcxxGWsLZ3DSZsaz3hJjDmcNqamzesN+lXlbeOehALXWyr/7bAWNKxHdFXo
	laBasRVArWw5iKQ663Q==
X-Google-Smtp-Source: AGHT+IE/ancGfEt3dVmtYkHD4N3MkOZIKbA3j7T/n8+lKl5omaui0C0RvM/YgDQURp401zWa0PNW73oikfY9sTEi
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:1209:b0:dc6:9e4a:f950 with
 SMTP id s9-20020a056902120900b00dc69e4af950mr4085428ybu.3.1708460604213; Tue,
 20 Feb 2024 12:23:24 -0800 (PST)
Date: Tue, 20 Feb 2024 20:23:08 +0000
In-Reply-To: <20240220202310.2489614-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220202310.2489614-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220202310.2489614-5-vdonnefort@google.com>
Subject: [PATCH v18 4/6] tracing: Allow user-space mapping of the ring-buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
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
index 8ae7c2cb63a0..67ce7b367edb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1176,6 +1176,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
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
@@ -1308,7 +1314,7 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
 	lockdep_assert_held(&trace_types_lock);
 
 	spin_lock(&tr->snapshot_trigger_lock);
-	if (tr->snapshot == UINT_MAX) {
+	if (tr->snapshot == UINT_MAX || tr->mapped) {
 		spin_unlock(&tr->snapshot_trigger_lock);
 		return -EBUSY;
 	}
@@ -6535,7 +6541,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8654,15 +8660,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
+					       iter->tr->buffer_percent);
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
 
 	iter->wait_index++;
@@ -8675,6 +8697,110 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
+static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
+{
+	struct ftrace_buffer_info *info = vmf->vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+	struct page *page;
+
+	page = ring_buffer_map_fault(iter->array_buffer->buffer, iter->cpu_file,
+				     vmf->pgoff);
+	if (!page)
+		return ret;
+
+	get_page(page);
+	vmf->page = page;
+	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
+	vmf->page->index = vmf->pgoff;
+
+	return 0;
+}
+
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
+	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
+	put_snapshot_map(iter->tr);
+}
+
+static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	WARN_ON(ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file));
+}
+
+static const struct vm_operations_struct tracing_buffers_vmops = {
+	.open		= tracing_buffers_mmap_open,
+	.close		= tracing_buffers_mmap_close,
+	.fault		= tracing_buffers_mmap_fault,
+};
+
+static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = filp->private_data;
+	struct trace_iterator *iter = &info->iter;
+	int ret = 0;
+
+	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC)
+		return -EPERM;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	ret = get_snapshot_map(iter->tr);
+	if (ret)
+		return ret;
+
+	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+	if (ret)
+		put_snapshot_map(iter->tr);
+
+	return ret;
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8683,6 +8809,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd312e9afe25..8a96e7a89e6b 100644
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
2.44.0.rc0.258.g7320e95886-goog

