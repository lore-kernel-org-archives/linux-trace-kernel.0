Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5312D5C97
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Dec 2025 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460479; cv=none; b=HOMWRPag/BvyABNBZ4o0H4Fjgsl3P2aPe+5MKNqNDvGE3vCNzlS6U8mTJT1q+WeXLh0XDZF7oruHganWOFqBJxpK4s1P0az6NLArjvuQ0ri78Kkh3ui/96HHfJZrtoYwuYa2EZ+T2rjqBqjb6HKzlho0pqNxk39jACukwCLQ2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460479; c=relaxed/simple;
	bh=Aq6vw8DIcTnST87Sv8e1OJVvAd1GQlVscl7U7z1YnhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tyUuhwkQwXO8DunF0whTFVIWFG6oK46dam/nyqg2WttyPr73JblWOrTD7dzjq0Tc8M7zC2HOdnLdCBhiDw5FqWcEyR/b+ommlW9x/A5ztn5isFT/KRYnxK6PV21ex/AdAbHaKaTxz8TEeqO1miJacvb7ARsE8samnf+HWrM/hBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTcqM5Oo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTcqM5Oo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29efd139227so61153045ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 19:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766460477; x=1767065277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab4p+/aVznaf6Y9Mhz8ivpKv029/o6M5Fe2zv+9dAX8=;
        b=eTcqM5OorLGZCuw/BZwNIZxiUnhdDO5xwN8BOxKUHO37veoQxmUjRNWm5uz2JcySzC
         pmHJqFTT88rj8AQAGh8IQLNxUMgBQkYyaQXGQchg2z2wDKJqvYSfTxXTUw3RNqjedz7a
         JAJ1S3I27sClDcNgZYBoFfx/rU1bw6PlGCka1wZVFshiP0cYzJaSL+UnP1kRQPeIp5ZH
         GXXAcVcFJQNhJsUSkVom4LBs4ceVwXPScx/OqrsKbn85taVUuqNEqZ7UdYl4FD+N3m8A
         ZYHhB1VJsk9JBzjcYwMYcl/Qpeqe/AhnL/wPXwnmDGUajRUl2f+uf8DiGmRQFfvAhO2H
         Dd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766460477; x=1767065277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab4p+/aVznaf6Y9Mhz8ivpKv029/o6M5Fe2zv+9dAX8=;
        b=aXCME1O9rebSCF8V9rnB0LMD+jtu1SbM39yRvtnp8NfbY5xecQVYpjAVUbn24IKqPq
         z2ZvyzZ7ViYQLCHRuGmxrNFp6KPnGp/DW4wZPXqPmLvQr3YQhMd/RDfHpmSLMif74qsl
         DfnxeXXfay+zIzfqLgRSGbba7fjgDUMNVIrsyOlcZtu6OD6Hwdi5C/A47Y1rgoGXxqYl
         9Rxx2W0IoPRpsJBEIQpljJKnulexwXBVTakDk4PY29M8fogiBDDCz4c6zgaKEq0EGd+q
         GigxCpKTQAmhVjRBOa+ZmXxthCYK4xkXzPjV7eiOdLUs9+NNVv9x1QX0NC70wBN5UXkE
         Zszg==
X-Forwarded-Encrypted: i=1; AJvYcCXUh10/3MQBqIIZ6Wid2wfEiu9xEmpZVyyOIgoMeSiBZZ67ECFOqD2YrMqNPXexOk17ZeQeeyk871HtPvrZYrOu2kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJKO92+zsDvTMrScXpIMSyi8ulUUvPoIkHJuiRsd42VbGOi5h
	E4iMtwFBJ74PxfNrUUnfou/auXfwTB44SEpGPELgzAKBQ2KOpqfn9Gr/
X-Gm-Gg: AY/fxX6KzDQ8JTlDzzlMgtp5Vz94MrHw9guoZjTgDNhNHJVXnp602XCQgFAY/VVDRj5
	pzdLipyW2jIBUtE/pq4nCGuC3fS8Dx+wZw8lCoiWM1gz8RK6cvUMrb9Opk2qmNhQvNyISynY5ma
	wtKaBkuTNkDYi7MWhE6lYTIc6vGhMibGALrUcIP3cA7GxVGobmoWpWv0P2I8jcJyznL/KPZH0P/
	97oqH8turOwKkIGJYa+e8SqDQgE5Fjx7WOlxOOAPtuMU0azl9UiydXNubMSo9i7wBBk4ZZnoU7D
	gcBD3JBVHbLVuJ7CoLGbxgUSAgY3y7UC6BrapURTZGOjcswkpOHXLL/iEEeJ+nxL07w2WWYarRT
	I/mbmY0Pdnr1lu538dWalCTg5mb4hljXVVnCKZUIBf3ocK5lO6dyuO99T9IX83wvV/qdZcOpWdx
	jNTOhJrFVYxUxTvUm2U6jz7CxEzipb3RU=
