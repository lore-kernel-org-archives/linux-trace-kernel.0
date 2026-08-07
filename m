Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76101274641;
	Fri,  7 Aug 2026 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064687; cv=none; b=pl7TYJDXO+wgnk4Bj8wZVOrpNWoEMQPikX1/lkV3D6FZ8PyEkXE3+tJbF6AiXE1bu3FxOIcTyt+pSQztqLWq9+Z4m98KOOdP24+FQuSFaSZkJyjDpNFAgzZZHGSlxCcZxRWkuIMond8L9nE3KJUc97mEcDj7AA3oxw7mdZ+/6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064687; c=relaxed/simple;
	bh=3YrGN2r3o4zxkKUcthMdwznjPnpl3mbm4YiZNIESras=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoqZtcVGnQHPZac3t0wTUS1AheQTcDBryFpFb84uUsz9ETWZdfbmKJgk1RM4cenXGP/4uPPLpZ0YL7Kem+qwCV9Ath2QqyRY8ZLZpdyw907PwRv+ZtOHCHTfQflX9fwxy+LLm/QXmZobvm9RZKjfk8ZSCiBfz2HR26KaHG1IprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MgPNRM6w; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MgPNRM6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iG
	om8Epilwi6V2126R3wVx/l/gkYFTDyDJNaMaHfR+M=; b=MgPNRM6wFH2C82JFep
	mw9QOjcBeVd/s7T3FMUkDxBcX9cAJvAgHvUCOvTO3qHv49TKntnACmNDPkCN8yUj
	OkZOQ+7A+XTGXTnZcP96E0F3C4Vc3prjv+cw/53zwUAdxsVcySwvnhTbx17YqVO4
	Pxom57yF4tSxp8OgZ+yhO7v6M=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnpYn9LnVqp7BkOQ--.32974S4;
	Fri, 07 Aug 2026 09:04:07 +0800 (CST)
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
Subject: [PATCH v3 v3 2/7] ntfs3: add namei tracepoints
Date: Fri,  7 Aug 2026 09:03:49 +0800
Message-ID: <20260807010354.2277156-3-liubaolin12138@163.com>
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
X-CM-TRANSID:_____wAnpYn9LnVqp7BkOQ--.32974S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr18Aw4xZF15uw18JrWUArb_yoW5Cr47pF
	nFyFZ8W393JrsxKwnava15Zr4rZay8ur1Utry29347Ar1IqF1xtrs2gr4DAr95AFWFk347
	WFWYv3s8Cw15Xr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRbo7_UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwQfEj2p1LwdoywAA3Z

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
index a45f919cb33e..a1e4bdb6ec59 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -80,6 +80,50 @@ TRACE_EVENT(ntfs3_log_replay,
 		  __entry->size, __entry->initialized, __entry->err)
 );
 
+TRACE_EVENT(ntfs3_lookup,
+	TP_PROTO(struct inode *dir, struct dentry *dentry),
+	TP_ARGS(dir, dentry),
+	TP_STRUCT__entry(
+		__field(unsigned long, parent_ino)
+		__field(dev_t, dev)
+		__string(name, dentry->d_name.name)
+	),
+	TP_fast_assign(
+		__entry->parent_ino = dir->i_ino;
+		__entry->dev = dir->i_sb->s_dev;
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
+		__field(unsigned long, dir_ino)
+		__field(unsigned long, new_dir_ino)
+		__field(unsigned long, ino)
+		__field(dev_t, dev)
+		__string(old_name, dentry->d_name.name)
+		__string(new_name, new_dentry->d_name.name)
+	),
+	TP_fast_assign(
+		__entry->dir_ino = dir->i_ino;
+		__entry->new_dir_ino = new_dir->i_ino;
+		__entry->ino = d_inode(dentry)->i_ino;
+		__entry->dev = dir->i_sb->s_dev;
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

