Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31783939B6;
	Tue, 28 Jul 2026 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231961; cv=none; b=Hiha85iA/DCAOzDDan1B1wvJyv83MgJLZAjkbGKE/FeYX3jIOWkpCOzBoMl4aO0f1/pFa8BPit12I29/dqsLZn7Y9hzTZQ/HclVhKeah0gkIKvYpiwDQtP1WFjpBWcFZC2VVU2UqBky68f87or0zWFpAF98wFpk8Mk+jn55ZRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231961; c=relaxed/simple;
	bh=mpRCwEXbi0DSJqUTLQyi3kmOwMcP/N9o8YRUIItlmNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0nYLiVbHNkevdkkMxkiSB9hzU6WjfMN4KNNdj90nnpjzrDaFzY0edo2kAvuKkAoLSW/nWvS+Zz9U/W1YB3GefVmxTivHHnTUwes15OL1drhW7bkW1vvAL5+zgLcb+Xg/0B8VsvwNWvTjA2gaRpkpvYzTj94qAvEb+FAOUrMPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XRUxc4ip; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XRUxc4ip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Mk
	7+4hFDV2bYZ519TT+ZGgIPeeq1F79LxPLNEESsL9U=; b=XRUxc4iptXcWXzkz/z
	whCMtmlr7+Qu6LqYUoNbeMwxmqgLe/9qKs0fBpCwEOkVh77oURD4rJLuwUbay6+a
	SdMsLYxgoWFakq+OvCmEvq8fx/twAI+UcbXGTwYjhAOKTXl9z5hc/899TWzW2DYb
	ctL0LtQNxvI0XYz4YdplA4M1E=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXFzUiemhq86rAJQ--.13303S5;
	Tue, 28 Jul 2026 17:45:22 +0800 (CST)
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
Subject: [PATCH v2 v2 3/7] ntfs3: add create inode tracepoint
Date: Tue, 28 Jul 2026 17:44:22 +0800
Message-ID: <20260728094426.749482-4-liubaolin12138@163.com>
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
X-CM-TRANSID:QCgvCgDXFzUiemhq86rAJQ--.13303S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45GFykJF1rCrWrCrWfXwb_yoW8CryUpF
	nrAFs3Gws7Jry7KwsavF4UXF1Svay8GrWUJry8u34xArnaqFn7trsFgw1DZ3Z5ArWFy343
	WF1a9ry5Cr17Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYXdbUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6RJfKmpoejLYSAAA3U

From: Baolin Liu <liubaolin@kylinos.cn>

Add an ntfs3 tracepoint for inode creation.

This adds a trace event for ntfs_create_inode() to help
observe inode creation activity.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ntfs3/inode.c             |  3 +++
 include/trace/events/ntfs3.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index c43101cc064d..2bc4ce2ee8d8 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -17,6 +17,7 @@
 #include "debug.h"
 #include "ntfs.h"
 #include "ntfs_fs.h"
+#include <trace/events/ntfs3.h>
 
 /*
  * ntfs_read_mft - Read record and parse MFT.
@@ -1206,6 +1207,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	/* New file will be resident or non resident. */
 	const bool new_file_resident = 1;
 
+	trace_ntfs3_create_inode(dir, dentry);
+
 	if (!fnd)
 		ni_lock_dir(dir_ni);
 
diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
index 041455edec76..ba0ff63a97a7 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -124,6 +124,24 @@ TRACE_EVENT(ntfs3_rename,
 		  __get_str(old_name), __get_str(new_name))
 );
 
+TRACE_EVENT(ntfs3_create_inode,
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
 #endif /* _TRACE_NTFS3_H */
 
 #include <trace/define_trace.h>
-- 
2.51.0

