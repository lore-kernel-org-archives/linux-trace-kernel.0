Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6217082E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349890; cv=none; b=qreSa+flXFqpcAFSgJytADYHMPZCoQvPqMzNBrr5WtXIo5sjP1kzBYGR9BqlYSpCTujAwMj2QP7P+3BC7hatEFISJ5y1tv76IacPMyk18WzZg5X7Bu7awrUlZQsDVUiAWMTey0PhDtfRnFboJlGBR9p7KUS5M/0M0j8P55Suxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349890; c=relaxed/simple;
	bh=aRlFwN6lm5I2Rw2uHCFf4kzQfwJ7ZvwKSUHjdJiCmPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dd9VNXb4cwACUZxny8zghYaI/QEjeKxe3Kt2yyxlrphSnYJbU/p6R9fTIqmhayYbrzVqY6GODziuyGu5fkuCbujIPlNjxD8x1PlCGy9f9D6/d6CgBrKU1OUeK+BCK69c8oS0YKPiHzprB1EuUSzoKl3tSyZt02LKL4fmVSS9GG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZcL8/m3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZcL8/m3"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41fda32e6c0so8198025e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715349887; x=1715954687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zdfkQQHQ+TrC3jj6DAXbeUjEu5Qb/gD5sIE30hR3P0=;
        b=kZcL8/m3ihofupDQPBTi+mNqFnxGO52580kyED2H6LeCkEoRpg3FiVaPZ3emqPKQIu
         ZAb/liSTgUXpr4CnAZDs3dFjPivBCDxVluKSiPSj8w1X2pemBXR54B3JgtBDewOmKL+T
         S40GFhSrzELbhtxYke3A1dJaH56BfPlweudeI3HFWpAQKfaVZda/1uZUnuB7bsSNzxOJ
         bISk1O8sn+VmbqHSMazPEjBvQqC7KeAcue07W3zFZG4bzV0w0h7d4X0+J41d8SpXzcVu
         mfMM6srpImno7waog2o20YAPtYeqHtFc2JKDY+VCuFRszUR8G6lM9EJGIfA54bqW5z0V
         sQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349887; x=1715954687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zdfkQQHQ+TrC3jj6DAXbeUjEu5Qb/gD5sIE30hR3P0=;
        b=KWBxwCOKoe1HI92va67JWo29P70rJ7leY/MXY+Lwh0Yb8c5BQxM0GSD67pEzWxq+35
         eepPoNV58djMsx1KEn7WbCAZvz+wrEVqYrlRB4Sg5uWKA41c3pinYpeUWFpsr0BBxnAn
         Dz2fd6umIDN09R56HBshTYY0TqWmtfvQSGP39vIxS1Y2B+P0vjS+M4ghtz/XiBePeUY8
         t4DAnoWGvQaQ5Y6QT3R4xsB/gTTHOA8RwntaTd0ezuG7LNITetGkdoOZdifcsrLdxEyO
         EVfbKqtuBc0CvvxcyCkhxT0+Y3uqgyuZMfaLKyWrqCtGObLMu63czPLYxZxkhK+Ywm/G
         6VRg==
X-Forwarded-Encrypted: i=1; AJvYcCV4mOTFcj6J8dlII33HgTaYaLm47xIMn/+ObhI7wcSqtr4DWQmw0/nOzTTtYNiO0R+5ShjXmM/EHTvmcMGqQHIjwfWFQrAoH16mkXSOhiIYNTFq
X-Gm-Message-State: AOJu0Yy/cCj8QjDXlOOC2Dt7yVLbRoIlEJDnykWlPDG9NQuJb/XjY2ZB
	5GOxAjgIKgPdZ9RA1cl68UV/7pQ/jSLjas1day3+6c3aOCSIVEpwTo3ah/csoyTlQhYmjFEvmSz
	/6thSiWAu932NQG+ayw==
X-Google-Smtp-Source: AGHT+IFmbfbkyt1cuaCw7Z9TpcR3i/kvhX4wMWaVaTY6+kkbiriQkTVeu4WPHk+cGdtSa64MbF2oPERzDLCphX/v
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:580a:b0:41b:e416:31e3 with
 SMTP id 5b1f17b1804b1-41fbd0b952cmr185995e9.3.1715349886925; Fri, 10 May 2024
 07:04:46 -0700 (PDT)
Date: Fri, 10 May 2024 15:04:32 +0100
In-Reply-To: <20240510140435.3550353-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510140435.3550353-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510140435.3550353-4-vdonnefort@google.com>
Subject: [PATCH v23 3/5] tracing: Allow user-space mapping of the ring-buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>, linux-mm@kvack.org
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
index b682e9925539..bd1066754220 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -43,4 +43,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+
 #endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 233d1af39fff..a35e7f598233 100644
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
@@ -8214,6 +8237,76 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
+	ret = get_snapshot_map(iter->tr);
+	if (ret)
+		return ret;
+
+	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file, vma);
+	if (ret)
+		put_snapshot_map(iter->tr);
+
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	return ret;
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8223,6 +8316,7 @@ static const struct file_operations tracing_buffers_fops = {
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
2.45.0.118.g7fe29c98d7-goog

