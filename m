Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B2282F24;
	Fri,  7 Aug 2026 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064695; cv=none; b=e5DjCaMwSMxQ1+4CL2JRZ5Eif4aFgwSx/b3fkSolJyui5mOupoQDhyMX131uFQ+gneOFw4Fiuv2HT5rqbNtEEnXtWyJjjss9CzcF/xe3WM4aq7UzcQANTyPs1ZrouZgcWHKCRLKjiUq9aLPCqGB0gH/NibAQVNxRZGxV0joQOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064695; c=relaxed/simple;
	bh=WJ2EZd+tslyCXF4VijVQs5/B9ognZg5bGw1YxDvatiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc2VVgsVA4M2cgM4qQuy84zVvxErBb27xYeeNEiWJeh1Np2rPqm2W3MoCXELKB1X3lud1AbnaYlVaC24dPUH1eGllT8dRAWsba4hLAmum6zRA7KDGBxXiIGQCMMP1kSG/EgtmSRBKW5uNPG46TE5LAvMUXGbF6bdf6rYbdGmhqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W5aUwXv0; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W5aUwXv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pE
	X/r2AQmnAgIls5Qm8ZlDT1RfDE4/tNoliJXxnVjyg=; b=W5aUwXv0j2IyJxkdL2
	2r+mzW7HzHDM3dcjzljVXY5MtzmlzSb7KG41xMX2TB6lQcGbNvolQqbO7G3ThixZ
	3L0rvmsaUq4TqSuUPHdVtqGNNdYYiYs5UPbiM+roa0g/Mi6liOagpF2kayEOJOBH
	ycaFQtLdZCezK9Ab9aJISo0ps=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnpYn9LnVqp7BkOQ--.32974S7;
	Fri, 07 Aug 2026 09:04:13 +0800 (CST)
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
Subject: [PATCH v3 v3 5/7] ntfs3: add allocation tracepoints
Date: Fri,  7 Aug 2026 09:03:52 +0800
Message-ID: <20260807010354.2277156-6-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260807010354.2277156-1-liubaolin12138@163.com>
References: <20260807010354.2277156-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnpYn9LnVqp7BkOQ--.32974S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr15AFy5ZF48JrWfurWkCrg_yoWrtF4DpF
	1DAFy3Ww4rJrZFkwsavw48tw45uay8ur4UKry7W34jyr1Iqrn7tr4Utr1jvFyvkFyvkrnx
	WFyq93s8G3WUWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6Q3GkWp1Lw3mLQAA3F

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
index 4ac05ed29e49..d16dd127ff2e 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -223,6 +223,84 @@ TRACE_EVENT(ntfs3_indx_delete_entry,
 		  __entry->ino, __entry->type, __entry->key_len)
 );
 
+TRACE_EVENT(ntfs3_attr_allocate_clusters,
+	TP_PROTO(struct super_block *sb, u64 vcn, u64 lcn, u64 len, u32 opt),
+	TP_ARGS(sb, vcn, lcn, len, opt),
+	TP_STRUCT__entry(
+		__field(u64, vcn)
+		__field(u64, lcn)
+		__field(u64, len)
+		__field(dev_t, dev)
+		__field(u32, opt)
+	),
+	TP_fast_assign(
+		__entry->vcn = vcn;
+		__entry->lcn = lcn;
+		__entry->len = len;
+		__entry->dev = sb->s_dev;
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
+		__field(loff_t, old_size)
+		__field(u64, new_size)
+		__field(unsigned long, ino)
+		__field(dev_t, dev)
+		__field(u32, type)
+		__field(bool, keep_prealloc)
+		__field(bool, no_da)
+	),
+	TP_fast_assign(
+		__entry->old_size = i_size_read(inode);
+		__entry->new_size = new_size;
+		__entry->ino = inode->i_ino;
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->type = type;
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
+		__field(u64, vcn)
+		__field(u64, clen)
+		__field(unsigned long, ino)
+		__field(dev_t, dev)
+		__field(bool, create)
+		__field(bool, zero)
+		__field(bool, no_da)
+	),
+	TP_fast_assign(
+		__entry->vcn = vcn;
+		__entry->clen = clen;
+		__entry->ino = inode->i_ino;
+		__entry->dev = inode->i_sb->s_dev;
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

