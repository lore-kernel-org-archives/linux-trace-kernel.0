Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FF7248883
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588118; cv=none; b=PESLW4h46APTJYTwIFuSOVbSYY0uMMlhj4+8I5JNM2NhkuxeqW8sfKfqMzqRJqgjH+JBtggrhJU9OgrMIYcnFQq76/Xx0R5aqpZpWH3EOy1sQsmrFSNZaDWdymMWMY0TgRWI8guGx2j2/oTIRUkG8T9z8l+mZ5ss8fee+gjGFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588118; c=relaxed/simple;
	bh=VPMcWZXlPTKSjZXc32gmCjWBiBsJ4i0jSQ1HiFRWSVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyuLysXC3sA0npTQ1t0NXXLpy+6zNpLT5zFzX9htBCp2Zaj1hgmi8fgfGlfvhq6Gd9O2pkwyymQzcKZ7C0Dg8YBPFyP+fgayinKxDS/cVirOkbrn1Mu8r6FOuZDHvBdhuQ7FV6jbvxnx2MvqFcOidqeVDR3rcHZrUssqSqMQQfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NliXAGQu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NliXAGQu"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso4831560b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 03:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764588116; x=1765192916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLEoVh5V6KL4DPldRLgtrXwzYkYlClTOMyNoGl8minI=;
        b=NliXAGQuMdYIcu+Zl0Egk2GWw4XrYTTO1KAfWgSO0PrkBJTLMcTSzXy2mAWUL97CbU
         RzU/8TSUhlIf2bdro7R8uuynZ2AsPHyGl/lZSOGY39O6Qp19Fucdh7yJjQKFWTG5aZe+
         mcry3bfkI1LTJiO0lI7YmYFj63jdhqJ4VJ0dJd66r8ZQNK+qoj+Y7aeCaJvFV/w/UHyo
         lbofutTbtw54JsFfMO1jw9dpwxORzUP/ztI22/otR3jx/1an428SIChxjjPKwcXlH7wC
         UhbOZn/iSxi7eMP6AV+c0sqhlZbbIsRcJmbFgrK+SaKAwt3eu58Yuy+x82yGhT9r9EDy
         Z23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764588116; x=1765192916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLEoVh5V6KL4DPldRLgtrXwzYkYlClTOMyNoGl8minI=;
        b=Al4Y5JzzQ2YvGPP49WoogG9WYwJafJBc/qNgLRjpvV8g0WOY6n+DFDVdDjo7tnO4nm
         91xJn8PRnySNLigDTpFqXA5kmBKwK5IRdofFHblcxWauF7llCfMh4dI4XTTEtrOuw4Dy
         AokplH5LUOH+j5VWDsIHh9bSeQ3AiCITVbJNed2wo2t216CmJCw6WwNuPjgSvMrnakCo
         ori9M8nyiMMQsw/c4EtD8doTiLvH3N/WCYPY+frW1MIi7CHPrlkKcTiTZq0vA7dgqL8h
         btjalb4X4F0kj3qIEhs6S2sHNcAO0tYi4rqh9J1/RGwkxoVwntLOg0rQSvTcJhAIlxpQ
         I8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCX0cPfjzwd/Wm0cQXLMkf8Py0vwM6VSUTC/utHeU19TwPDOaHrmrc9HnrZeBKbj3hf9NZ03XhEPm0xLFLPrq68Lj/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoTUNlokTQFRhPLVbRbeP9QRGQ+xuAp1JSiPNvO6EBiAFF+aUs
	AjhK9CtH4yPwOOYKO81t01GZIA8hCCfZpLNgkw5dqCJp9kRhYnGfdVTd
