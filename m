Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB83DDAFC;
	Thu, 20 Aug 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216825; cv=none; b=tKchCDSQJuxdT8aRCUEXw+R2ni1Uib3bMFJeFL9ANW7b3VziuPdB8rOE9QdIbCDl0Lki0YljGDqlt+cWUG6s+nuuTrgi/EMvZsU53mlWVCUGT7R3URKUme3E17w38QfnMnD2w/WMfksw86C2recs3LcudYa9iHBGMlo86E+DRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216825; c=relaxed/simple;
	bh=6yp289RtcU/XbDUzoDTS662XLebClI9tKnKjC6GKHuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICulRxOOb9GaLFWP1Hg1eL0ndXFOBxj3rY8z9SyXcMhj3EssYKDY9qc3jMTTsy/nDM9B9fWtnee5AJvWPUne4M2NntnUPRBUk4sfJQEIPGVX13+3muPQ2CqhT9wctEXNJgo9R1Z+9fbyspU6V1yfujadTQlSLGz3y4Z0VUa2r8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iESbqebf; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iESbqebf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ea
	lyBtV4M6sFpTJmr7xiHwVQ/Aim1DAJvRk46lsItAw=; b=iESbqebfflVKgT21JE
	vj5bRRENUJee0E2KhBJ/lBAwXKalCFNoSKI8vC2QG4vI2V+9pMVonsXLbfcrBNS5
	wEHvkDg7zL9eQn0M+glcv8Ut+W6BXZ+sxpebid/TiqExM5tPgDenqEVDgTzJz2dH
	/dH/mavSx5hvxUrombVigZJ3E=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAHFld6w4ZqIRluPA--.45482S3;
	Thu, 20 Aug 2026 17:06:17 +0800 (CST)
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
Subject: [PATCH v4 1/7] ntfs3: add mount and log replay tracepoints
Date: Thu, 20 Aug 2026 17:04:58 +0800
Message-ID: <20260820090504.950475-2-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260820090504.950475-1-liubaolin12138@163.com>
References: <20260820090504.950475-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHFld6w4ZqIRluPA--.45482S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF4xAF4ktw4fury7ur4DJwb_yoWxJryrpF
	nrAFs3G3yktrWj9ws3tw1Sqr4Fva48uF4Utry3W347Ars7tr1kJr4DtrW8CFZ5ArZ0k3sa
	q3Z0v39Ykw1rWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zN4E_UUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gtPGmqGw4tzdgAA3V

From: Baolin Liu <liubaolin@kylinos.cn>

Add ntfs3 tracepoints for mount and log replay paths.

This adds trace events for ntfs_fill_super(), ntfs_init_from_boot(),
and log_replay() to help observe mount setup, boot sector parsing,
and $LogFile replay results.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 MAINTAINERS                  |  1 +
 fs/ntfs3/fslog.c             |  3 ++
 fs/ntfs3/super.c             | 11 ++++-
 include/trace/events/ntfs3.h | 85 ++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/ntfs3.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..a8e2ea4acef8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19296,6 +19296,7 @@ W:	http://www.paragon-software.com/
 T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
 F:	Documentation/filesystems/ntfs3.rst
 F:	fs/ntfs3/
+F:	include/trace/events/ntfs3.h
 
 NTSYNC SYNCHRONIZATION PRIMITIVE DRIVER
 M:	Elizabeth Figura <zfigura@codeweavers.com>
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index f038c799e7ac..5020da7e72f1 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "ntfs.h"
 #include "ntfs_fs.h"
