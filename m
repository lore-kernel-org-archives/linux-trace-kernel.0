Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCA375F96;
	Fri, 17 Jul 2026 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784258644; cv=none; b=IMZwVsHsSDnAzTfV+dUXfXaBZaWPn73tFXiC6qSofgJXe1engV8bjP/w2++JUgLPWPJVPKDk9Xs0W3jENOjpP+rqxjwPYLL03+/wquoMMMIx4C+raJjSVGN7l3k/QxnwjAmBv79FKKlj/0ZPYM/UEPEEMORrGPsqc7kD3npz7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784258644; c=relaxed/simple;
	bh=754wFdUHYSNM26KA2NQyt+lr1EipOG2WDyhORK9v3bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EytFGRH7/GzZdpvDOBNL/vlPIqwgtUtIGca4xshmMJ7exjdJ6tOAzH3GOiw3cXbps3fvogOLczBQFDrYpJI7jn/oj0quiZheceue4eD0G4bD8ZYcCQBRttHH+LlyyWnMgTxY4HHZa6y0PWjfLNjOFhkWLNrVfgOzkskzpe7RPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LK6U9pjz; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LK6U9pjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Eq
	5D+FOUwr21J0LHbkK7uJXTLpBprdy0vcdNNsc4w4w=; b=LK6U9pjzz5o0QfwidW
	M7DLmYYChWdqOH7XRkby/r9JIJFXOVSYS40negneEGJS1mw/T7LDzDoODP/WFW/6
	ysHri1853sms9sZBqOgzeZeYLpsxdJbUJp8Fi1uj6zuJ27ILkdaBBIPVvvjym83a
	KkeYmHWpwUIvwjDBzAiF5DsC8=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3twcPoFlqvNaLJg--.4501S5;
	Fri, 17 Jul 2026 11:23:11 +0800 (CST)
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
Subject: [PATCH v1 v1 3/7] ntfs3: add create inode tracepoint
Date: Fri, 17 Jul 2026 11:22:44 +0800
Message-ID: <20260717032248.3318208-4-liubaolin12138@163.com>
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
X-CM-TRANSID:_____wD3twcPoFlqvNaLJg--.4501S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45GFykJF1rCrWrCrWfXwb_yoW8Zr43pF
	nrAFs3Kws7Jry7Kwsavr4UXFySvay8Gr4Utry7u34xAr1SqF1xtrsFgw1DZFn5ArWvy343
	WF1a9ry5Gr17XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYXdbUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwQAh62pZoCD45wAA3n

From: Baolin Liu <liubaolin@kylinos.cn>

Add an ntfs3 tracepoint for inode creation.

This adds a trace event for ntfs_create_inode() to help
observe inode creation activity.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ntfs3/inode.c             |  3 +++
 include/trace/events/ntfs3.h | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

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
index ba27531d889e..cc9f4fee9ff8 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -127,6 +127,27 @@ TRACE_EVENT(ntfs3_rename,
 		  __get_str(old_name), __get_str(new_name))
 );
 
+TRACE_EVENT(ntfs3_create_inode,
+	TP_PROTO(struct inode *dir, struct dentry *dentry),
+	TP_ARGS(dir, dentry),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, parent_ino)
+		__string(name, dentry->d_name.name)
+		__field(unsigned int, name_len)
+	),
+	TP_fast_assign(
+		__entry->dev = dir->i_sb->s_dev;
+		__entry->parent_ino = dir->i_ino;
+		__assign_str(name);
+		__entry->name_len = dentry->d_name.len;
+	),
+	TP_printk("dev=(%d,%d) parent=%lu name=%s len=%u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->parent_ino, __get_str(name),
+		  __entry->name_len)
+);
+
 #endif /* _TRACE_NTFS3_H */
 
 #include <trace/define_trace.h>
-- 
2.51.0

