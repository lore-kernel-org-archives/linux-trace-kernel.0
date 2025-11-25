Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B82D7DF2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088200; cv=none; b=fA2VncR0ZS3Q65vb8nBT5rtlrFh2LOKf/6B+FejFWTbeXTajjF2WY66G9pljfTRdd7nkGkwD++n3RO3btfF6mFh6r21p148vHR0VaqNJnvl6gPEUSqPUDEH9jriNC6V569sCH2IBJLxstPmrUOppQQ7p38q7wOSO7pkubig/kaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088200; c=relaxed/simple;
	bh=h0FFXIPxc6H2ca8EG1d2z8774anbR+o8zDpj4vRXyB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPDwAxMtsrFLAnjsYZuUvTUyRbZKC+jetTIq9EMB97PDP9JfMb0xXCV00uQV4mL8+7eqbe9i3oDnOHVd2b2Rm8oWj6+hUA61fPQiXYrE1itFdk8qVjDbC8L6BDp9GmCvO7IPYGncsxi78iKpMB75UTeuSySpl/EOVQ4KgJN1bfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/W55ULr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/W55ULr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4318751b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764088198; x=1764692998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WwtB7x9jbnj3BkBVwjT6kHA5QLKT/sBvVzDGMwM9kMs=;
        b=c/W55ULrSe9vemrZa/RNBwxYNJE/5LIWihsNQgR8nsy/zkR5bICyAU0TYVaasLsYBq
         7RGkOHMK+XiqaKvDyW8QyZSyag+IK7PriBrGcsSlCU8ICRcQ/l5gLHUJxxa57yVN2ucS
         oV2VS6KFBEkzZ8FkbqATVkWW5cCf7kR4wPxk7m1rSjN9Tg4kz292d8q3PQOE2vs9EImx
         +cJpCWuSNFUvHMoeVJzUgZDOdhyog3jvL9CiF+RCSsaFYCXh+bsZF0hYgPfRf2+5PKqj
         FPA6jrsdC1uxuWVUE6ZKJ9VIqHnU7hkxEy1RQmoC09v1Wr+C325rEup0GymJ3unE7g7i
         jhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764088198; x=1764692998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwtB7x9jbnj3BkBVwjT6kHA5QLKT/sBvVzDGMwM9kMs=;
        b=O9eHUrDhgp0hT8ZOht9AswpbY+c1Sr9H2agcEpKWEmBx/btjSKlQIbqquVDyVDutsn
         NFUXzyQZmfAd3siUafE1k/KgChuZWMpd/v2OBYSZHz2DOz4sKOKqPDPTnWGyZ39LJZdf
         dM14tRYgP+YWjuWjSWjDPjknvx92Y+kIODsSLYNt/ZGTxgsHrVpzNVbxPZMcDuWjr1gs
         GzrPiVBEjQrmhGv4OVM/9dxRXNofe/+HB0/+3DPFgSfDzPhBI1suvj4Wm1osJoUsaIVG
         +QxngKJa6v8+oRza3r/vByTq/OFKtG5bHQnea+d8DYQOB7Ew7B9NddvUskJQTJFPq3mw
         6dGg==
X-Forwarded-Encrypted: i=1; AJvYcCVhr7qAQMCAwLqZHjPTonwSgoGJhEomIZdiLrxF6PyVSa+jsjYPNaXnrjNqB0A2j7eU+Fcd+7ybY0XbVVasbF1OC+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76ZAAfUiw1Oz44gEulpNnKA9RzpzSkdSQ6AO6c22UMOof8wmb
	WmbeooQSYCcqIucA4W+md+OKKZtVwukxt9kw8F+txPupbk+JP+6TGWRZ
