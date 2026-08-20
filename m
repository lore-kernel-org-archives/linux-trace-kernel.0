Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AA3E0C55;
	Thu, 20 Aug 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216832; cv=none; b=jQPRpfwpDPQC8Mg6bIJ0Y96x5Xaqyd6O0zxNxlTsbuiArJvvjZQOhTxtYqc/7iGdaTMx3at/NDumEn8n1564fxHsQy/wcC9IaBGvclSBsKf02M+pt7Gd2qbhtRWDzHpT6B7IlqyKuse5+uikaC3hd4B5VAcoo/0kQ7LCPlDSGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216832; c=relaxed/simple;
	bh=FH77Z4Tyi6l79sLP04scPPmahnqB8vKdTTxzhy1lFBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMw8K8Sr19iu0wXdEy+cmFb8et0YlEzwcJTnupo0WdjSe4NVXba6P/jns2QhNyI0IWTN+sF4MR0lBQUOWi0bjWgMfSeuUJAEyOebN3kPYdytS4k/J9cQqHyqXCwMrwewbfdAyukQaEXpU0aKL1ZvNKWs4Gj/nEoZUOLFSBuczBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bcGejpP6; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bcGejpP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ET
	9N/9vZDeZEA2twROTaEvCeOy2JTOq+VTonny2bnZQ=; b=bcGejpP67eF/odowCS
	Mhyo+nsBoNTegsUAs8SqlzrhElVuBN2G/32G0pfD364wNe3j6cQQVFGREwfDjFGv
	fyrzQ9aNTIM9OU+YraUqO7Zj2NSWwf4KyORa/l+tKSy+aTX0HLMUark/kJnMS706
	7YPPfa/7Vtv61HTAuIEYEGAG8=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAHFld6w4ZqIRluPA--.45482S8;
	Thu, 20 Aug 2026 17:06:33 +0800 (CST)
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
Subject: [PATCH v4 6/7] ntfs3: add iomap tracepoints
Date: Thu, 20 Aug 2026 17:05:03 +0800
Message-ID: <20260820090504.950475-7-liubaolin12138@163.com>
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
X-CM-TRANSID:_____wAHFld6w4ZqIRluPA--.45482S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr18XF1rWF4DtF1rAryxXwb_yoW5CFWxpa
	sFyFZxGa97JrW29wsayw4FqF4ava4xur4UKr17Wryay3Wxt3W7KF4vgFyjvw18AF1jkr1I
	gF90vryUG3WUXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwhlTHmqGw5k8ygAA3W

From: Baolin Liu <liubaolin@kylinos.cn>

Add ntfs3 tracepoints for iomap operations.

This adds trace events for ntfs_iomap_begin() and
ntfs_iomap_end() to help observe iomap mapping activity.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ntfs3/inode.c             |  4 +++
 include/trace/events/ntfs3.h | 50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 4c427ed69272..54bf5225fa47 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -741,6 +741,8 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	bool new_clst = false;
 	bool no_da;
 	bool zero = false;
+
+	trace_ntfs3_iomap_begin(inode, offset, length, flags);
 	if (unlikely(ntfs3_forced_shutdown(sbi->sb)))
 		return -EIO;
 
@@ -879,6 +881,8 @@ static int ntfs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	struct ntfs_inode *ni = ntfs_i(inode);
 	loff_t endbyte = pos + written;
 
+	trace_ntfs3_iomap_end(inode, pos, length, written, flags);
+
 	if ((flags & IOMAP_WRITE) || (flags & IOMAP_ZERO)) {
 		if (iomap->type == IOMAP_INLINE) {
 			u32 data_size;
diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
index e39765bc062f..e0c0c44ce318 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -301,6 +301,56 @@ TRACE_EVENT(ntfs3_attr_data_get_block,
 		  __entry->zero, __entry->no_da)
 );
 
+TRACE_EVENT(ntfs3_iomap_begin,
+	TP_PROTO(struct inode *inode, loff_t offset, loff_t length,
+		 unsigned int flags),
+	TP_ARGS(inode, offset, length, flags),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+		__field(loff_t, offset)
+		__field(loff_t, length)
+		__field(dev_t, dev)
+		__field(unsigned int, flags)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->offset = offset;
+		__entry->length = length;
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->flags = flags;
+	),
+	TP_printk("dev=(%d,%d) ino=%lu offset=%lld length=%lld flags=0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->offset, __entry->length,
+		  __entry->flags)
+);
+
+TRACE_EVENT(ntfs3_iomap_end,
+	TP_PROTO(struct inode *inode, loff_t pos, loff_t length,
+		 ssize_t written, unsigned int flags),
+	TP_ARGS(inode, pos, length, written, flags),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+		__field(loff_t, pos)
+		__field(loff_t, length)
+		__field(ssize_t, written)
+		__field(dev_t, dev)
+		__field(unsigned int, flags)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->pos = pos;
+		__entry->length = length;
+		__entry->written = written;
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->flags = flags;
+	),
+	TP_printk("dev=(%d,%d) ino=%lu pos=%lld length=%lld written=%zd flags=0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->pos, __entry->length,
+		  __entry->written, __entry->flags)
+);
+
 #endif /* _TRACE_NTFS3_H */
 
 #include <trace/define_trace.h>
-- 
2.51.0

