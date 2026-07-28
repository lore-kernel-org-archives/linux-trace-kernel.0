Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4304314B6D;
	Tue, 28 Jul 2026 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231965; cv=none; b=YMzUij52EyFioQlFMqDJc3vCm3dOFzjbXgQrRqqn6KRq/6cGTBORhfk5vmGWL1B9+awd5C+V3uFB8NqK5Gl0rPlebrGsZ2yg/8bAaRL3JgzmBDovFiS7p1c3qPumzz7ghbP2O4uk9mKk/uyY/+Ym3zwKQpU6t9Os9iZbs8ckRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231965; c=relaxed/simple;
	bh=dil0eAJCBjvepBgbg7WvFaf3tzbi8r8GIVyYCWYbg34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWNWa0POob/O02wWYUkW1DrRUen+JZHaFcxSoyKBp8vpupnFe7QrvPEY8NGOrzzViHIZLP3ZAjDRx5Iw0+uK/WqAsEwo55ZyGorrqJhMvIBsdVIyZfPs+ObVPLBW9gOSKR7GtEXqgjZV/iFq8/DsKsnKHFMH6qM7VfPQz8CK92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=grWzLnt2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="grWzLnt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TB
	hIuMOi3QZ8dUj7tB6ZO3O0wOu906AOYwvloY09CXw=; b=grWzLnt2w7xzK0eC5S
	/WPFM+cmj28FGI6RoIyR3DzyhTViykQkO7Oh+hYoKFXfS5FFuVl7nAHoDagl6/91
	MtVSL6w/+p4ChxsKN5AByYlxfuqfGrPQYC5LwFeXFhsfDPzWNn9TSkRsYVONcJQr
	As2fZIgQB0pAGa10ua2D4mEiU=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXFzUiemhq86rAJQ--.13303S7;
	Tue, 28 Jul 2026 17:45:27 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: almaz.alexandrovich@paragon-software.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	liubaolin12138@163.com,
	liubaolin12138@gmail.com,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v2 v2 5/7] ntfs3: add allocation tracepoints
Date: Tue, 28 Jul 2026 17:44:24 +0800
Message-ID: <20260728094426.749482-6-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260728094426.749482-1-liubaolin12138@163.com>
References: <20260728094426.749482-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXFzUiemhq86rAJQ--.13303S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr15AFy5ZF48JrWfurWkCrg_yoWrtF4DpF
	1DAFy3Ww4rJrZFkwsavw18tw45uay8ur4UKry7W342yrn2qrn7Jr4Utr1jvFyvkFyvkrnx
	WFyj93s8G3WUWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwRdgK2poejeJ2AAA3D

From: Baolin Liu <liubaolin@kylinos.cn>

Add ntfs3 tracepoints for allocation operations.

This adds trace events for attr_allocate_clusters(),
attr_set_size_ex(), and attr_data_get_block() to help
observe cluster allocation, size changes, and block
mapping activity.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ntfs3/attrib.c            |  9 +++++
 include/trace/events/ntfs3.h | 78 ++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index c621a4c582f9..a793f17b6bb4 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "ntfs.h"
 #include "ntfs_fs.h"
+#include <trace/events/ntfs3.h>
 
 /*
  * You can set external NTFS_MIN_LOG2_OF_CLUMP/NTFS_MAX_LOG2_OF_CLUMP to manage
@@ -167,6 +168,8 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 	CLST flen, vcn0 = vcn, pre = pre_alloc ? *pre_alloc : 0;
 	size_t cnt = run->count;
 
+	trace_ntfs3_attr_allocate_clusters(sbi->sb, vcn, lcn, len, opt);
+
 	for (;;) {
 		err = ntfs_look_for_free_space(sbi, lcn, len + pre, &lcn, &flen,
 					       opt);
@@ -452,6 +455,9 @@ int attr_set_size_ex(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	u32 align;
 	struct MFT_REC *rec;
 
+	trace_ntfs3_attr_set_size_ex(&ni->vfs_inode, le32_to_cpu(type), new_size,
+				    keep_prealloc, no_da);
+
 again:
 	alen = 0;
 	le_b = NULL;
@@ -960,6 +966,9 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	if (res)
 		*res = NULL;
 
+	trace_ntfs3_attr_data_get_block(&ni->vfs_inode, vcn, clen,
+					 new != NULL, zero, no_da);
+
 	/* Try to find in cache. */
 	down_read(&ni->file.run_lock);
 	if (run_lookup_entry_da(&ni->file.run, !no_da ? &ni->file.run_da : NULL,
diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
index bfaddfa3e90c..d0f42b3966b5 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -223,6 +223,84 @@ TRACE_EVENT(ntfs3_indx_delete_entry,
 		  __entry->ino, __entry->type, __entry->key_len)
 );
 
+TRACE_EVENT(ntfs3_attr_allocate_clusters,
+	TP_PROTO(struct super_block *sb, u64 vcn, u64 lcn, u64 len, u32 opt),
+	TP_ARGS(sb, vcn, lcn, len, opt),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, vcn)
+		__field(u64, lcn)
+		__field(u64, len)
+		__field(u32, opt)
+	),
+	TP_fast_assign(
+		__entry->dev = sb->s_dev;
+		__entry->vcn = vcn;
+		__entry->lcn = lcn;
+		__entry->len = len;
+		__entry->opt = opt;
+	),
+	TP_printk("dev=(%d,%d) vcn=%llu lcn=%llu len=%llu opt=0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->vcn, __entry->lcn, __entry->len, __entry->opt)
+);
+
+TRACE_EVENT(ntfs3_attr_set_size_ex,
+	TP_PROTO(struct inode *inode, u32 type, u64 new_size, bool keep_prealloc,
+		 bool no_da),
+	TP_ARGS(inode, type, new_size, keep_prealloc, no_da),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(u32, type)
+		__field(loff_t, old_size)
+		__field(u64, new_size)
+		__field(bool, keep_prealloc)
+		__field(bool, no_da)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->type = type;
+		__entry->old_size = i_size_read(inode);
+		__entry->new_size = new_size;
+		__entry->keep_prealloc = keep_prealloc;
+		__entry->no_da = no_da;
+	),
+	TP_printk("dev=(%d,%d) ino=%lu type=0x%x old_size=%lld new_size=%llu keep_prealloc=%d no_da=%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		  __entry->type, __entry->old_size, __entry->new_size,
+		  __entry->keep_prealloc, __entry->no_da)
+);
+
+TRACE_EVENT(ntfs3_attr_data_get_block,
+	TP_PROTO(struct inode *inode, u64 vcn, u64 clen, bool create,
+		 bool zero, bool no_da),
+	TP_ARGS(inode, vcn, clen, create, zero, no_da),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(u64, vcn)
+		__field(u64, clen)
+		__field(bool, create)
+		__field(bool, zero)
+		__field(bool, no_da)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->vcn = vcn;
+		__entry->clen = clen;
+		__entry->create = create;
+		__entry->zero = zero;
+		__entry->no_da = no_da;
+	),
+	TP_printk("dev=(%d,%d) ino=%lu vcn=%llu clen=%llu create=%d zero=%d no_da=%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		  __entry->vcn, __entry->clen, __entry->create,
+		  __entry->zero, __entry->no_da)
+);
+
 #endif /* _TRACE_NTFS3_H */
 
 #include <trace/define_trace.h>
-- 
2.51.0

