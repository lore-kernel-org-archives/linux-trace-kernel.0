Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734B3559F8;
	Wed,  8 Apr 2026 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662418; cv=none; b=k4i8xCZomGBtPESCqy9toD9sYU88D/6yMilikmXUp4J3k1uKNXK95dJ9hxueL0/gxKci/v+IrSlODMy/2cLE10wBL+UsPa70vTanRzNUlff9sJJTXIGT68l85M6hSKprRvZWFJ/28o0hPfKpqqj3Gapf0d+1OhOsCn/4FYEhoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662418; c=relaxed/simple;
	bh=pBktVFYzsIAdZIy+AuRggPzGormErCwvYrjSX4sj3Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nDbW7lpHwnedCKN+e3sstbu0syMhzceLGlzHevenZdfTZkpDSSvKAVBtbWI9cNhYsHElBlQ7OomrCe8lgOVq45TDmsQdITZN4OpyR3d7Yy58xEHiHitel/RFEX5n+bluklzouSxlYGlI8L2uR7yNBJ/sGumuvEBaLVmuDInlp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MGMFyqw0; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MGMFyqw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=m3
	v3zp6YOjlmkyjzFU98l0AI8rJygb4GlywSbbSCQ88=; b=MGMFyqw0Ipo9tPmvBc
	0rNDAQbr6zLy9vdnYQ0KAtBpEreY2hu5cGFkGqxRtXbeYejY6BcxDHarmiiCDYB0
	abBdcjT0I5tlBSZ1NBc0rLRsU5HsXOFMDRuwP0jFLCP2gnvVOHgy1TPIyXZkHDlD
	zQMZ9zaxGuuquYNl9YN05pfGk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3_rofddZpBIHhDg--.36317S2;
	Wed, 08 Apr 2026 23:32:52 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] tracing: Store trace_marker_raw payload length in events
Date: Wed,  8 Apr 2026 23:32:40 +0800
Message-Id: <20260408153241.15391-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3_rofddZpBIHhDg--.36317S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr43uryrJFWUtFWDXryxKrg_yoW5Aw4kpa
	43tr9xGr4kJF4jqryI9an5ArWfZ34kJry3Ka95W34Fvr1ktr12qF9rXFyjv3yFqwn3K34f
	KFyj9rWjkw47Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOzVbUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCwAR2r2nWdSQV0wAA31

trace_marker_raw currently records its bytes in TRACE_RAW_DATA events,
but the event output path derives the byte count from the padded record
size in the ring buffer. As a result, the printed raw-data payload is
rounded up and small writes do not preserve their true length.

Keep the true payload length in the TRACE_RAW_DATA event itself and use
that field when printing the bytes. This leaves the ring buffer record
size semantics unchanged while letting trace_marker_raw report the exact
payload that was written.

Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 kernel/trace/trace.c         | 11 ++++++-----
 kernel/trace/trace_entries.h |  1 +
 kernel/trace/trace_output.c  |  4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a626211ce..d9cb643b8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6906,11 +6906,13 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct raw_data_entry *entry;
+	size_t payload_len;
 	ssize_t written;
 	size_t size;
 
 	/* cnt includes both the entry->id and the data behind it. */
-	size = struct_offset(entry, id) + cnt;
+	payload_len = cnt - sizeof(entry->id);
+	size = struct_offset(entry, buf) + payload_len;
 
 	buffer = tr->array_buffer.buffer;
 
@@ -6924,10 +6926,9 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 		return -EBADF;
 
 	entry = ring_buffer_event_data(event);
-	unsafe_memcpy(&entry->id, buf, cnt,
-		      "id and content already reserved on ring buffer"
-		      "'buf' includes the 'id' and the data."
-		      "'entry' was allocated with cnt from 'id'.");
+	memcpy(&entry->id, buf, sizeof(entry->id));
+	entry->len = payload_len;
+	memcpy(entry->buf, buf + sizeof(entry->id), payload_len);
 	written = cnt;
 
 	__buffer_unlock_commit(buffer, event);
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 54417468f..5f867a144 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -288,6 +288,7 @@ FTRACE_ENTRY(raw_data, raw_data_entry,
 
 	F_STRUCT(
 		__field(	unsigned int,	id	)
+		__field(unsigned int, len)
 		__dynamic_array(	char,	buf	)
 	),
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 1996d7aba..4e1edfa05 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1817,13 +1817,13 @@ static enum print_line_t trace_raw_data(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct raw_data_entry *field;
-	int i;
+	unsigned int i;
 
 	trace_assign_type(field, iter->ent);
 
 	trace_seq_printf(&iter->seq, "# %x buf:", field->id);
 
-	for (i = 0; i < iter->ent_size - offsetof(struct raw_data_entry, buf); i++)
+	for (i = 0; i < field->len; i++)
 		trace_seq_printf(&iter->seq, " %02x",
 				 (unsigned char)field->buf[i]);
 
-- 
2.39.5 (Apple Git-154)

