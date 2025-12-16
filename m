Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E883358DF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867220; cv=none; b=ir21WcE6gFhLEWyP3ZeWUrHlYfFm2l7n4PheiFWJjoj9s7LoEgaInA+bUhuJQj+HNc++q9/z0EcaIZs2tMuNfKdBKoWJVOlP1HMIOx005m4XRidfXScNw0lFAZ1FO4lwAzWSRdtbLW/29wHkYJoxiOpBsVy+88vtWqzciEP+gEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867220; c=relaxed/simple;
	bh=5cCqxAsIb+pe2OfGUOMv+i65IXRjCVwzrlJiPOfhvFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1wcdZNSyJ1cwpC7l6K996BV85Twj0I3fo+osjH22AvirFfKBregtRAK8Kh18j5NVS1N3qGZ+xV16kPye09WrfAWVkCeOG9EenO2NyycUX/iczoSIlWGV4OIObAwjlVkjnfCwT569ycVu/vm1v6sgYCpn4UKAVULyeEY+Gx6rGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tns92DqV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tns92DqV"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso6399361b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Dec 2025 22:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765867205; x=1766472005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg+4fJFzdGn98FzAnl0v5lB7PczGqqfyNaIVae6fwYU=;
        b=Tns92DqV0v1L7O4KNzOcrEz7ifqcnyF+nL95tlETlrL5NC8TpH1RbM3KZX5E/zEfvL
         fq5OgrBUl/lQv1RBk2pqizshodvNgt3FrF8bObLlDnRpr67c18rVU61WcJHe2aoViwwa
         j530WSmEV1oFPsP6pJ0NfHIIuLUxBdMBXY9bRUQo4TMWjCKq+VA3/ry502NTlKmXEwUj
         1lA8keJPTROF/wOxe7K6CUDgge893sfCneENIHZLAWuz2hO/Ma/wbO2GHWSB9Ogn3ARQ
         6UnjwNAQHqXCrk9/GPcP7m+aTrM+lZUkBAooRG+aIX+6XgveZ2UCHJ8jbSVbeBXBzc1R
         CbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765867205; x=1766472005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg+4fJFzdGn98FzAnl0v5lB7PczGqqfyNaIVae6fwYU=;
        b=SG8rHiwYU1XbMulqlqki2IvXzb3BHEQVhN+wSNIQf8sDrUQ3eEzFQrCB1a45nMiMT3
         UFOMp5RZtYzTOzeQt/OyVyasjIjrOtbsCREEI/kBYwQMQczyrkIdYjei4aRkeB1Bx2B7
         rjGcXccx+DX77YrHUMgOeZRNdpohyf2pKIjJ1u60vpA3TTl3CoI8NMI5f+RiKZCtvFQ/
         Gciet6CQ/upV8ycTX5f/0V+3zUPgnjyFpaJ3Tvx/2OUNNkz81q6k8ywqTYriwiB3Kw3D
         +TuMkClIyI0ucMr/MFM7IhP23rIaVYPRgnaotS5fjbuRxPVGynSapBG8MRU9KYNF8dAf
         GxIA==
X-Forwarded-Encrypted: i=1; AJvYcCUT4M+6sPodrrarbI1TAkdaSGfW68VOh3/RlSuXSSaWSUT7FyFU5VT5uyaqtVAT+I4aSR6yfSSDeb4rgPR0oYLgtAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6ezC/FFajiCnPEKcoqtOncVCBhinN9BhuBgQWmioBQS/cfF5
	D4BfWdPP2gNPCQQKHQ451bsfV4NoXNH2N9W8r38tvoP6tFz3CIf71HikgmdgJw==
X-Gm-Gg: AY/fxX7ymUwmFC+/NLmFOmhbo2/AMoJ0QryNbl687lm9BWyI5yGmadVVTVu8zWevivF
	ZATgoNZ5KstDo52Kw9xZMqm5b6CwYZLkiy911TG3xTxPx2uSrGQlnMq26ZuIRoTJxacaY9hQPNa
	rQh8+Z9lMz2m+9eht7nBQMnjUuj/juNW8iuIQ+mWzGPGbWfyIuIu71w8gVNRkLYS0kGmk4Q6o6R
	0Tfi7/YhFzwjczdVcm74YccLsE/TgB1yOJ0tDM7yIXeeRbujDWywfpQZ+H+NCvX314htkjg6cmd
	bfIWBx1x29ZXT1uQejhygyjA9uIjWPqaZj2jP2DdZCnAru+2p+s3/vFJTDB8jecBisv/TSpDzyb
	ZDbK3AyMHxetnUs+lY/GlkFdOLe7UKOsmtfTp377MM+TWH/NqE6ET4YEORfd/Sk6y20sc8yex4m
	dVxUEjwpvQDxgC3g329prG
