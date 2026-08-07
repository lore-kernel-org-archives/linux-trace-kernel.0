Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE388282F34;
	Fri,  7 Aug 2026 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064687; cv=none; b=QfiaC+hg91bSd0uIHKIVVWKbPL0l1zh9gX/Bj+gZ5B/OaGJBy/jbl1ox1S0oOxOLWDJpyUZCB4i/aAsfdMIiOD5vBsJGAR9P/wHyVXow7BZPGWFq8R3aySkRpm1Sqbf8KyI878wzl6q1r4fL5i5EU3oQJUx7wiZXFiQP9JJfAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064687; c=relaxed/simple;
	bh=Yfao+oSjMPGe4+QuHnl5HAxHcnC/rs73XaioxJf/86s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9Thi7spKfw+nlQR6bT+17rGmtxV9sdC1b1iztk3sEXByrCKhcaUkqqNQ/E13p6nBbnAXAL2RhygRH88AkIeRWQ+cDw42HY/wDM9mrdv1hPHYatvWF79FTU5TlHUyQTNehKXCRyzOFrPL4hvQt19z3xoNTNgJm9pzE3xwfu6fnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fzsECu6f; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fzsECu6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=E0
	b/N/mkFze6dmVbf5O0lbNgI3WDQMXE76TxPFcP1Kw=; b=fzsECu6fKNMc55xQhl
	7d9FTqytcCs92M+wMRJ3+GFX6t9yjbiEzlL4pKhOXeRpIAJc3Mlz53NKLztt7J3R
	0xr9oP4MARAZ+W9QgwIgUXrh83E1cUeJIOUV+SxK73P1Dlh63Ar9fd35AeBTxy+D
	W/V3LzPti7sfRrHdFNWlaRino=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnpYn9LnVqp7BkOQ--.32974S9;
	Fri, 07 Aug 2026 09:04:17 +0800 (CST)
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
Subject: [PATCH v3 v3 7/7] ntfs3: add file I/O tracepoints
Date: Fri,  7 Aug 2026 09:03:54 +0800
Message-ID: <20260807010354.2277156-8-liubaolin12138@163.com>
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
X-CM-TRANSID:_____wAnpYn9LnVqp7BkOQ--.32974S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr18XF1ktw1kJr45ZFy3twb_yoW5XF47pF
	nIyasxWrWxJ3y7Kws3CF4DXa1rua1xCrWUJry7W3W3Ar1xJrn7JanFgF1jk3Z5ArWqyw1a
	g3Z093s8G34UXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6hHHkmp1LxG+gQAA3w

From: Baolin Liu <liubaolin@kylinos.cn>

Add ntfs3 tracepoints for file I/O operations.

This adds trace events for ntfs_file_read_iter() and
ntfs_file_write_iter() to help observe file read and
write activity.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ntfs3/file.c              |  5 +++++
 include/trace/events/ntfs3.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index d601f088618c..a260a57ebd65 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -20,6 +20,7 @@
 #include "debug.h"
 #include "ntfs.h"
 #include "ntfs_fs.h"
+#include <trace/events/ntfs3.h>
 
 /*
  * cifx, btrfs, exfat, ext4, f2fs use this constant.
@@ -822,6 +823,8 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	unsigned int dio_flags;
 	ssize_t err;
 
+	trace_ntfs3_file_read_iter(iocb, iter);
+
 	err = check_read_restriction(inode);
 	if (err)
 		return err;
@@ -1225,6 +1228,8 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	loff_t vbo, endbyte;
 	ssize_t ret, err;
 
+	trace_ntfs3_file_write_iter(iocb, from);
+
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
index 7a94c2788295..c76fe265fb79 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -351,6 +351,39 @@ TRACE_EVENT(ntfs3_iomap_end,
 		  __entry->written, __entry->flags)
 );
 
+DECLARE_EVENT_CLASS(ntfs3_file_class,
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),
+	TP_ARGS(iocb, iter),
+	TP_STRUCT__entry(
+		__field(loff_t, size)
+		__field(loff_t, offset)
+		__field(size_t, count)
+		__field(unsigned long, ino)
+		__field(dev_t, dev)
+	),
+	TP_fast_assign(
+		__entry->size = i_size_read(file_inode(iocb->ki_filp));
+		__entry->offset = iocb->ki_pos;
+		__entry->count = iov_iter_count(iter);
+		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
+		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
+	),
+	TP_printk("dev=(%d,%d) ino=%lu size=%lld pos=%lld bytecount=%zu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->size, __entry->offset,
+		  __entry->count)
+);
+
+DEFINE_EVENT(ntfs3_file_class, ntfs3_file_read_iter,
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),
+	TP_ARGS(iocb, iter)
+);
+
+DEFINE_EVENT(ntfs3_file_class, ntfs3_file_write_iter,
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),
+	TP_ARGS(iocb, iter)
+);
+
 #endif /* _TRACE_NTFS3_H */
 
 #include <trace/define_trace.h>
-- 
2.51.0