X-Gm-Gg: ASbGncs0iewOTzPgP2zen+jBVDYuTwF+Honbtd6U/Vgw9mSdnto8fRm/LRKLmVkg4hR
	X+u9QWmGIAxlsGCt2cYGhsrOBbWho5XO7n6qN8vOD+VDvkgGHXTmjWAXuPM5IcexK83QCsZwNPQ
	nwya4xonyAEFrpYqiXyrIOm2RGZetnE46I/0a1zYbncF4QIsCWfwegrGL8KgzNDE0yrJL8gdg2s
	v7sv45/EQ8e5lSCtsoy0NMYpMECnju/djGw+VySO4cTCUuoBvYeHyR9thRUM7JBfVPPrTVMUYsE
	7BsL1iJ0BJJs7lHSCfXK2Dd87dDlGkhX10J9O4CpTYfTe1M6SczMo7eEcAZ/NGFzhf0U1JFnNct
	ELk59J6tStQ7OwpPjKfVwfMW2lE4McDzBhOs1JlSzKb2N8Db6vO4f+i81S24xCMYrpdy2xpdFla
	Sl7LibzA==
X-Google-Smtp-Source: AGHT+IH5VsEgKVWLFjZB0z7fH5JXEPDjqE0RvxYdxUOT95d5pZGo+nIy5F29wx/dgZIyyG1Bi/NSdA==
X-Received: by 2002:a05:6a20:2583:b0:35d:53dc:cb57 with SMTP id adf61e73a8af0-3637e0a58c8mr3790560637.49.1764088197837;
        Tue, 25 Nov 2025 08:29:57 -0800 (PST)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174d2c0sm18544900b3a.66.2025.11.25.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:29:56 -0800 (PST)
From: Xiang Gao <gxxa03070307@gmail.com>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	dhowells@redhat.com,
	kuba@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	linux-trace-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH v2] dma-buf: add some tracepoints to debug.
Date: Wed, 26 Nov 2025 00:29:49 +0800
Message-Id: <20251125162949.220488-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

I want to track the status of dmabuf in real time in the production environment. 
But now we can only check it by traversing the fd in the process or dmabuf_list.

For example:
    <...>-8342    [006] .....   199.626433: dma_buf_export: exp_name=system name=(null) size=32768 ino=2337 f_refcnt=2
    <...>-8342    [006] .....   199.626436: dma_buf_fd: exp_name=system name=(null) size=32768 ino=2337 fd=853 f_refcnt=2
    <...>-8342    [006] .....   199.626472: dma_buf_mmap_internal: exp_name=system name=system size=32768 ino=2337 f_refcnt=6
    <...>-3199    [006] .....   200.719182: dma_buf_get: exp_name=qcom,system name=acb size=184320 ino=2331 fd=111 f_refcnt=6
    <...>-894     [006] .....   199.632342: dma_buf_put: exp_name=system name=system size=32768 ino=2337 f_refcnt=2
    <...>-3199    [003] .....   213.402200: dma_buf_attach: dev_name=soc:qcom,xxx exp_name=qcom,system name=acb size=184320 ino=2331 f_refcnt=7
    <...>-1229    [004] .....   213.850270: dma_buf_detach: exp_name=qcom,system name=acb size=184320 ino=2331 f_refcnt=6

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 drivers/dma-buf/dma-buf.c      |  19 +++
 include/trace/events/dma_buf.h | 281 +++++++++++++++++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 include/trace/events/dma_buf.h

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 2bcf9ceca997..8b5af73f0218 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -35,6 +35,9 @@
 
 #include "dma-buf-sysfs-stats.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/dma_buf.h>
+
 static inline int is_dma_buf_file(struct file *);
 
 static DEFINE_MUTEX(dmabuf_list_mutex);
@@ -220,6 +223,8 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 	    dmabuf->size >> PAGE_SHIFT)
 		return -EINVAL;
 
+	trace_dma_buf_mmap_internal(dmabuf);
+
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 
@@ -745,6 +750,8 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	__dma_buf_list_add(dmabuf);
 
+	trace_dma_buf_export(dmabuf);
+
 	return dmabuf;
 
 err_dmabuf:
@@ -779,6 +786,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 
 	fd_install(fd, dmabuf->file);
 
+	trace_dma_buf_fd(dmabuf, fd);
+
 	return fd;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
