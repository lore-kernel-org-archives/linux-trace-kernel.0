Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A21C6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 17 Mar 2023 14:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCQOdn (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 17 Mar 2023 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjCQOdi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:33:38 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E7E4C5D
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:33:33 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id l18-20020a05600c4f1200b003ed35ab903aso3952032wmq.6
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679063612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pr8i0Eumz09pFpMEBVzLFDV1F++dQdI0hyhxEAp2n3w=;
        b=KFFpGv1i3Q3hEABcr9gwon1e9ZOOii+a9nok8Xz6VJHQXlZj8a4ilUYyQ7HMnuhkCI
         sXZLVNB42WAB9R7e4mMHVa9IZOWnDXuNH+2j9OKDAHzVLPmvvD6GIRnvO3NL+LPmoXb7
         CuYqX6HtBJEl7yOy8tE3CbgH2a9QuAhgQH0TMKy6gIwD8vuHiQY14lGwrbFvySHqxjcW
         UHWAke4bMF7QCgim7nTrat4IpktRIS4roz/VIcQX5Tyx5Mc3q8mmJStRrFEcodzEy9VI
         XUqcI0Leb2W5ruN5ngLNBSm4rP1RDU/TYfcc9QEzXLb0+IXTjftKOL6d3GVh+lQTWdfp
         ZTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679063612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pr8i0Eumz09pFpMEBVzLFDV1F++dQdI0hyhxEAp2n3w=;
        b=0OSedUOCcbp5oUD7O31/tcVH2zo71YBux7T1GEzixzVyAahWMf4Z1eh38b0zdsEv5+
         2u/p3jfW7AjmZyCtabdwP7Xue46inAc6xNOoviBIaKpGG/HYnu7tytcJ1IdyZWchMeX0
         mo2bhhyNZvoo80cPSuiCDQB5R9kvFx+IPKvTTg9V2nxMS7NxP6yW7NQ16vrmAxgzxMa0
         KdH6c/7wLSZolsS6fiJrVCvCYYoURjm5AXtQT9YpRHpc6qk3f4emApnpwssIkl0cEqIk
         /l2N2/+CdBcxddee3GilEF1PhuJRpwjY45ychhlLeSTYw6l1m/WNRJLlMDjQC/ZThrSi
         GLpA==
X-Gm-Message-State: AO0yUKXvXXk3aEM2L51xJVHz45qwkp5q/RFPXiExsFNjdd1syxn50HYK
        nSrl5PZjpIiFXgSmrkKsbERw/nmV5o9AszEh
X-Google-Smtp-Source: AK7set/+ZPVsiYqB7Hdp5WNTZma1qHm7dbiDdmEBcxtiq5xxh7zeGKnvdJNfz8Sgi+ddXtHaCz11zbRlVfE7ArBN
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:efc1:0:b0:2cf:e74f:c5b1 with SMTP
 id i1-20020adfefc1000000b002cfe74fc5b1mr653973wrp.7.1679063612090; Fri, 17
 Mar 2023 07:33:32 -0700 (PDT)
Date:   Fri, 17 Mar 2023 14:33:10 +0000
In-Reply-To: <20230317143310.1604700-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230317143310.1604700-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230317143310.1604700-3-vdonnefort@google.com>
Subject: [PATCH 2/2] tracing: Allow user-space mapping of the ring-buffer
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
limitations, it is imposible to do real-time analysis without a copy.

A solution for that problem is to let the user-space map the ring-buffer
directly.

The mapping exposed via the per-CPU file trace_pipe_raw. The first page
is the meta-page and is followed by each page of the ring-buffer,
ordered by their unique page ID. It is therefore easy to translate a
page-ID to an offset in the mapping.

  * Meta-page -- include/uapi/linux/trace_mmap.h for a description
  * Page ID 0
  * Page ID 1
     ...

The mapper must then do what use to be the kernel jobs: swap the reader
with the head. This is done with a newly introduced ioctl:
TRACE_MMAP_IOCTL_GET_READER_PAGE.

Entries, pages_touched and overrun fields are automatically updated by
the writer. Only readers keep the head page field updated. An additional
ioctl TRACE_MMAP_IOCTL_UPDATE_META_PAGE allows to query that update,
enabling non-consuming read from userspace.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index b5caed17a066..24bcec754a35 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -21,4 +21,7 @@ struct ring_buffer_meta_page {
 	__u32	data_pages[];
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)
+#define TRACE_MMAP_IOCTL_UPDATE_META_PAGE	_IO('T', 0x2)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 45551c7b4c36..51d06a2a7545 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6399,7 +6399,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8432,15 +8432,27 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
@@ -8453,6 +8465,60 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	return ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8461,6 +8527,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.40.0.rc1.284.g88254d51c5-goog

