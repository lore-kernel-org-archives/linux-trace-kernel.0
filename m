Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAE6350B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGk8JF0G"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5caf86963ecso15969987b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703180132; x=1703784932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/chp9iYc18PijDbo+8g07Uc+eJNKO0EynyXnVgKIzI=;
        b=MGk8JF0Gy+yAzKfIOl1qcxpR1QYAR0Re83l8bnDMyVBh/8TlomVFF0NSy4wfSkUcVO
         j6NaG0EHDk1jLjANpqMW75URhYwIlvONfgIC45SSXFsL1P2znzDJl3XX9Z0g1jQi7/CE
         wp59MU5TWvdZyIIhOQPaMwjTtO6/tpZgehCvDCOQ3uccQU+DqG84x6w+BM6EboD/KJZO
         02XOT682/O7AsLAXBBMBS98rKzofzoBtbD0HkWdCetzcDV0XnuoEbv92KvlZibaHLIrc
         BM88DMP4fBkv3NaJF+bMGsNPuoc0+LwsccBnK4UUwafXIjXVnyAB64U119lmlYWH0vWa
         YXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180132; x=1703784932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/chp9iYc18PijDbo+8g07Uc+eJNKO0EynyXnVgKIzI=;
        b=NW8Ou1YoddVxt1socZhoNCeeESUfT/wwc9/JYHFhquR6jnydfBo4byNjzE70yoOMZb
         h86LWZv8XsWJEp64VWtqVPOvbjVJqzhbP3Y/wee/hEJSXlQu9973nevB1MINBe+ab1fN
         EVX1r8qwDczkqfXMYRd8235mxT2QQUSiaOuhYo7/5gD4M/kYtKz5K9qFiu3c3cIG337h
         +gfaht3Y1mD9dMSpHCxqYybc5c0xj0y9f3qPIZSIhXxfTE8D8JLKqyUrHWcXqmlgYr/j
         e+ya/U94s1lYe6eNBzB8UytShzd83Th6T1rwV6mew6JBKnIHWWqhlCEpYL7GUB708y6v
         076A==
X-Gm-Message-State: AOJu0Yzd11xjfW3Ejx0aRemO6KOxhN7Xa/ak5PQWBa27c+W7KKGETEqv
	j+CHfLRRv5bzvkYrYdrlZbGX0Nl+PcHiBZIq1V67SEQ=
X-Google-Smtp-Source: AGHT+IGB3a8jB7CQe9SSOQn3k4KcYq+8FU6pZoJGtjqAyLqxHYvIbi2/5WluMi6tqcxp1EYsAAkzJIAZDlnkkWs4
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:136e:b0:dbd:7508:f527 with
 SMTP id bt14-20020a056902136e00b00dbd7508f527mr1087ybb.5.1703180132391; Thu,
 21 Dec 2023 09:35:32 -0800 (PST)
Date: Thu, 21 Dec 2023 17:35:23 +0000
In-Reply-To: <20231221173523.3015715-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231221173523.3015715-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231221173523.3015715-3-vdonnefort@google.com>
Subject: [PATCH v9 2/2] tracing: Allow user-space mapping of the ring-buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index f950648b0ba9..8c49489c5867 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -26,4 +26,6 @@ struct trace_buffer_meta {
 	__u32		meta_struct_len;	/* Len of this struct */
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 46dbe22121e9..cfeaf2cd204e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8583,15 +8583,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
@@ -8604,6 +8620,62 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
+static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
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
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	return ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8612,6 +8684,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.43.0.472.g3155946c3a-goog