@@ -805,6 +814,8 @@ struct dma_buf *dma_buf_get(int fd)
 		return ERR_PTR(-EINVAL);
 	}
 
+	trace_dma_buf_get(fd, file);
+
 	return file->private_data;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_get, "DMA_BUF");
@@ -825,6 +836,8 @@ void dma_buf_put(struct dma_buf *dmabuf)
 		return;
 
 	fput(dmabuf->file);
+
+	trace_dma_buf_put(dmabuf);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
 
@@ -998,6 +1011,8 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_dynamic_attach, "DMA_BUF");
 struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
 					  struct device *dev)
 {
+	trace_dma_buf_attach(dmabuf, dev);
+
 	return dma_buf_dynamic_attach(dmabuf, dev, NULL, NULL);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_attach, "DMA_BUF");
@@ -1024,6 +1039,8 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 		dmabuf->ops->detach(dmabuf, attach);
 
 	kfree(attach);
+
+	trace_dma_buf_detach(dmabuf);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_detach, "DMA_BUF");
 
@@ -1488,6 +1505,8 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 	vma_set_file(vma, dmabuf->file);
 	vma->vm_pgoff = pgoff;
 
+	trace_dma_buf_mmap(dmabuf);
+
 	return dmabuf->ops->mmap(dmabuf, vma);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, "DMA_BUF");
