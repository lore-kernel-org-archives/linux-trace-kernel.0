Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315281D5178
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766664689; cv=none; b=Xa3KxLkTeJAbYII0KKPWcSmRtp4UFGoPvxOKAq+tc1i2axYLfG0m3qLMoZQip4zPWyd+PjP1jzCxPmMnExVe7Cs4Lg1h+ZWxIt1H3Ikf0ZsJ9lNauy9UYcgymeL/K2w4lZQfxGEBX8G1Y8b5oKZhERGbdPHGNWMRf6nDbz6JCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766664689; c=relaxed/simple;
	bh=8rDyRCgIjsUhiqcvzxkerAqwGCdejD5NJQIxTlkudB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p2recKjaFxnbn9l6P7HYIgnG3v2adhOaaOovk59+UDDdRfQ5X10WWg2aJb2+/0sVGVN2sFc8J1DtW1qAIOqNZlJIgjUZ97n6KC+YaR77Cunw3NXYW+AZnANwHUN/WrfQzx/sM7M5ie3Slj7ViBmUrNKRSaDb1Z2Ke5hfFN29owA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzRLhTpo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzRLhTpo"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a2ea96930cso75078655ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 04:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766664687; x=1767269487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/qVfC/AvRydB28Fs2EBUThXHyWI75iS6yLDDHLqZDk=;
        b=CzRLhTpoa4IXAxQhckwWD8nzsoeDybTQRLeCFg4mu1NN1psC/cwGlq/A0LIVPW3JYu
         JBVXHi0YOKdve9rDHoH7Wgg8I802A7ehjNhdGTQ08DEEUntj0ekBaGqtWngGZHcKD7i5
         8Ds8I3bDERwmhum3vYseh7MUUzkSNaLhNY+JGyqXs2ksqhgIXS23muG42tHILv4bWa1C
         JWCm+y/+nXxJJRKR9da4PoICsQw/q6AI3cuwF6kgOgII2iuA3VgjX4omgMSIEsv1M5l1
         isaYpDqTHF6T7qeYPbj35xcwYmqOD6VYGPbyx4HUbKAQ9AgQYBlCblcJ7mTEOcpQk+XC
         yFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766664687; x=1767269487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/qVfC/AvRydB28Fs2EBUThXHyWI75iS6yLDDHLqZDk=;
        b=h9u2GT6t+i7JT5pAfYerT1p2zsfGdf4TwD1aW99xA3IGvDJMRwJQdpetqvyONRJdP5
         46oL1AeO/y9CCyL0ML5z7tFar/6Fhoc5U8wkeu++s6UUpfixwqyVp90pkAV0Gy1H6uNt
         X5ibN+VVE0+bWFrz2ROI8WySOOIp6gCRif3A1G5gxY/pdYFWNLTjHMS1gPjfZR+4Dw6D
         FACqZwYDA7IWlvdajYMaVMbO/TUnOCX1Rbaka/v8LIF80rRkxM5r7PTZfplGfkj5t7dp
         /MnnaUmQjoG1vcRPtlY0cGLk+RPt5uqqY731OhDnBPNtzO0b8v8K8Cn7ZgB973rKbz3l
         hR2g==
X-Forwarded-Encrypted: i=1; AJvYcCVkxQXC8VkdUoPxYXJr2drlRbeXhAluUD9NJleT2Nxt1CCFAVH0ytRxRdG9rZN80WVrPHcf4mN+o6Bk/Bawf5Kc09A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1zMphk4arnCHetVM8ANcakuNUbbCV3OV5ixT0i297vXSkc3/
	1wrEWXhmbhh8sj7RkM10X8Ks0vMj5jfhGxcvYg+579oiY6zNRWrwlqsZ
X-Gm-Gg: AY/fxX7gyhIqJ1MP9zr+S+JaVNByED5RRQXRU6NIJcYxXEr5IyiDfcperIOyI/WIK3f
	2AsyeAXa5Fa5HcC3VJC/+yzCvqXJ2j3dxAYT3xWwTDosxwn7z+xiPaIL5DxOkGBWEgV5WxNBAJF
	w79lD28JsrX2DJjF/5EJdqtiIRSYaktl1AiP+SWwz9iDJgcDyAdltmDudv17Se4Ih6+pQemxFSy
	MJIem+FSid8Yv+fdiLZ3fstnwWvCfUtCQDKhZEcw/Mny3OsUnNTPAickM2CfIETXTJ+GFBaOyzZ
	jhoxw+eNCo5SAMLdUDv049x3xWPNWt2fxd38k07khxld5/CAEfFZ6Y377tj04ZWKd6uLJJgdYfD
	bnAhWtp1MD49OGcvZcYDz1EIjphi6xKR5r8FMYTuVvel2UnF+gAzDzvTp1rFoNI6mm9Tjq39q/V
	LZIYoWIrotm4Px7ShDAU4k
X-Google-Smtp-Source: AGHT+IGKSGLk+HAEoaCu8V384ucYE3DTSdv9SDdoysVjqmukISJp3LxTXqZw/EKDCi7QbOEAX6pb+g==
X-Received: by 2002:a17:903:19ef:b0:2a0:daa7:8a3d with SMTP id d9443c01a7336-2a2f2329b79mr206038155ad.23.1766664687443;
        Thu, 25 Dec 2025 04:11:27 -0800 (PST)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d3e1sm177780205ad.76.2025.12.25.04.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 04:11:26 -0800 (PST)
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
Subject: [PATCH v11] dma-buf: add some tracepoints to debug.
Date: Thu, 25 Dec 2025 20:11:19 +0800
Message-Id: <20251225121119.2194228-1-gxxa03070307@gmail.com>
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

