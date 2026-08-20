Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9753E168F;
	Thu, 20 Aug 2026 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216833; cv=none; b=CnIrT5r5C0/xpBA5Gmh3ddgUSGRIozMiFEJGEmhTdNU5wxUuY4KQdGmFRucXZRzppnLeLuTVWJ5P0gYgi6TqLlT5QXzPEWfKwvpdyEeaiX7wD6/T0Vz0/fVF68xGpnrnH9qJfnzExmZjo6tmnCLjpgsLmEe4mwIamq1LhFqgToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216833; c=relaxed/simple;
	bh=pDelcQJI6zs/4fXiYR2BoxfOsKnccf3Ziql5TZm5ALY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgapAPOK5htBhKOhbQJAysglTJllf654PCNreX/bxhoA+XMP4HCm7GOQFa4zXYGXRHpq0xBRaNwvM6BAicd55LpK25Kunf5c8HFUuTwihtRJ/HJpNGgdJmvVbnknSQP7LNFnR+EkfGv5XnzsKQWU+Txiaa/1R3YK7M6K0X7qRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RZnM8hFF; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RZnM8hFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lc
	UEyHtMELt33ScppFTkDDJGZPRMBcMBOEQbPSQ+qwU=; b=RZnM8hFF0w/qn1cszm
	b4evbUrjAdEvYyMqw96S/+2bs+U4pwn6k68PkIiD6P96Oqo9Qm+k66szVijJWoZ3
	3DqhajnlZeZX9VDLmjiwfPU1kDcqGCkEulv7dLWXBx6fMgjdmRFljJ5TnfrWPFEd
	Q685mtp5xuBkdoCMFnuBbOyBE=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAHFld6w4ZqIRluPA--.45482S5;
	Thu, 20 Aug 2026 17:06:24 +0800 (CST)
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
Subject: [PATCH v4 3/7] ntfs3: add create inode tracepoint
Date: Thu, 20 Aug 2026 17:05:00 +0800
Message-ID: <20260820090504.950475-4-liubaolin12138@163.com>
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
X-CM-TRANSID:_____wAHFld6w4ZqIRluPA--.45482S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45GFykJF1rCrWrCrWfXwb_yoW8CryUpF
	nrAFs3Gws7J347Kwsavr4UXF1Svay8GrWUtFy8u34xArn3XFn7trsFgr1DZ3Z5CFW0y343
	WFnI9ry5Gr1UXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYXdbUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwRFRHGqGw5EqjgAA3H

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
index 0c9bd669117d..4c427ed69272 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -17,6 +17,7 @@
 #include "debug.h"
 #include "ntfs.h"
 #include "ntfs_fs.h"
+#include <trace/events/ntfs3.h>
 
 /*
  * ntfs_read_mft - Read record and parse MFT.
@@ -1203,6 +1204,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	/* New file will be resident or non resident. */
 	const bool new_file_resident = 1;
 
+	trace_ntfs3_create_inode(dir, dentry);
+
 	if (!fnd)
 		ni_lock_dir(dir_ni);
 
diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
index a1e4bdb6ec59..67a2bde0266d 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -124,6 +124,24 @@ TRACE_EVENT(ntfs3_rename,
 		  __get_str(old_name), __get_str(new_name))
 );
 
+TRACE_EVENT(ntfs3_create_inode,
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
 #endif /* _TRACE_NTFS3_H */
 
 #include <trace/define_trace.h>
-- 
2.51.0

