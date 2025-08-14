Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280F1F582A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174144; cv=none; b=e3UkRYtnqldu2qzyjHeARZpJ7k0BIHnXP+vB48JptVK5Jn6AtMdh7k49aqVrFc5IwuPSuK/f3qMXMABsfi8UQrxUnwpp7IAJy8d2/EMrOZA/NEiiDUxXDKZR8pgZl7J4QoyIJ2iC0mIFhF+6YBdL4doebgDOn79B028ezqz6WOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174144; c=relaxed/simple;
	bh=W4gf439JfbyV/7KdGp+M6ANXWSnSGAo8Pl1nandkIlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRpQCl68i8HXi+wgmFfXcKi0T4iz7rft5E73OkLOSSwtathXGkoRpHCepRtzZaKosUvFAnGVImh+yM6xkeB337COQh47T+x3lpI5YHwy/XOVFLowSyNCDkljBojZJ9NpUNYQ3+3HgyVqBjbPKlGnmyNzAmImTbxRzioGZNhtEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhDybWOe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhDybWOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755174142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pt8/QjWB8CWN6SCfty+MuEXdLYmtGWrGQdCKz0oZNzo=;
	b=QhDybWOe3YGFatLeaWpPKsXYpSod+5TvoW27Acbiczdl+mn6hGufDKjMiiPPryAoD7phw5
	0p/s3tuc7tPemHZfzhjSUhS7CDyMlNuz/A/gYXF+tpB7eHgwxvVtnwKet1AnKbhnVI8+Sa
	E4Cj4MlI6Qo27aoXrCduzfUxkqxRxXI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-R2niOJslOFyaxL2WfdnhEQ-1; Thu,
 14 Aug 2025 08:22:19 -0400
X-MC-Unique: R2niOJslOFyaxL2WfdnhEQ-1
X-Mimecast-MFC-AGG-ID: R2niOJslOFyaxL2WfdnhEQ_1755174134
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFBF21955EBE;
	Thu, 14 Aug 2025 12:22:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.15])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F3911800446;
	Thu, 14 Aug 2025 12:22:11 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [PATCH v4] tracing: add testable specifications for event_enable_write/read
Date: Thu, 14 Aug 2025 14:22:06 +0200
Message-ID: <20250814122206.109096-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch implements the documentation of event_enable_write and
event_enable_read in the form of testable function's expectations.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
Changes from v1:
- Added "Context:" information and "Assumptions of use"

Changes from v2 and v3:
- Addressed comments from: https://lore.kernel.org/linux-trace-kernel/CA+wEVJbjhLmA4ZR5w7s6QDCfjET=Pf2J9PsFhC2wdO1nQ5YY+A@mail.gmail.com/T/#ma46663274411b08c14f380a69363dc6225b09a45
---
 kernel/trace/trace_events.c | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9f3e9537417d..af89eaed6a43 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1772,6 +1772,49 @@ static void p_stop(struct seq_file *m, void *p)
 	mutex_unlock(&event_mutex);
 }
 
+/**
+ * event_enable_read - read from a trace event file to retrieve its status.
+ * @filp: file pointer associated with the target trace event.
+ * @ubuf: user space buffer where the event status is copied to.
+ * @cnt: number of bytes to be copied to the user space buffer.
+ * @ppos: the current position in the buffer.
+ *
+ * This is a way for user space executables to retrieve the status of a
+ * specific event
+ *
+ * Function's expectations:
+ * - The global event_mutex shall be taken before performing any operation
+ *   on the target event;
+ *
+ * - The string copied to user space shall be formatted according to the
+ *   status flags from the target event file:
+ *   - If the enable flag is set AND the soft_disable flag is not set then
+ *     the first character shall be set to "1" ELSE it shall be set to "0";
+ *
+ *   - If either the soft_disable flag or the soft_mode flag is set then the
+ *     second character shall be set to "*" ELSE it is skipped;
+ *
+ *   - The string shall be terminated by a newline ("\n") and any remaining
+ *     character shall be set to "0";
+ *
+ * - This function shall invoke simple_read_from_buffer() to perform the copy
+ *   of the kernel space string to ubuf.
+ *
+ * Assumptions of Use:
+ * - The caller shall pass cnt equal or greater than the length of the string
+ *   to be copied to user space;
+ *
+ * - Any read operation on a file descriptor, unless it is the first operation
+ *   following a trace event file open, shall be preceded by an lseek
+ *   invocation to reposition the file offset to zero.
+ *
+ * Context: process context, locks and unlocks event_mutex.
+ *
+ * Return:
+ * * the number of copied bytes on success
+ * * %-ENODEV - the event file cannot be retrieved from the input filp
+ * * any error returned by simple_read_from_buffer
+ */
 static ssize_t
 event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		  loff_t *ppos)
@@ -1801,6 +1844,47 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf));
 }
 
+/**
+ * event_enable_write - write to a trace event file to enable/disable it.
+ * @filp: file pointer associated with the target trace event.
+ * @ubuf: user space buffer where the enable/disable value is copied from.
+ * @cnt: number of bytes to be copied from the user space buffer.
+ * @ppos: the current position in the buffer.
+ *
+ * This is a way for user space executables to enable or disable event
+ * recording.
+ *
+ * Function's expectations:
+ * - This function shall copy cnt bytes from the input ubuf buffer to a kernel
+ *   space buffer and shall convert the string within the kernel space buffer
+ *   into a decimal base format number;
+ *
+ * - The global event_mutex shall be taken before performing any operation
+ *   on the target event;
+ *
+ * - This function shall check the size of the per-cpu ring-buffers used for
+ *   the event trace data and, if smaller than TRACE_BUF_SIZE_DEFAULT, expand
+ *   them to TRACE_BUF_SIZE_DEFAULT bytes (sizes larger than
+ *   TRACE_BUF_SIZE_DEFAULT are not allowed);
+ *
+ * - This function shall invoke ftrace_event_enable_disable to enable or
+ *   disable the target trace event according to the value read from user space
+ *   (0 - disable, 1 - enable);
+ *
+ * - This function shall increase the file position pointed by ppos by the
+ *   number of bytes specified by cnt.
+ *
+ * Context: process context, locks and unlocks event_mutex.
+ *
+ * Return:
+ * * the number of written bytes on success
+ * * any error returned by kstrtoul_from_user
+ * * %-ENODEV - the event file cannot be retrieved from the input filp
+ * * any error returned by tracing_update_buffers
+ * * any error returned by ftrace_event_enable_disable
+ * * %-EINVAL - the value copied from the user space ubuf is different
+ * from 0 or 1
+ */
 static ssize_t
 event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		   loff_t *ppos)
-- 
2.48.1

