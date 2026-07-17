Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E6375ADF;
	Fri, 17 Jul 2026 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784258644; cv=none; b=ksHwMfuE3jKYuguM3XsMbrWkmNilS7XMPOX2UNml4nmDUNwdOTql3w78MGGecat8NQDwl6mEWipK8SJCHHaTL8GWSYFyR1pxp4lBcfDNb3NIDTh7fALX7wjyuCofES4werhQud951iwKEbQvTH7ZTmnI86n1J8JTIsV2RJ43aI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784258644; c=relaxed/simple;
	bh=RxCvF/EOmxo96olAf5bP8X9sXbls4wWW6I4H9grysbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj0Z0da71dC6LBkvSHYLK3omLNiK8PfMlfkMHBiq7uG1KKkikPWrQXlYqIP4Uk2ir4ZkDSxqGnpC3JiFWc9pY05L3iVmrZ/WWT51zDFDZwKlkbsb1Z9lrFF70ZoOgp0maU8Ib8gq2IwTEuVp5bIe3Nky84WTIAcn6yQ4h17VYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LEG5Kdul; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LEG5Kdul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dQ
	qvor9rAOCOzxolK5A4ZGR9hBbzgCsM66H7Wr4/EUE=; b=LEG5KdulevymIAmCWk
	hEhlwSfGy4q0lDuDOhwjJWQrPM4h5yahz8Wlp2v7rMVsDX6aBTbbuxW0ZQEyImLW
	gGbX5Pbq2L7HZ6CNgjk2zcNgMn/IK41iDNfuN0+SZ2WazRgCQaWS4RtA2pIsM3yV
	OjaEnie1YX7pBUO8C79t9+Db8=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3twcPoFlqvNaLJg--.4501S6;
	Fri, 17 Jul 2026 11:23:14 +0800 (CST)
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
Subject: [PATCH v1 v1 4/7] ntfs3: add directory index tracepoints
Date: Fri, 17 Jul 2026 11:22:45 +0800
Message-ID: <20260717032248.3318208-5-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717032248.3318208-1-liubaolin12138@163.com>
References: <20260717032248.3318208-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3twcPoFlqvNaLJg--.4501S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF47WF47Aw4UJFW3Jw1rXrb_yoW7Gw4DpF
	nrCrZxK397JrZFkwsaya1Fyr4avayrur4Dtry3W342yw4Iqr18tF4DKr1jvr95ArWF9Fy3
	WF45ua4DG3WUXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE_-PUUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QMh62pZoCM3kAAA33

From: Baolin Liu <liubaolin@kylinos.cn>

Add ntfs3 tracepoints for directory index operations.

This adds trace events for dir_search_u(), indx_find(),
indx_insert_entry(), and indx_delete_entry() to help observe
directory index lookup, insert, and delete activity.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ntfs3/dir.c               |  3 ++
 fs/ntfs3/index.c             |  8 ++++
 include/trace/events/ntfs3.h | 81 ++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 873d52233003..eb10e7ff45bc 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -14,6 +14,7 @@
 #include "debug.h"
 #include "ntfs.h"
 #include "ntfs_fs.h"
+#include <trace/events/ntfs3.h>
 
 /* Convert little endian UTF-16 to NLS string. */
 int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const __le16 *name, u32 len,
@@ -243,6 +244,8 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 	struct inode *inode = NULL;
 	struct ntfs_fnd *fnd_a = NULL;
 
+	trace_ntfs3_dir_search_u(dir, uni ? uni->len : 0);
+
 	if (!fnd) {
 		fnd_a = fnd_get();
 		if (!fnd_a) {
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 2b439ac04356..d4ca7b1bb524 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "ntfs.h"
 #include "ntfs_fs.h"
+#include <trace/events/ntfs3.h>
 
 static const struct INDEX_NAMES {
 	const __le16 *name;
@@ -1179,6 +1180,8 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (!root)
 		root = indx_get_root(&ni->dir, ni, NULL, NULL);
 
+	trace_ntfs3_indx_find(&ni->vfs_inode, indx->type, key_len);
+
 	if (!root) {
 		/* Should not happen. */
 		return -EINVAL;
@@ -2051,6 +2054,9 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return -EINVAL;
 	}
 
+	trace_ntfs3_indx_insert_entry(&ni->vfs_inode, indx->type,
+				      le16_to_cpu(new_de->key_size), undo);
+
 	if (fnd_is_empty(fnd)) {
 		/*
 		 * Find the spot the tree where we want to
@@ -2409,6 +2415,8 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return -EINVAL;
 	}
 
+	trace_ntfs3_indx_delete_entry(&ni->vfs_inode, indx->type, key_len);
+
 	/* Locate the entry to remove. */
 	err = indx_find(indx, ni, root, key, key_len, ctx, &diff, &e, fnd);
 	if (err)
diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
index cc9f4fee9ff8..f9d7051cd14b 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -148,6 +148,87 @@ TRACE_EVENT(ntfs3_create_inode,
 		  __entry->name_len)
 );
 
+TRACE_EVENT(ntfs3_dir_search_u,
+	TP_PROTO(struct inode *dir, unsigned int name_len),
+	TP_ARGS(dir, name_len),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, dir_ino)
+		__field(unsigned int, name_len)
+	),
+	TP_fast_assign(
+		__entry->dev = dir->i_sb->s_dev;
+		__entry->dir_ino = dir->i_ino;
+		__entry->name_len = name_len;
+	),
+	TP_printk("dev=(%d,%d) dir=%lu name_len=%u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->dir_ino, __entry->name_len)
+);
+
+TRACE_EVENT(ntfs3_indx_find,
+	TP_PROTO(struct inode *inode, u8 type, size_t key_len),
+	TP_ARGS(inode, type, key_len),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(u8, type)
+		__field(size_t, key_len)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->type = type;
+		__entry->key_len = key_len;
+	),
+	TP_printk("dev=(%d,%d) ino=%lu type=%u key_len=%zu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->type, __entry->key_len)
+);
+
+TRACE_EVENT(ntfs3_indx_insert_entry,
+	TP_PROTO(struct inode *inode, u8 type, u16 key_len, bool undo),
+	TP_ARGS(inode, type, key_len, undo),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(u8, type)
+		__field(u16, key_len)
+		__field(bool, undo)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->type = type;
+		__entry->key_len = key_len;
+		__entry->undo = undo;
+	),
+	TP_printk("dev=(%d,%d) ino=%lu type=%u key_len=%u undo=%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->type, __entry->key_len,
+		  __entry->undo)
+);
+
+TRACE_EVENT(ntfs3_indx_delete_entry,
+	TP_PROTO(struct inode *inode, u8 type, u32 key_len),
+	TP_ARGS(inode, type, key_len),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(u8, type)
+		__field(u32, key_len)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->type = type;
+		__entry->key_len = key_len;
+	),
+	TP_printk("dev=(%d,%d) ino=%lu type=%u key_len=%u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->type, __entry->key_len)
+);
+
 #endif /* _TRACE_NTFS3_H */
 
 #include <trace/define_trace.h>
-- 
2.51.0

