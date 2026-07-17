Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B53750CB;
	Fri, 17 Jul 2026 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784258644; cv=none; b=qLL3ob96Q2/zz7GoiipgkT7bkTS00SWW+fbcbfzGysJ5Ga5SaSkiWyisajDk+R/WxHdi4W0zZrPgX7VLFkPJuE5Gh/aCdmribvymumRx7j1njPwe50o0ZmRpJtRNK4o3FSaJj1xdeqIQTXLMqNnZso5z+D+9hTEzp+ceJAZE80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784258644; c=relaxed/simple;
	bh=A4sYQA408h4URz/Abt26UL3lN5sE9vFiSWwiFxL1wjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhUptPWtD2REWupkPQN3hU+vknFg7O90xrVPgjuQj33+rWCqPD3URgGzAUKriNsN6LZdKKxSZmi3Id0Q/4p3fndoZbWESxWbnx4qayxCt0EGrResqRVTEA4ZZ54NFyyMq9pVTe+W71+2AWT8iIVx3kOU6gwPuy+rleDIiMiIP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IeMeMH8z; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IeMeMH8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=aN
	KxlLnvAsjvdFyYFGpQjrI2XF282/VaGnvSfEvwl0I=; b=IeMeMH8zizhJv8E+lI
	LqFqJFMVf80hMrx3xV/+HTyzSy05wNlFVNrrktmvkNME2AbktjaQ//4tDsBvvQl4
	D4XbFfILWKyzLzPDYpPTR1C6J1Rav4HOtYZ/gTlSfWU1fZfAkwlzZJx+UEtAAe6a
	1BQ1B+OTbdoDlomvRzImf2T64=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3twcPoFlqvNaLJg--.4501S9;
	Fri, 17 Jul 2026 11:23:21 +0800 (CST)
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
Subject: [PATCH v1 v1 7/7] ntfs3: add file I/O tracepoints
Date: Fri, 17 Jul 2026 11:22:48 +0800
Message-ID: <20260717032248.3318208-8-liubaolin12138@163.com>
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
X-CM-TRANSID:_____wD3twcPoFlqvNaLJg--.4501S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr18XF1ktw1kJr45ZFy3twb_yoW5XF47pF
	nIyasxWrWxJw47Kws3JF4DXa1rua1xCrWUJry7W3W3Ar1xtrn3JanFgF1jk3Z5ArWqyw12
	g3Z0934DG34UXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gkj7WpZoClKigAA3X

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
index a846aa61153c..595314c09e43 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -357,6 +357,39 @@ TRACE_EVENT(ntfs3_iomap_end,
 		  __entry->written, __entry->flags)
 );
 
+DECLARE_EVENT_CLASS(ntfs3_file_class,
+	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),
+	TP_ARGS(iocb, iter),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(loff_t, size)
+		__field(loff_t, offset)
+		__field(size_t, count)
+	),
+	TP_fast_assign(
+		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
+		__entry->ino = file_inode(iocb->ki_filp)->i_ino;
+		__entry->size = i_size_read(file_inode(iocb->ki_filp));
+		__entry->offset = iocb->ki_pos;
+		__entry->count = iov_iter_count(iter);
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