X-Google-Smtp-Source: AGHT+IEdS+hcn9kiPYyWfQulrFjERA/jJA+7E2ieEE0DP5n0BK+C7lII2uF2IU9TfEnVccS2jHpZZA==
X-Received: by 2002:a17:902:fc46:b0:2a0:9411:e8c0 with SMTP id d9443c01a7336-2a2f272bd84mr128067185ad.32.1766460476936;
        Mon, 22 Dec 2025 19:27:56 -0800 (PST)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8d10esm109486365ad.42.2025.12.22.19.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 19:27:56 -0800 (PST)
From: Xiang Gao <gxxa03070307@gmail.com>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	dhowells@redhat.com,
	kuba@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	linux-trace-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH v9] dma-buf: add some tracepoints to debug.
Date: Tue, 23 Dec 2025 11:27:49 +0800
Message-Id: <20251223032749.1371913-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

Since we can only inspect dmabuf by iterating over process FDs or the
dmabuf_list, we need to add our own tracepoints to track its status in
real time in production.

For example:
   binder:3016_1-3102    [006] ...1.   255.126521: dma_buf_export: exp_name=qcom,system size=12685312 ino=2738
   binder:3016_1-3102    [006] ...1.   255.126528: dma_buf_fd: exp_name=qcom,system size=12685312 ino=2738 fd=8
   binder:3016_1-3102    [006] ...1.   255.126642: dma_buf_mmap_internal: exp_name=qcom,system size=28672 ino=2739
     kworker/6:1-86      [006] ...1.   255.127194: dma_buf_put: exp_name=qcom,system size=12685312 ino=2738
    RenderThread-9293    [006] ...1.   316.618179: dma_buf_get: exp_name=qcom,system size=12771328 ino=2762 fd=176
    RenderThread-9293    [006] ...1.   316.618195: dma_buf_dynamic_attach: exp_name=qcom,system size=12771328 ino=2762 attachment:ffffff880a18dd00 is_dynamic=0 dev_name=kgsl-3d0
    RenderThread-9293    [006] ...1.   318.878220: dma_buf_detach: exp_name=qcom,system size=12771328 ino=2762 attachment:ffffff880a18dd00 is_dynamic=0 dev_name=kgsl-3d0

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 drivers/dma-buf/dma-buf.c      |  51 ++++++++++-
 include/trace/events/dma_buf.h | 157 +++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/dma_buf.h

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index edaa9e4ee4ae..59a5261cb26b 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -35,6 +35,28 @@
 
 #include "dma-buf-sysfs-stats.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/dma_buf.h>
+
+/*
+ * dmabuf->name must be accessed with holding dmabuf->name_lock.
+ * we need to take the lock around the tracepoint call itself where
+ * it is called in the code.
+ *
+ * Note: FUNC##_enabled() is a static branch that will only
+ *       be set when the trace event is enabled.
+ */
+#define DMA_BUF_TRACE(FUNC, ...)					\
+	do {											\
+		if (FUNC##_enabled()) {						\
+			guard(spinlock)(&dmabuf->name_lock);	\
+			FUNC(__VA_ARGS__);						\
+		} else if (IS_ENABLED(CONFIG_LOCKDEP)) {	\
+			/* Expose this lock when lockdep is enabled */	\
+			guard(spinlock)(&dmabuf->name_lock);	\
+		}											\
+	} while (0)
+
 static inline int is_dma_buf_file(struct file *);
 
 static DEFINE_MUTEX(dmabuf_list_mutex);
@@ -220,6 +242,8 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 	    dmabuf->size >> PAGE_SHIFT)
 		return -EINVAL;
 
+	DMA_BUF_TRACE(trace_dma_buf_mmap_internal, dmabuf);
+
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 
@@ -745,6 +769,8 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	__dma_buf_list_add(dmabuf);
 
+	DMA_BUF_TRACE(trace_dma_buf_export, dmabuf);
+
 	return dmabuf;
 
 err_dmabuf:
@@ -768,10 +794,16 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_export, "DMA_BUF");
  */
 int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 {
+	int fd;
+
 	if (!dmabuf || !dmabuf->file)
 		return -EINVAL;
 
-	return FD_ADD(flags, dmabuf->file);
+	fd = FD_ADD(flags, dmabuf->file);
+	if (fd >= 0)
+		DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
+
+	return fd;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 
@@ -786,6 +818,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 struct dma_buf *dma_buf_get(int fd)
 {
 	struct file *file;
+	struct dma_buf *dmabuf;
 
 	file = fget(fd);
 
@@ -797,7 +830,11 @@ struct dma_buf *dma_buf_get(int fd)
 		return ERR_PTR(-EINVAL);
 	}
 
-	return file->private_data;
+	dmabuf = file->private_data;
+
+	DMA_BUF_TRACE(trace_dma_buf_get, dmabuf, fd);
+
+	return dmabuf;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_get, "DMA_BUF");
 
@@ -817,6 +854,8 @@ void dma_buf_put(struct dma_buf *dmabuf)
 		return;
 
 	fput(dmabuf->file);
+
+	DMA_BUF_TRACE(trace_dma_buf_put, dmabuf);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
@@ -971,6 +1010,9 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
 	list_add(&attach->node, &dmabuf->attachments);
 	dma_resv_unlock(dmabuf->resv);
 
