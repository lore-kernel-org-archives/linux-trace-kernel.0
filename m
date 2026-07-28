Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002337187F;
	Tue, 28 Jul 2026 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231961; cv=none; b=qqBmCrhMRq0JkYCucLhP+dt7M2ocYRqR5thrFlCfFYtMFReCogHjzVnN53lrQs2ED1QVBUKuD4QqlDOmCOWI7ddDM4jlABIZLc8hLAEQtBz8Jxu1BXtkOUH6XOHi06rbZoG0A9RedVQHVvyOKosGNX1Oi7C+OmwQtuHLVZSb7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231961; c=relaxed/simple;
	bh=jhjNomCAfJWKTdUzEoDm7+htcjGBCyqbW6hzEXLI/oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4JJQuhFpI+13kWt8is4er0iZfDu258aW8tF6h01OAK7fTnRmrArVAReWLU6ALpZmdnCbUq6LvQHzkrYvqQmCT1C94qUfg27OJTTP8iw9ukuuysHjJAsQvn3quiTUls/7JbxuU44S8q0geaGwrnTiY0lG+jw+G+fLWYVnJKMloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GvIgHw+5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GvIgHw+5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6Z
	FL14nOogjNAZW1IXRwXnlZrDEBwnZhI2kDjMvKPDw=; b=GvIgHw+5OSoLteLX1L
	PGZ+FOo962SsP6S01cuUoBTWDf7vS82xQV24nFYwtb9ugtS/bmjzsb6oRGckxuXj
	vZ7mrLVFk7c+SbVgMcyNgddt9Gy9K4hiPCJumfIY9cmInsEjirW7ZLWwcO/lbeXW
	nuvwmDzTTzI6W3heNU8Mdp9KI=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXFzUiemhq86rAJQ--.13303S4;
	Tue, 28 Jul 2026 17:45:19 +0800 (CST)
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
Subject: [PATCH v2 v2 2/7] ntfs3: add namei tracepoints
Date: Tue, 28 Jul 2026 17:44:21 +0800
Message-ID: <20260728094426.749482-3-liubaolin12138@163.com>
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
X-CM-TRANSID:QCgvCgDXFzUiemhq86rAJQ--.13303S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr18Aw4xZF15uw1Utw4fXwb_yoW5Cr47pF
	nFyFZ8G393XrsxKwnava15Zr4rZay8ur1Utry2g347Ar1IqF1xtrs2gr4DAr95AFWFk347
	XFWYv3s8Cw15Xr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRbo7_UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6Q9eKWpoei-YBAAA3a

From: Baolin Liu <liubaolin@kylinos.cn>

Add ntfs3 tracepoints for namei operations.

This adds trace events for ntfs_lookup() and ntfs_rename()
to help observe directory lookup and rename activity.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ntfs3/namei.c             |  5 ++++
 include/trace/events/ntfs3.h | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index c59de5f2fa97..c1523decee32 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -13,6 +13,7 @@
 #include "debug.h"
 #include "ntfs.h"
 #include "ntfs_fs.h"
+#include <trace/events/ntfs3.h>
 
 /*
  * fill_name_de - Format NTFS_DE in @buf.
@@ -72,6 +73,8 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int err;
 
+	trace_ntfs3_lookup(dir, dentry);
+
 	if (!uni)
 		inode = ERR_PTR(-ENOMEM);
 	else {
@@ -275,6 +278,8 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 	if (unlikely(ntfs3_forced_shutdown(sb)))
 		return -EIO;
 
+	trace_ntfs3_rename(dir, dentry, new_dir, new_dentry);
+
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
index d00f66e42ba8..041455edec76 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -80,6 +80,50 @@ TRACE_EVENT(ntfs3_log_replay,
 		  __entry->size, __entry->initialized, __entry->err)
 );
 
+TRACE_EVENT(ntfs3_lookup,
+	TP_PROTO(struct inode *dir, struct dentry *dentry),
+	TP_ARGS(dir, dentry),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, parent_ino)
+		__string(name, dentry->d_name.name)
+	),
+	TP_fast_assign(
+		__entry->dev = dir->i_sb->s_dev;
+		__entry->parent_ino = dir->i_ino;
+		__assign_str(name);
+	),
+	TP_printk("dev=(%d,%d) parent=%lu name=%s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->parent_ino, __get_str(name))
+);
+
+TRACE_EVENT(ntfs3_rename,
+	TP_PROTO(struct inode *dir, struct dentry *dentry,
+		 struct inode *new_dir, struct dentry *new_dentry),
+	TP_ARGS(dir, dentry, new_dir, new_dentry),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, dir_ino)
+		__field(unsigned long, new_dir_ino)
+		__field(unsigned long, ino)
+		__string(old_name, dentry->d_name.name)
+		__string(new_name, new_dentry->d_name.name)
+	),
+	TP_fast_assign(
+		__entry->dev = dir->i_sb->s_dev;
+		__entry->dir_ino = dir->i_ino;
+		__entry->new_dir_ino = new_dir->i_ino;
+		__entry->ino = d_inode(dentry)->i_ino;
+		__assign_str(old_name);
+		__assign_str(new_name);
+	),
+	TP_printk("dev=(%d,%d) dir=%lu new_dir=%lu ino=%lu old=%s new=%s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->dir_ino, __entry->new_dir_ino, __entry->ino,
+		  __get_str(old_name), __get_str(new_name))
+);
+
 #endif /* _TRACE_NTFS3_H */
 
 #include <trace/define_trace.h>
-- 
2.51.0