X-Google-Smtp-Source: AGHT+IFUe+Cj7o/VwampK5l2braADbi/l+h05PjVtnGg9s2uaqhmXbwcPzsvzvSt/zsFVsg1Oslm+A==
X-Received: by 2002:a05:6a00:138e:b0:7f7:612e:461e with SMTP id d2e1a72fcca58-7f7612e46e6mr11323604b3a.57.1765867205166;
        Mon, 15 Dec 2025 22:40:05 -0800 (PST)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f634c229b9sm11325856b3a.43.2025.12.15.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:40:04 -0800 (PST)
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
Subject: [PATCH v6] dma-buf: add some tracepoints to debug.
Date: Tue, 16 Dec 2025 14:39:52 +0800
Message-Id: <20251216063952.516364-1-gxxa03070307@gmail.com>
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
 drivers/dma-buf/dma-buf.c      |  42 ++++++++-
 include/trace/events/dma_buf.h | 154 +++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/dma_buf.h

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 2bcf9ceca997..831973de76c4 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -35,6 +35,25 @@
 
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
+#define DMA_BUF_TRACE(FUNC, ...)                  \
+    do {                                          \
+        if (FUNC##_enabled()) {                   \
+            guard(spinlock)(&dmabuf->name_lock); \
+            FUNC(__VA_ARGS__);                    \
+        }                                         \
+    } while (0)
+
 static inline int is_dma_buf_file(struct file *);
 
 static DEFINE_MUTEX(dmabuf_list_mutex);
@@ -220,6 +239,8 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 	    dmabuf->size >> PAGE_SHIFT)
 		return -EINVAL;
 
+	DMA_BUF_TRACE(trace_dma_buf_mmap_internal, dmabuf);
+
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 
@@ -745,6 +766,8 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	__dma_buf_list_add(dmabuf);
 
+	DMA_BUF_TRACE(trace_dma_buf_export, dmabuf);
+
 	return dmabuf;
 
 err_dmabuf:
@@ -779,6 +802,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 
 	fd_install(fd, dmabuf->file);
 
+	DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
+
 	return fd;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
@@ -794,6 +819,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 struct dma_buf *dma_buf_get(int fd)
 {
 	struct file *file;
+	struct dma_buf *dmabuf;
 
 	file = fget(fd);
 
@@ -805,7 +831,11 @@ struct dma_buf *dma_buf_get(int fd)
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
 
@@ -825,6 +855,8 @@ void dma_buf_put(struct dma_buf *dmabuf)
 		return;
 
 	fput(dmabuf->file);
+
+	DMA_BUF_TRACE(trace_dma_buf_put, dmabuf);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
@@ -979,6 +1011,9 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
 	list_add(&attach->node, &dmabuf->attachments);
 	dma_resv_unlock(dmabuf->resv);
 
+	DMA_BUF_TRACE(trace_dma_buf_dynamic_attach, dmabuf, attach,
+		dma_buf_attachment_is_dynamic(attach), dev);
+
 	return attach;
 
 err_attach:
@@ -1023,6 +1058,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 	if (dmabuf->ops->detach)
 		dmabuf->ops->detach(dmabuf, attach);
 
+	DMA_BUF_TRACE(trace_dma_buf_detach, dmabuf, attach,
+		dma_buf_attachment_is_dynamic(attach), attach->dev);
+
 	kfree(attach);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_detach, "DMA_BUF");
@@ -1488,6 +1526,8 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 	vma_set_file(vma, dmabuf->file);
 	vma->vm_pgoff = pgoff;
 
+	DMA_BUF_TRACE(trace_dma_buf_mmap, dmabuf);
+
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, "DMA_BUF");
diff --git a/include/trace/events/dma_buf.h b/include/trace/events/dma_buf.h
new file mode 100644
index 000000000000..81ee4d05979c
--- /dev/null
+++ b/include/trace/events/dma_buf.h
@@ -0,0 +1,154 @@
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
+		__string(exp_name, dmabuf->exp_name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
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
+	TP_PROTO(struct dma_buf *dmabuf, struct dma_buf_attachment *attach, bool is_dynamic, struct device *dev),
+
+	TP_ARGS(dmabuf, attach, is_dynamic, dev),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__string(exp_name, dmabuf->exp_name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(struct dma_buf_attachment *, attach)
+		__field(bool, is_dynamic)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name);
+		__assign_str(exp_name);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->is_dynamic = is_dynamic;
+		__entry->attach = attach;
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
+		__string(exp_name, dmabuf->exp_name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(int, fd)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->fd = fd;
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
+	TP_PROTO(struct dma_buf *dmabuf, struct dma_buf_attachment *attach, bool is_dynamic, struct device *dev),
+
+	TP_ARGS(dmabuf, attach, is_dynamic, dev)
+);
+
+DEFINE_EVENT(dma_buf_attach_dev, dma_buf_detach,
+
+	TP_PROTO(struct dma_buf *dmabuf, struct dma_buf_attachment *attach, bool is_dynamic, struct device *dev),
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

