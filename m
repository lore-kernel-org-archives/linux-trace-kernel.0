Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB1BC05027
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 12 Feb 2023 15:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBLPdY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 12 Feb 2023 10:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBLPdO (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:33:14 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D6C65D
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:33:10 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id k17-20020a05600c1c9100b003dd41ad974bso5404279wms.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+d4ipAHpReLmFZk9nFLE2xPZqTKQlJEwK1FQJWisIY=;
        b=bPDmQfdCZw8lNqkinMZjF8xpczDSiTRYQgdspyJY8Vf5QPMuk36Z0VU7JJThODDPWf
         vlySehWqGwFR1EG95l6sJg0Eh6UNcQx1u8uOn5KZXDA3SRdUKHzyzcjA7KmhRijKJDDk
         tXxtgR+W7Zw6QBTTz4E6dTH7+GHKtjGGNVqMbLGKulERjMwSDk34nPk3Qv9GFzktEY6L
         fhD0Rd4Dtb4w0Aa2FKG8Lpk8I2jxs797I04cwrMRIocF8nKPyUNk9Lnx6y3hm1NTOZd7
         1T0e13BQBz1GCug+pcPpAOP8Sy3eQIO1ekH4D3hJrp8Y1xraoZ/HkSuEUtDS39nD5TUi
         mvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+d4ipAHpReLmFZk9nFLE2xPZqTKQlJEwK1FQJWisIY=;
        b=S7sS/Clc0GwUsYJh3NCSd4onZN/6RQHSIA0cqaToFumYQvEQ6pzQYR3WwzSi673gMr
         PjkZFMoKGGayUTqpaL8KuuaFPex3YmTDKI7ikG63gCm62ng4jI7FDXI12zl5nihwRy2j
         vltnKdlBY3c6sOcjV6WLkNToFwsTA2egc5vBIQCGDugOxoJdD38CaqPsVSUoZVCg3lb7
         RHdDsx854FQjiyOMMWz6jafFogNewIqgIiRMg9qD0QMj1E1MKp5p4JssyDj7Gy1lGzNT
         r1Xpknia5Jm91YLIhF0T81KrGVdqnHGwdE6+nh1DwwEwvqc+keCIqEHJGtr4WS0lwOMX
         7K/w==
X-Gm-Message-State: AO0yUKVdLZ3tzId4J9ZVCkIk8O8/lNL/hj41I04jYQtuXOn+6mWYWDnN
        FfUx8bXOEbmvk6dRUuElaoBi1gi7kC+90uie
X-Google-Smtp-Source: AK7set9HzQqLLwTBhCUfaS347mT3tH0TTlTVjXRiHOtP9X/USfmu8A7LMFbYHs3kJctWE2Hvss1QMZLLh7Qntj8u
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1c81:b0:3db:105:85a4 with SMTP
 id k1-20020a05600c1c8100b003db010585a4mr1282764wms.124.1676215988772; Sun, 12
 Feb 2023 07:33:08 -0800 (PST)
Date:   Sun, 12 Feb 2023 15:32:50 +0000
In-Reply-To: <20230212153250.1099136-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230212153250.1099136-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230212153250.1099136-3-vdonnefort@google.com>
Subject: [RFC PATCH 2/2] tracing: Allow user-space mapping of the ring-buffer
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Currently, user-space extracts data from the ring-buffer via splice,
which is handy for storage or network sharing. However, due to splice
limitations, it is not possible to do real-time analysis without a copy.

A solution for that problem is to let the user-space map the ring-buffer
directly.

The mapping exposed via the per-CPU file trace_pipe_raw. The first page
is the meta-page and is followed by each page of the ring-buffer,
ordered by their unique page ID. It is therefore easy to translate a
page-ID to an offset into the mapping.

  * Meta-page -- include/uapi/linux/trace_mmap.h for a description
  * Page ID 0
  * Page ID 1
     ...

The mapper must then do what use to be the kernel jobs: swap the reader
with the head. This is done with a newly introduced ioctl:
TRACE_MMAP_IOCTL_GET_READER_PAGE.

To avoid putting to much work on the writer, the meta-page is not
automatically updated. User-space must query an update before reading
with another ioctl: TRACE_MMAP_IOCTL_UPDATE_META_PAGE.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index 0f3282fa1a94..fe3bbe02e571 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -11,4 +11,7 @@ struct ring_buffer_meta_page {
 	__u32		data_pages[];
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)
+#define TRACE_MMAP_IOCTL_UPDATE_META_PAGE	_IO('T', 0x2)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 78ed5f1baa8c..e7d999499dde 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6351,7 +6351,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8384,15 +8384,27 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
-/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
 static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
 
+	switch (cmd) {
+	case TRACE_MMAP_IOCTL_GET_READER_PAGE:
+		return ring_buffer_get_reader_page(iter->array_buffer->buffer,
+						   iter->cpu_file);
+	case TRACE_MMAP_IOCTL_UPDATE_META_PAGE:
+		return ring_buffer_update_meta_page(iter->array_buffer->buffer,
+						    iter->cpu_file);
+	}
+
 	if (cmd)
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	iter->wait_index++;
@@ -8405,6 +8417,61 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
+	vma->vm_flags |= VM_DONTCOPY | VM_DONTDUMP;
+	vma->vm_flags &= ~VM_MAYWRITE;
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	return ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8413,6 +8480,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.39.1.581.gbfd45094c4-goog