+	DMA_BUF_TRACE(trace_dma_buf_dynamic_attach, dmabuf, attach,
+		dma_buf_attachment_is_dynamic(attach), dev);
+
 	return attach;
 
 err_attach:
@@ -1015,6 +1057,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 	if (dmabuf->ops->detach)
 		dmabuf->ops->detach(dmabuf, attach);
 
+	DMA_BUF_TRACE(trace_dma_buf_detach, dmabuf, attach,
+		dma_buf_attachment_is_dynamic(attach), attach->dev);
+
 	kfree(attach);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_detach, "DMA_BUF");
@@ -1480,6 +1525,8 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 	vma_set_file(vma, dmabuf->file);
 	vma->vm_pgoff = pgoff;
 
+	DMA_BUF_TRACE(trace_dma_buf_mmap, dmabuf);
+
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, "DMA_BUF");
diff --git a/include/trace/events/dma_buf.h b/include/trace/events/dma_buf.h
new file mode 100644
index 000000000000..8c49341f60ef
--- /dev/null
+++ b/include/trace/events/dma_buf.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dma_buf
+
+#if !defined(_TRACE_DMA_BUF_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DMA_BUF_H
+
+#include <linux/dma-buf.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(dma_buf,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf),
+
+	TP_STRUCT__entry(
+		__string(	exp_name,		dmabuf->exp_name)
+		__field(	size_t,			size)
+		__field(	ino_t,			ino)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		__entry->size	= dmabuf->size;
+		__entry->ino	= dmabuf->file->f_inode->i_ino;
+	),
+
+	TP_printk("exp_name=%s size=%zu ino=%lu",
+		  __get_str(exp_name),
+		  __entry->size,
+		  __entry->ino)
+);
+
+DECLARE_EVENT_CLASS(dma_buf_attach_dev,
+
+	TP_PROTO(struct dma_buf *dmabuf, struct dma_buf_attachment *attach,
+		bool is_dynamic, struct device *dev),
+
+	TP_ARGS(dmabuf, attach, is_dynamic, dev),
+
+	TP_STRUCT__entry(
+		__string(	dev_name,						dev_name(dev))
+		__string(	exp_name,						dmabuf->exp_name)
+		__field(	size_t,							size)
+		__field(	ino_t,							ino)
+		__field(	struct dma_buf_attachment *,	attach)
+		__field(	bool,							is_dynamic)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name);
+		__assign_str(exp_name);
+		__entry->size		= dmabuf->size;
+		__entry->ino		= dmabuf->file->f_inode->i_ino;
+		__entry->is_dynamic	= is_dynamic;
+		__entry->attach		= attach;
+	),
+
+	TP_printk("exp_name=%s size=%zu ino=%lu attachment:%p is_dynamic=%d dev_name=%s",
+		  __get_str(exp_name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->attach,
+		  __entry->is_dynamic,
+		  __get_str(dev_name))
+);
+
+DECLARE_EVENT_CLASS(dma_buf_fd,
+
+	TP_PROTO(struct dma_buf *dmabuf, int fd),
+
+	TP_ARGS(dmabuf, fd),
+
+	TP_STRUCT__entry(
+		__string(	exp_name,		dmabuf->exp_name)
+		__field(	size_t,			size)
+		__field(	ino_t,			ino)
+		__field(	int,			fd)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		__entry->size	= dmabuf->size;
+		__entry->ino	= dmabuf->file->f_inode->i_ino;
+		__entry->fd		= fd;
+	),
+
+	TP_printk("exp_name=%s size=%zu ino=%lu fd=%d",
+		  __get_str(exp_name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->fd)
+);
+
+DEFINE_EVENT(dma_buf, dma_buf_export,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf)
+);
+
+DEFINE_EVENT(dma_buf, dma_buf_mmap_internal,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf)
+);
+
+DEFINE_EVENT(dma_buf, dma_buf_mmap,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf)
+);
+
+DEFINE_EVENT(dma_buf, dma_buf_put,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf)
+);
+
+DEFINE_EVENT(dma_buf_attach_dev, dma_buf_dynamic_attach,
+
+	TP_PROTO(struct dma_buf *dmabuf, struct dma_buf_attachment *attach,
+		bool is_dynamic, struct device *dev),
+
+	TP_ARGS(dmabuf, attach, is_dynamic, dev)
+);
+
+DEFINE_EVENT(dma_buf_attach_dev, dma_buf_detach,
+
+	TP_PROTO(struct dma_buf *dmabuf, struct dma_buf_attachment *attach,
+		bool is_dynamic, struct device *dev),
+
+	TP_ARGS(dmabuf, attach, is_dynamic, dev)
+);
+
+DEFINE_EVENT(dma_buf_fd, dma_buf_fd,
+
+	TP_PROTO(struct dma_buf *dmabuf, int fd),
+
+	TP_ARGS(dmabuf, fd)
+);
+
+DEFINE_EVENT(dma_buf_fd, dma_buf_get,
+
+	TP_PROTO(struct dma_buf *dmabuf, int fd),
+
+	TP_ARGS(dmabuf, fd)
+);
+
+#endif /* _TRACE_DMA_BUF_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.34.1

