Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158063;
	b=AOuByMgtT/7uaf+JZgUHi4BvLKUnKdxIFFyXEen3/NHvVJDkQzKTvCEhKBjnRn54rlpF
	 jdq6td7P4HsZhL5pRpHE4ZYLm+lc93QmH6/NSPv/mk0Tvg7UhzFjksrvs/fWfPscOS2lR
	 p01DGNiLSx8P+7D1UDIWqOZLe/XbntVqVxsf401YS5V6DyuKkA11h5JZbKqCCzCkzje5W
	 Iug0vp9G1yNWPSsx/lyf30ilCBGzsqwfA6kOaalL9q6U5VwlsD8aF6lmrX1Yc/+knyTMS
	 ewlaYtkpD99sUTowWSgReFgyXydl06QqaUm/6Nm6Zic8z3eEnzNxnb3c/yoyynrXVVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158063;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=YJZmD/Zi49UN7sLwX34mBzYQixZ1bT9Ts04aoLBSwKo=;
	b=h4hufflR0DVHg3EN814o5OSdfeKElfOkSKM4Hrxw/nPPZIEiYEAha7fGSzVrGysL8jjz
	 2mbxMTp65ujGVH5NU1bi9wrxsLb4AowMex6+BBBgwrwXvobVrmqcUeZoz8qzgo4sukRmN
	 P4xFaZOaGZOeqXgFbisJmR8YYjI8K0GPOiP9n1dbLWcKGEneFQImug9/GA1LD+JTXRQQJ
	 wxMTcBHrbRuecLBjDfwg7XgBjXisQyU868ocLdaaRgVWa7D3Cw8IMPgU8NVIhqKIF8pKw
	 S4I9xLnpuLwBa4GP6rgtGmP4i9VZS1WYz2YZTR0NrGVLBwEfRiHdgczZ7al///gLtqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=S6RlbAN0;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C01606A31D;
	Wed, 28 Oct 2026 03:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C01606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=S6RlbAN0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=YJZmD/Zi49UN7sLwX34mBzYQixZ1bT9Ts04aoLBSwKo=;
	b=S6RlbAN0LOrbntaVGNNzoJ7aB+6MECf0HW0JE6ZdmdbkdWtXzX84Xbgp6Wg0C7
	MKbjF7UZM1dYuDh/UpJztkbeKnHrQMQcE6QOKjGWORMayaZTlDS/gCg6ZjSqfgiq
	N63gQThUVvd+p5q+XI2EsMxq3oBoTgAXIrw9gt42zMHJU=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: record jiffies in writeback events instead of computing age
Date: Wed, 28 Oct 2026 11:25:24 +0800
Message-ID: <1793157924.328974.4869096@163.com>
In-Reply-To: <20261026084709.26f7737f@fedora>
References: <179299543891.294518.18224691820856958686@163.com> <20261026084709.26f7737f@fedora>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3jyZ8a+FqYjd8DQ--.30226S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1kKw4DXryrWry5XFWxtFb_yoWrCrW3pF
	ZFyr9rKr4vvrW7Kw1kuay0qr1Uu3ykCFW7KF1UWFy7Z3Z5XFs5tF90gr1Fvwn8ArZa9342
	va90vr95A3W8XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joHq7UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5B0Ngmrha30gGwAA3Q

From 677560a14dae0d9581effc5cdb9375052902bb21 Mon Sep 17 00:00:00 2001
From: Chaosheng Qu <quchaosheng000406@163.com>
Date: Tue, 27 Oct 2026 14:28:09 +0800
Subject: [PATCH] tracing: record jiffies in writeback events instead of
 computing age

writeback_sb_inodes_requeue and writeback_single_inode_start/() compute
the inode age with:

	(jiffies - __entry->dirtied_when) / HZ

inside TP_printk().  TP_printk() is not part of the recorded event: it
runs when the trace is read back, so the expression is evaluated at
formatter time, not at the time the event was recorded.

It is also evaluated outside of the kernel: tracefs renders the format
string once and userspace re-evaluates it.  A tool that has to resolve
every symbol in the expression (trace-cmd and the parser in LISA both
do) resolves the bare "jiffies" to its address, so the printed age
becomes ((unsigned long)&jiffies - dirtied_when) / HZ, which is
nonsense.  This was reported as a wrong "age" value in trace-cmd
output:

  https://bugzilla.kernel.org/show_bug.cgi?id=219839

Nothing in TP_printk() may depend on the state of the machine at read
time, which is the same rule that keeps ktime_get() and friends out of
it.

v1 stored the age itself in TP_fast_assign().  Steve pointed out that
the division then runs on the trace path, which is where the side
effects have to stay small, and that recording the jiffies snapshot
instead lets userspace compute whatever it wants from the raw value.
Do that: save jiffies in TP_fast_assign() and keep the subtraction and
the division in TP_printk(), where they run on the slow path.  This
follows the same shape as xprtrdma_req's connect/reconnect fields.

The new __entry->jiffies field is appended after the existing fields,
so no existing field changes offset and trace consumers that index the
event by offset keep working.  The "age=%lu" placeholder keeps its
position in the output text, and the value it prints is unchanged.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219839
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 include/trace/events/writeback.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 13ee076cc..b7dfc9f7b 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -745,6 +745,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		__field(u64, cgroup_ino)
 		__field(unsigned long, state)
 		__field(unsigned long, dirtied_when)
+		__field(unsigned long, jiffies)
 	),
 
 	TP_fast_assign(
@@ -753,6 +754,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode_state_read_once(inode);
 		__entry->dirtied_when	= inode->dirtied_when;
+		__entry->jiffies	= jiffies;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
 	),
 
@@ -761,7 +763,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
 		  __entry->dirtied_when,
-		  (jiffies - __entry->dirtied_when) / HZ,
+		  (__entry->jiffies - __entry->dirtied_when) / HZ,
 		  __entry->cgroup_ino
 	)
 );
@@ -784,6 +786,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		__field(unsigned long, writeback_index)
 		__field(unsigned long, wrote)
 		__field(long, nr_to_write)
+		__field(unsigned long, jiffies)
 	),
 
 	TP_fast_assign(
@@ -795,6 +798,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		__entry->writeback_index = inode->i_mapping->writeback_index;
 		__entry->nr_to_write	= nr_to_write;
 		__entry->wrote		= nr_to_write - wbc->nr_to_write;
+		__entry->jiffies	= jiffies;
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
 	),
 
@@ -804,7 +808,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
 		  __entry->dirtied_when,
-		  (jiffies - __entry->dirtied_when) / HZ,
+		  (__entry->jiffies - __entry->dirtied_when) / HZ,
 		  __entry->writeback_index,
 		  __entry->nr_to_write,
 		  __entry->wrote,
-- 
2.43.0


