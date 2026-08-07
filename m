Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBCC233943;
	Fri,  7 Aug 2026 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064682; cv=none; b=nC56iJGFr7fc7oZfLkqtp5Ia3wbAdlPlaBZdsStPM4mQsbLVvDfRpemoCLb8pID3ff0DmN7W/1luZN4JkBhEcNxF2mijKS6IxKePRieeeK8buqkuAwDqDAgksLcnaxiCvgQVCE3fNuabagffc0D5CvaFjj4Sx8hGDtC1gJvS334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064682; c=relaxed/simple;
	bh=ipFRiEZb3eOzbms77cPdggMuTdTP/tuAsuPcoOcd3hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1xUTaGhjDwc5I2of6VGyUTgyii56VNv6Zi1r8hjN22SuwYb4V/NZsGKjKI4gZyPZ3I03RSyJw9qkgdA0XLjOUfdbohakba2QOVQAEOCs7bIx55Znh94nhsq8L41gIEpr2KvNkfXIooBWzNuGZ5kBwhHHPpuq1ljw3SmLrquNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GRtvyrGv; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GRtvyrGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=UV
	C2ktW37UcDCI11yFCHJYewa7WGv3t7Z5otXeKijXo=; b=GRtvyrGvepRYtG/sLq
	zcpWHyGADt4klLVB9FrUlI3711XJNgiiHYSNRC1iSepNmOp1LUxDQh8BrJTgCBpM
	vvzSlSiA2r4O/AlM+eCoDJucxy2SQkBc0FPPRr7OGpJ4Yp/8XA6nZ29/+7MeD0z/
	jBTsYpifmUwVbdGbPg0IUdj2g=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnpYn9LnVqp7BkOQ--.32974S6;
	Fri, 07 Aug 2026 09:04:11 +0800 (CST)
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
Subject: [PATCH v3 v3 4/7] ntfs3: add directory index tracepoints
Date: Fri,  7 Aug 2026 09:03:51 +0800
Message-ID: <20260807010354.2277156-5-liubaolin12138@163.com>
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
X-CM-TRANSID:_____wAnpYn9LnVqp7BkOQ--.32974S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF47WF47Aw4UJFW3Jw1rXrb_yoW7Xr43pF
	nrCrZxK397JrZFkwsaya1Fyr4ava95ur4Dtry3W342yw4Iqr18tF4DKr1jvr95ArWF9ryf
	WF4Y9a4DG3WUWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE_-PUUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QvFkGp1Lwvl5gAA3P

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
index 67a2bde0266d..4ac05ed29e49 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -142,6 +142,87 @@ TRACE_EVENT(ntfs3_create_inode,
 		  __entry->parent_ino, __get_str(name))
 );
 
+TRACE_EVENT(ntfs3_dir_search_u,
+	TP_PROTO(struct inode *dir, unsigned int name_len),
+	TP_ARGS(dir, name_len),
+	TP_STRUCT__entry(
+		__field(unsigned long, dir_ino)
+		__field(dev_t, dev)
+		__field(unsigned int, name_len)
+	),
+	TP_fast_assign(
+		__entry->dir_ino = dir->i_ino;
+		__entry->dev = dir->i_sb->s_dev;
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
+		__field(unsigned long, ino)
+		__field(size_t, key_len)
+		__field(dev_t, dev)
+		__field(u8, type)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->key_len = key_len;
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->type = type;
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
+		__field(unsigned long, ino)
+		__field(dev_t, dev)
+		__field(u16, key_len)
+		__field(u8, type)
+		__field(bool, undo)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->key_len = key_len;
+		__entry->type = type;
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
+		__field(unsigned long, ino)
+		__field(u32, key_len)
+		__field(dev_t, dev)
+		__field(u8, type)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->key_len = key_len;
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->type = type;
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