Changes since v10: https://lore.kernel.org/all/20251224013455.1649879-1-gxxa03070307@gmail.com/
Changes since v9: https://lore.kernel.org/all/20251223032749.1371913-1-gxxa03070307@gmail.com/
Changes since v8: https://lore.kernel.org/all/20251218062853.819744-1-gxxa03070307@gmail.com/
Changes since v7: https://lore.kernel.org/all/20251217105132.643300-1-gxxa03070307@gmail.com/
Changes since v6: https://lore.kernel.org/all/20251216063952.516364-1-gxxa03070307@gmail.com/
Changes since v5: https://lore.kernel.org/all/20251201112148.843572-1-gxxa03070307@gmail.com/
Changes since v4: https://lore.kernel.org/all/20251128085215.550100-1-gxxa03070307@gmail.com/
Changes since v3: https://lore.kernel.org/all/20251127004352.376307-1-gxxa03070307@gmail.com/
Changes since v2: https://lore.kernel.org/all/20251125162949.220488-1-gxxa03070307@gmail.com/
Changes since v1: https://lore.kernel.org/all/20251124133648.72668-1-gxxa03070307@gmail.com/

 drivers/dma-buf/dma-buf.c      |  48 +++++++++-
 include/trace/events/dma_buf.h | 159 +++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/dma_buf.h

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index edaa9e4ee4ae..dee59d4c0b12 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -35,6 +35,26 @@
 
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
+	do {								\
+		/* Always expose lock if lockdep is enabled */		\
+		if (IS_ENABLED(CONFIG_LOCKDEP) || FUNC##_enabled()) {	\
+			guard(spinlock)(&dmabuf->name_lock);		\
+			FUNC(__VA_ARGS__);				\
+		}							\
+	} while (0)
+
 static inline int is_dma_buf_file(struct file *);
 
 static DEFINE_MUTEX(dmabuf_list_mutex);
@@ -220,6 +240,8 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 	    dmabuf->size >> PAGE_SHIFT)
 		return -EINVAL;
 
+	DMA_BUF_TRACE(trace_dma_buf_mmap_internal, dmabuf);
+
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 
@@ -745,6 +767,8 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	__dma_buf_list_add(dmabuf);
 
+	DMA_BUF_TRACE(trace_dma_buf_export, dmabuf);
+
 	return dmabuf;
 
 err_dmabuf:
@@ -768,10 +792,15 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_export, "DMA_BUF");
  */
 int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 {
+	int fd;
+
 	if (!dmabuf || !dmabuf->file)
 		return -EINVAL;
 
-	return FD_ADD(flags, dmabuf->file);
+	fd = FD_ADD(flags, dmabuf->file);
+	DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
+
+	return fd;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 
@@ -786,6 +815,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 struct dma_buf *dma_buf_get(int fd)
 {
 	struct file *file;
+	struct dma_buf *dmabuf;
 
 	file = fget(fd);
 
@@ -797,7 +827,11 @@ struct dma_buf *dma_buf_get(int fd)
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
 
@@ -817,6 +851,8 @@ void dma_buf_put(struct dma_buf *dmabuf)
 		return;
 
 	fput(dmabuf->file);
+
+	DMA_BUF_TRACE(trace_dma_buf_put, dmabuf);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
@@ -971,6 +1007,9 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
 	list_add(&attach->node, &dmabuf->attachments);
 	dma_resv_unlock(dmabuf->resv);
 
+	DMA_BUF_TRACE(trace_dma_buf_dynamic_attach, dmabuf, attach,
+		dma_buf_attachment_is_dynamic(attach), dev);
+
 	return attach;
 
 err_attach:
@@ -1015,6 +1054,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 	if (dmabuf->ops->detach)
 		dmabuf->ops->detach(dmabuf, attach);
 
+	DMA_BUF_TRACE(trace_dma_buf_detach, dmabuf, attach,
+		dma_buf_attachment_is_dynamic(attach), attach->dev);
+
 	kfree(attach);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_detach, "DMA_BUF");
@@ -1480,6 +1522,8 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 	vma_set_file(vma, dmabuf->file);
 	vma->vm_pgoff = pgoff;
 
+	DMA_BUF_TRACE(trace_dma_buf_mmap, dmabuf);
+
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, "DMA_BUF");
diff --git a/include/trace/events/dma_buf.h b/include/trace/events/dma_buf.h
new file mode 100644
index 000000000000..3bb88d05bcc8
--- /dev/null
+++ b/include/trace/events/dma_buf.h
@@ -0,0 +1,159 @@
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
+		__string(	dev_name,			dev_name(dev))
+		__string(	exp_name,			dmabuf->exp_name)
+		__field(	size_t,				size)
+		__field(	ino_t,				ino)
+		__field(	struct dma_buf_attachment *,	attach)
+		__field(	bool,				is_dynamic)
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
+		__entry->fd	= fd;
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
+DEFINE_EVENT_CONDITION(dma_buf_fd, dma_buf_fd,
+
+	TP_PROTO(struct dma_buf *dmabuf, int fd),
+
+	TP_ARGS(dmabuf, fd),
+
+	TP_CONDITION(fd >= 0)
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

