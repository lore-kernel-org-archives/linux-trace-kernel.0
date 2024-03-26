Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132496BB37
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447475; cv=none; b=QFrhPOiMaL7S2yiUUr3SRzEGQPObVHzmPOrsD+MKY5/GCdJGWQA3bZQzonf2xLthcYIVs8oJ6kfslGoep24qRgNwB2cvO/UNSb8mLbsVtMcPqljcNin+jQHe0JIj3VXauvF1g4TBLiV7riUfIcM6mJ9AS9Gc7O/wDjXxmIJFvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447475; c=relaxed/simple;
	bh=vewyRU1FCoHfiZvD831XIr5Z134/TPagFGMpgx9+rqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=toXbOOmv0JnBj6tOwyhv0++T8Fz73hTVaF2V4BhwnYVgnx8rL2bbLBx2SChAAm3p3TmsBkt5bC1EKAVotNEcKLKFO2D1jNJOqzM8rw/p6hK+q1btGVhHrDx+C2JCJJx4IDabqlNFdNIC/8YYOTCJGgstZ6nN8FFmh6x4iDtQ3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xTc2A/W; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xTc2A/W"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso8838427276.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447473; x=1712052273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEw1NMUwkmEW8DGRGDd7fdO0TcBWDtzSQTo9LGwkNa0=;
        b=0xTc2A/WF1TIyLfVHCNsqoEr5wzReu+deTVsIZi6XhnCovriYbhmyiYk1aFRoSL5GR
         wD3JCtx7SJvabduUTDbgcG0n6W7iF9D/4sgi8MWvRtXHC5HfbIQFdi/r1FP+h7Lrortr
         IIaT1RMi8Eo4GF979DFf4W3Kfs1reiF5qzKGurDcte1jifIZdmeXluzI5f7wvv7lig8/
         kZ7HvCIIJKB/DYo/UxLK8dm1oY1H+GSi6JRIShHXaGIsulNCM1tvcUgnHVMxyVH7rBf+
         sj902a45vOHYF60AYaIfW9bm5vcEsY6/GME4cgvqPYlXCXhpbznWD2wz/UAqm8PumQLP
         irPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447473; x=1712052273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEw1NMUwkmEW8DGRGDd7fdO0TcBWDtzSQTo9LGwkNa0=;
        b=iZcKN5LLTcdqhxNKe6R2uUX3uOoFW+cyh3Bo0IGK6rJqIqNbaZ0IxKCzDgA9Y7OgBQ
         bA5QrK363yucR5yLfGkqmBn8liOjj8af3zcogy4gs8UGDNcw4xTBFCGgYrogcbL4FZq8
         gYbZpadcWFAZ42kgbocolUwVbthv9Z7SHEmAkSSLpEGpywQ4m7dQtaVGaduSHaZP6jkh
         +6QaOkun8oRn5iy29CpQQFv0gF+IKQTKDHyeDw1/5P6lmshdTzZMp/DYXPSqRNUO9K7X
         bMh71fFNWEfjvKzxWtusdw96XI0Yi+xIjEtANs2ULsuRUIKy0t0eaum0A//CmVdfjCHp
         5fXA==
X-Forwarded-Encrypted: i=1; AJvYcCXe9kTOwv/3ZNFLgknDGbJVWHndQUhkElsjlPDPMpDJAIs2ZOWuisJOHmqPrxTYvdWbB4ji7HmGBtuhwR9AxQThPOrNLsK85sr6yKmbFAL3QULH
X-Gm-Message-State: AOJu0YwuCS1DWKfDHVKyQuuAAJX87g7cMv5FXtOIkrgDgCa16sRSB6bZ
	iLT2w90m4U/m5YwjhigJHbdPyHdrPTGn9CrISkeRrLLrK6zB9/ozVonzitRhsp+eGzB4YCZDWo6
	N9ILgQAEKQQM/BrEdFQ==
X-Google-Smtp-Source: AGHT+IE27dvJsbA7oDmc+PCYUyPjCjio/TXsNs6A98OQCHyWy69GGgxMyyQ6y0iFcgqHJutXauL4bFK2Nh4z44RE
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:230d:b0:dc6:dfd9:d431 with
 SMTP id do13-20020a056902230d00b00dc6dfd9d431mr2918428ybb.1.1711447473127;
 Tue, 26 Mar 2024 03:04:33 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:03:28 +0000
In-Reply-To: <20240326100330.1321861-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326100330.1321861-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100330.1321861-4-vdonnefort@google.com>
Subject: [PATCH v19 3/5] tracing: Allow user-space mapping of the ring-buffer
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
index 233d1af39fff..0f37aa9860fd 100644
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
+
+	if (cmd == TRACE_MMAP_IOCTL_GET_READER) {
+		if (!(file->f_flags & O_NONBLOCK)) {
+			err = ring_buffer_wait(iter->array_buffer->buffer,
+					       iter->cpu_file,
+					       iter->tr->buffer_percent,
+					       NULL, NULL);
+			if (err)
+				return err;
+		}
 
-	if (cmd)
-		return -ENOIOCTLCMD;
+		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
+						  iter->cpu_file);
+	} else if (cmd) {
+		return -ENOTTY;
+	}
 
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	/* Make sure the waiters see the new wait_index */
@@ -8214,6 +8237,94 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
+static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
+{
+	return VM_FAULT_SIGBUS;
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
+	WARN_ON(ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file));
+	put_snapshot_map(iter->tr);
+}
+
+static void tracing_buffers_mmap_open(struct vm_area_struct *vma) { }
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
@@ -8223,6 +8334,7 @@ static const struct file_operations tracing_buffers_fops = {
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
2.44.0.396.g6e790dbe36-goog