X-Gm-Gg: ASbGncv2tiESMNWm8GAZweTpLonXojwRw0Dbw3bncXEepQoFBR54JMkBFm186KMNiIg
	XFtU4OZLy1nbGI2iyKbHEK6VdIFDpWbAdziWGSnT3UiMYY3QGIkNee6UY9XK1SbtIeFTZGr7W+K
	9MWxyB9b9xHhnML5P7SjWX1+5OtAjtrx0CXy6LCtlS+EKpQUO0J5hi68LiIQKRB50b/xq1R4Z75
	B5LO6U/qdUz2JgfEf0SXf2ZXv7EjYmE5t6yXtb3XRQ1ZhYQ6w+GsAOH2/2nfMrMnb3Uuc8vVxcB
	4YV4si/30QgzLjuFtLJ54ugvazXfbArMawhAK3hm2IKsju59CfzSFvFniQsB33hEI6J7zVhfamv
	iNmMgpaJ1Rq/MLYQg5sFSyS755enu3jK0mLFjVHxfRjFexPTt5DOsNI9XoiMsz2gf87dCXEgU92
	lZCpMO4mMhIuwGHo1FEtNF/S8XTwPuxdo=
X-Google-Smtp-Source: AGHT+IG8yzad/QJdYWQN8COSv2tXagPdX30bTvEdOFoh8MH8FuOVBDhI+7MvQ4WDkTSTqw06Vd9UnA==
X-Received: by 2002:a05:6a00:9a4:b0:7b1:79be:1273 with SMTP id d2e1a72fcca58-7c58e608b0fmr40271597b3a.26.1764588115849;
        Mon, 01 Dec 2025 03:21:55 -0800 (PST)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fb1486asm13213642b3a.61.2025.12.01.03.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 03:21:55 -0800 (PST)
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
Subject: [PATCH v5] dma-buf: add some tracepoints to debug.
Date: Mon,  1 Dec 2025 19:21:48 +0800
Message-Id: <20251201112148.843572-1-gxxa03070307@gmail.com>
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
 drivers/dma-buf/dma-buf.c      |  34 +++++++-
 include/trace/events/dma_buf.h | 154 +++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/dma_buf.h

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 2bcf9ceca997..fc05e2114922 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -35,6 +35,17 @@
 
 #include "dma-buf-sysfs-stats.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/dma_buf.h>
+
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
@@ -220,6 +231,8 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 	    dmabuf->size >> PAGE_SHIFT)
 		return -EINVAL;
 
+	DMA_BUF_TRACE(trace_dma_buf_mmap_internal, dmabuf);
+
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 
@@ -745,6 +758,8 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	__dma_buf_list_add(dmabuf);
 
+	DMA_BUF_TRACE(trace_dma_buf_export, dmabuf);
+
 	return dmabuf;
 
 err_dmabuf:
@@ -779,6 +794,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 
 	fd_install(fd, dmabuf->file);
 
+	DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
+
 	return fd;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
@@ -794,6 +811,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 struct dma_buf *dma_buf_get(int fd)
 {
 	struct file *file;
+	struct dma_buf *dmabuf;
 
 	file = fget(fd);
 
@@ -805,7 +823,11 @@ struct dma_buf *dma_buf_get(int fd)
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
 
@@ -825,6 +847,8 @@ void dma_buf_put(struct dma_buf *dmabuf)
 		return;
 
 	fput(dmabuf->file);
+
+	DMA_BUF_TRACE(trace_dma_buf_put, dmabuf);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
@@ -979,6 +1003,9 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
 	list_add(&attach->node, &dmabuf->attachments);
 	dma_resv_unlock(dmabuf->resv);
 
+	DMA_BUF_TRACE(trace_dma_buf_dynamic_attach, dmabuf, attach,
+		dma_buf_attachment_is_dynamic(attach), dev);
+
 	return attach;
 
 err_attach:
@@ -1023,6 +1050,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 	if (dmabuf->ops->detach)
 		dmabuf->ops->detach(dmabuf, attach);
 
+	DMA_BUF_TRACE(trace_dma_buf_detach, dmabuf, attach,
+		dma_buf_attachment_is_dynamic(attach), attach->dev);
+
 	kfree(attach);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_detach, "DMA_BUF");
@@ -1488,6 +1518,8 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
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

