Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74F376A12;
	Fri, 17 Jul 2026 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784258644; cv=none; b=jEzsomLgsAAlkjRn2Y6/QWhZJBV+ctdpXMG17mdbEGSJYXur1s6cREKBDWzihKm51eNc6k3Fve9i68jVYYCDRW5UmihMdouEl+HHBV4/udLxZlHux//Ba+tyRCm3j2Ti9nl0K2vlLKnFPWdP6Xg37u6IEjpVnLlr8x5PUoz7svw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784258644; c=relaxed/simple;
	bh=FQKaSxhLSaUJixAnulKwFsuSp2AwAKOMM8MfnmgoIJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEExyBOoFmFO+oUA51gAcHwFeCgW5GY50wkxn3DQAsR3n4ritgziuRSvmxHf4/ZDoomtkNQea5IUh9s0h+Zr0FOtDWmXIDYZuW8BV/rDWR6HPts9khulqSexlIRaixCEyJSAgi6afvkc9mq3+wtS4fjaq/WMxoHw9bTukUBZcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nq/yL+j/; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nq/yL+j/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SO
	M4C9GmnczKsAnjpNRI6HBAPSGvqdSmbUd2Vp5zEQE=; b=nq/yL+j/SXvO8TBDwM
	18GXWPQayxtobPFsFUCT4hUcck03fK5lueOWiDNOMjVFDRiCUP3EFWyGJ5LckFUO
	o2CVrOqSfl/gy7XSf2MGP3xVfi/7BCS4A8eyz+e4yxaMCweycdvNrQ6ucEF0QS3Z
	b5DT7mBG4Y7D4pOK01kO731Us=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3twcPoFlqvNaLJg--.4501S8;
	Fri, 17 Jul 2026 11:23:19 +0800 (CST)
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
Subject: [PATCH v1 v1 6/7] ntfs3: add iomap tracepoints
Date: Fri, 17 Jul 2026 11:22:47 +0800
Message-ID: <20260717032248.3318208-7-liubaolin12138@163.com>
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
X-CM-TRANSID:_____wD3twcPoFlqvNaLJg--.4501S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr18XF1rWF4DtF1rAryxXwb_yoW5CFWxp3
	ZFyFZxGa97JrW29wsayw4FqF4ava4xur4Utr17Wryaya1xt3WxKF4vgFyjvw18AF1jkr1I
	gF90vryUG3WUXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBMKZUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gci7GpZoCdKQgAA3f

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
index 2bc4ce2ee8d8..bccb3feb5f3b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -744,6 +744,8 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	bool new_clst = false;
 	bool no_da;
 	bool zero = false;
+
+	trace_ntfs3_iomap_begin(inode, offset, length, flags);
 	if (unlikely(ntfs3_forced_shutdown(sbi->sb)))
 		return -EIO;
 
@@ -882,6 +884,8 @@ static int ntfs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	struct ntfs_inode *ni = ntfs_i(inode);
 	loff_t endbyte = pos + written;
 
+	trace_ntfs3_iomap_end(inode, pos, length, written, flags);
+
 	if ((flags & IOMAP_WRITE) || (flags & IOMAP_ZERO)) {
 		if (iomap->type == IOMAP_INLINE) {
 			u32 data_size;
diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
index 552f991b5257..a846aa61153c 100644
--- a/include/trace/events/ntfs3.h
+++ b/include/trace/events/ntfs3.h
@@ -307,6 +307,56 @@ TRACE_EVENT(ntfs3_attr_data_get_block,
 		  __entry->zero, __entry->no_da)
 );
 
+TRACE_EVENT(ntfs3_iomap_begin,
+	TP_PROTO(struct inode *inode, loff_t offset, loff_t length,
+		 unsigned int flags),
+	TP_ARGS(inode, offset, length, flags),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(loff_t, offset)
+		__field(loff_t, length)
+		__field(unsigned int, flags)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->offset = offset;
+		__entry->length = length;
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
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(loff_t, pos)
+		__field(loff_t, length)
+		__field(ssize_t, written)
+		__field(unsigned int, flags)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->pos = pos;
+		__entry->length = length;
+		__entry->written = written;
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