diff --git a/include/trace/events/dma_buf.h b/include/trace/events/dma_buf.h
new file mode 100644
index 000000000000..ab593dea4617
--- /dev/null
+++ b/include/trace/events/dma_buf.h
@@ -0,0 +1,281 @@
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
+TRACE_EVENT(dma_buf_export,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf),
+
+	TP_STRUCT__entry(
+		__string(exp_name, dmabuf->exp_name)
+		__string(name, dmabuf->name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(long, f_refcnt)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		spin_lock(&dmabuf->name_lock);
+		__assign_str(name);
+		spin_unlock(&dmabuf->name_lock);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->f_refcnt = file_count(dmabuf->file);
+	),
+
+	TP_printk("exp_name=%s name=%s size=%zu ino=%lu f_refcnt=%ld",
+		  __get_str(exp_name),
+		  __get_str(name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->f_refcnt)
+);
+
+TRACE_EVENT(dma_buf_fd,
+
+	TP_PROTO(struct dma_buf *dmabuf, int fd),
+
+	TP_ARGS(dmabuf, fd),
+
+	TP_STRUCT__entry(
+		__string(exp_name, dmabuf->exp_name)
+		__string(name, dmabuf->name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(int, fd)
+		__field(long, f_refcnt)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		spin_lock(&dmabuf->name_lock);
+		__assign_str(name);
+		spin_unlock(&dmabuf->name_lock);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->fd = fd;
+		__entry->f_refcnt = file_count(dmabuf->file);
+	),
+
+	TP_printk("exp_name=%s name=%s size=%zu ino=%lu fd=%d f_refcnt=%ld",
+		  __get_str(exp_name),
+		  __get_str(name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->fd,
+		  __entry->f_refcnt)
+);
+
+TRACE_EVENT(dma_buf_mmap_internal,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf),
+
+	TP_STRUCT__entry(
+		__string(exp_name, dmabuf->exp_name)
+		__string(name, dmabuf->name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(long, f_refcnt)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		spin_lock(&dmabuf->name_lock);
+		__assign_str(name);
+		spin_unlock(&dmabuf->name_lock);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->f_refcnt = file_count(dmabuf->file);
+	),
+
+	TP_printk("exp_name=%s name=%s size=%zu ino=%lu f_refcnt=%ld",
+		  __get_str(exp_name),
+		  __get_str(name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->f_refcnt)
+);
+
+TRACE_EVENT(dma_buf_mmap,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf),
+
+	TP_STRUCT__entry(
+		__string(exp_name, dmabuf->exp_name)
+		__string(name, dmabuf->name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(long, f_refcnt)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		spin_lock(&dmabuf->name_lock);
+		__assign_str(name);
+		spin_unlock(&dmabuf->name_lock);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->f_refcnt = file_count(dmabuf->file);
+	),
+
+	TP_printk("exp_name=%s name=%s size=%zu ino=%lu f_refcnt=%ld",
+		  __get_str(exp_name),
+		  __get_str(name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->f_refcnt)
+);
+
+TRACE_EVENT(dma_buf_attach,
+
+	TP_PROTO(struct dma_buf *dmabuf, struct device *dev),
+
+	TP_ARGS(dmabuf, dev),
+
+	TP_STRUCT__entry(
+		__string(dname, dev_name(dev))
+		__string(exp_name, dmabuf->exp_name)
+		__string(name, dmabuf->name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(long, f_refcnt)
+	),
+
+	TP_fast_assign(
+		__assign_str(dname);
+		__assign_str(exp_name);
+		spin_lock(&dmabuf->name_lock);
+		__assign_str(name);
+		spin_unlock(&dmabuf->name_lock);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->f_refcnt = file_count(dmabuf->file);
+	),
+
+	TP_printk("dev_name=%s exp_name=%s name=%s size=%zu ino=%lu f_refcnt=%ld",
+		  __get_str(dname),
+		  __get_str(exp_name),
+		  __get_str(name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->f_refcnt)
+);
+
+TRACE_EVENT(dma_buf_detach,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf),
+
+	TP_STRUCT__entry(
+		__string(exp_name, dmabuf->exp_name)
+		__string(name, dmabuf->name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(long, f_refcnt)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		spin_lock(&dmabuf->name_lock);
+		__assign_str(name);
+		spin_unlock(&dmabuf->name_lock);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->f_refcnt = file_count(dmabuf->file);
+	),
+
+	TP_printk("exp_name=%s name=%s size=%zu ino=%lu f_refcnt=%ld",
+		  __get_str(exp_name),
+		  __get_str(name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->f_refcnt)
+);
+
+TRACE_EVENT(dma_buf_get,
+
+	TP_PROTO(int fd, struct file *file),
+
+	TP_ARGS(fd, file),
+
+	TP_STRUCT__entry(
+		__string(exp_name, ((struct dma_buf *)file->private_data)->exp_name)
+		__string(name, ((struct dma_buf *)file->private_data)->name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(int, fd)
+		__field(long, f_refcnt)
+	),
+
+	TP_fast_assign(
+		struct dma_buf *dmabuf = (struct dma_buf *)file->private_data;
+
+		__assign_str(exp_name);
+		spin_lock(&dmabuf->name_lock);
+		__assign_str(name);
+		spin_unlock(&dmabuf->name_lock);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->fd = fd;
+		__entry->f_refcnt = file_count(file);
+	),
+
+	TP_printk("exp_name=%s name=%s size=%zu ino=%lu fd=%d f_refcnt=%ld",
+		  __get_str(exp_name),
+		  __get_str(name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->fd,
+		  __entry->f_refcnt)
+);
+
+TRACE_EVENT(dma_buf_put,
+
+	TP_PROTO(struct dma_buf *dmabuf),
+
+	TP_ARGS(dmabuf),
+
+	TP_STRUCT__entry(
+		__string(exp_name, dmabuf->exp_name)
+		__string(name, dmabuf->name)
+		__field(size_t, size)
+		__field(ino_t, ino)
+		__field(long, f_refcnt)
+	),
+
+	TP_fast_assign(
+		__assign_str(exp_name);
+		spin_lock(&dmabuf->name_lock);
+		__assign_str(name);
+		spin_unlock(&dmabuf->name_lock);
+		__entry->size = dmabuf->size;
+		__entry->ino = dmabuf->file->f_inode->i_ino;
+		__entry->f_refcnt = file_count(dmabuf->file);
+	),
+
+	TP_printk("exp_name=%s name=%s size=%zu ino=%lu f_refcnt=%ld",
+		  __get_str(exp_name),
+		  __get_str(name),
+		  __entry->size,
+		  __entry->ino,
+		  __entry->f_refcnt)
+);
+
+#endif /* _TRACE_DMA_BUF_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.34.1