+#include <trace/events/ntfs3.h>
 
 /*
  * LOG FILE structs
@@ -5362,6 +5363,8 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	else if (log->set_dirty)
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 
+	trace_ntfs3_log_replay(&ni->vfs_inode, *initialized, err);
+
 	kfree(log);
 
 	return err;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 3305fe406cb2..7034ef257452 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -76,6 +76,9 @@
 #include "lib/lib.h"
 #endif
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/ntfs3.h>
+
 #ifdef CONFIG_PRINTK
 /*
  * ntfs_printk - Trace warnings/notices/errors.
@@ -956,7 +959,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	int err;
-	u32 mb, gb, boot_sector_size, sct_per_clst, record_size;
+	u32 mb, gb, boot_sector_size = 0, sct_per_clst, record_size;
 	u64 sectors, clusters, mlcn, mlcn2, dev_size0;
 	struct NTFS_BOOT *boot;
 	struct buffer_head *bh;
@@ -1216,6 +1219,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	}
 
 out:
+	trace_ntfs3_init_from_boot(sb, sector_size, boot_sector_size,
+				 !!boot_block, err);
 	brelse(bh);
 
 	if (err == -EINVAL && !boot_block && dev_size0 > PAGE_SHIFT) {
@@ -1731,12 +1736,16 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	ntfs_create_procdir(sb);
+	trace_ntfs3_fill_super(sb, ro, sbi->cluster_size, sbi->record_size,
+			      sbi->index_size, 0);
 
 	return 0;
 
 put_inode_out:
 	iput(inode);
 out:
+	trace_ntfs3_fill_super(sb, ro, sbi->cluster_size, sbi->record_size,
+			      sbi->index_size, err);
 	/* sbi->options == options */
 	if (options) {
 		put_mount_options(sbi->options);
diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
new file mode 100644
index 000000000000..a45f919cb33e
--- /dev/null
+++ b/include/trace/events/ntfs3.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ntfs3
+
+#if !defined(_TRACE_NTFS3_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NTFS3_H
+
+#include <linux/fs.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(ntfs3_fill_super,
+	TP_PROTO(struct super_block *sb, bool ro, u32 cluster_size,
+		 u32 record_size, u32 index_size, int err),
+	TP_ARGS(sb, ro, cluster_size, record_size, index_size, err),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u32, cluster_size)
+		__field(u32, record_size)
+		__field(u32, index_size)
+		__field(int, err)
+		__field(bool, ro)
+	),
+	TP_fast_assign(
+		__entry->dev = sb->s_bdev->bd_dev;
+		__entry->cluster_size = cluster_size;
+		__entry->record_size = record_size;
+		__entry->index_size = index_size;
+		__entry->err = err;
+		__entry->ro = ro;
+	),
+	TP_printk("dev=(%d,%d) ro=%d cluster=%u record=%u index=%u err=%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ro,
+		  __entry->cluster_size, __entry->record_size,
+		  __entry->index_size, __entry->err)
+);
+
+TRACE_EVENT(ntfs3_init_from_boot,
+	TP_PROTO(struct super_block *sb, u32 media_sector_size,
+		 u32 boot_sector_size, bool used_alt_boot, int err),
+	TP_ARGS(sb, media_sector_size, boot_sector_size, used_alt_boot, err),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u32, media_sector_size)
+		__field(u32, boot_sector_size)
+		__field(int, err)
+		__field(bool, used_alt_boot)
+	),
+	TP_fast_assign(
+		__entry->dev = sb->s_bdev->bd_dev;
+		__entry->media_sector_size = media_sector_size;
+		__entry->boot_sector_size = boot_sector_size;
+		__entry->err = err;
+		__entry->used_alt_boot = used_alt_boot;
+	),
+	TP_printk("dev=(%d,%d) media_sector=%u boot_sector=%u alt_boot=%d err=%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->media_sector_size, __entry->boot_sector_size,
+		  __entry->used_alt_boot, __entry->err)
+);
+
+TRACE_EVENT(ntfs3_log_replay,
+	TP_PROTO(struct inode *inode, bool initialized, int err),
+	TP_ARGS(inode, initialized, err),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+		__field(loff_t, size)
+		__field(dev_t, dev)
+		__field(int, err)
+		__field(bool, initialized)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->size = i_size_read(inode);
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->err = err;
+		__entry->initialized = initialized;
+	),
+	TP_printk("dev=(%d,%d) ino=%lu size=%lld initialized=%d err=%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		  __entry->size, __entry->initialized, __entry->err)
+);
+
+#endif /* _TRACE_NTFS3_H */
+
+#include <trace/define_trace.h>
-- 
2.51.0

