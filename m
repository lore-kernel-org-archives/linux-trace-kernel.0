Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C625C713
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jun 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291732; cv=none; b=sQ12WqVmj3is82NbJ93d2rvK0kmeIdWJwj9aN5JVc71anvooB5AO/SBBAfPXu2jLOsclCYPtp943VIwT3ZNGHVgeL68jvJgxpYbIKlR893EdWNaIJn/BBynD4b3LcL0o0glpLulv4PtAUrfcBjjXmMtQHm2u0BUj812VM1zH75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291732; c=relaxed/simple;
	bh=D9GX2dwxQBib/I+ILRXLyzWrh5hsUUYESfNRb27DbOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ap08nEkTB68pR1V3a0o38FRj7rtdlEZrig520IZqX3/TWRhnTDZm1QuoneK7kWpVmtBCpBAVjd3ClM/cGfy8nY8OGzobmV9R9+EaALme9VAT6PCUq/XqYh2z69vhTpH7V62v7jPM09MFYy4oqhjhHTY9Q0jnMup5Ss1Q9D4Af7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBdFBbWf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBdFBbWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751291730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8M7YOkRNim71wIfF0xnL2v90Hu8gC5vQxiVvbWSPJI4=;
	b=aBdFBbWflZLLUOimnZkAY/G1psNlMBntzXaPeYXglBj8X9PO2GaZAqQUR/v8ObtHqmwT3J
	4qy9rOHFRB6/B1AAogzvJ3LoOsqhZO+i+qX9HL/OPZAX20njdkznt1DLqmDL90lLX8uooq
	iwe9l18yA93c77iDhh9Mr7RdKbfgj/g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-ZP-jm77qPaKBkagccV4PaQ-1; Mon,
 30 Jun 2025 09:55:28 -0400
X-MC-Unique: ZP-jm77qPaKBkagccV4PaQ-1
X-Mimecast-MFC-AGG-ID: ZP-jm77qPaKBkagccV4PaQ_1751291727
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4989218DA5CA;
	Mon, 30 Jun 2025 13:55:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.242.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CBAD19560A7;
	Mon, 30 Jun 2025 13:55:24 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH v2] tracing: add testable specifications for event_enable_write/read
Date: Mon, 30 Jun 2025 15:55:19 +0200
Message-ID: <20250630135519.11429-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch implements the documentation of event_enable_write and
event_enable_read in the form of testable function's expectations.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
Following the discussion in v1 (see [1]), v2 adds improvements with
the "Context" specifications and the definition of the assumptions
of use for the correct invocation of the documented functions.

[1] https://lore.kernel.org/linux-trace-kernel/20250612104349.5047-1-gpaoloni@redhat.com/
---
 kernel/trace/trace_events.c | 81 +++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..57284f540566 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1771,6 +1771,52 @@ static void p_stop(struct seq_file *m, void *p)
 	mutex_unlock(&event_mutex);
 }
 
+/**
+ * event_enable_read - read from a trace event file to retrieve its status.
+ * @filp: file pointer associated with the target trace event;
+ * @ubuf: user space buffer where the event status is copied to;
+ * @cnt: number of bytes to be copied to the user space buffer;
+ * @ppos: the current position in the buffer.
+ *
+ * This is a way for user space executables to retrieve the status of a
+ * specific event
+ *
+ * Function's expectations:
+ * - This function shall lock the global event_mutex before performing any
+ *   operation on the target event file and unlock it after all operations on
+ *   the target event file have completed;
+ * - This function shall retrieve the status flags from the file associated
+ *   with the target event;
+ * - This function shall format the string to report the event status to user
+ *   space:
+ *   - The first character of the string to be copied to user space shall be
+ *     set to "1" if the enabled flag is set AND the soft_disabled flag is not
+ *     set, else it shall be set to "0";
+ *   - The second character of the string to be copied to user space shall be
+ *     set to "*" if either the soft_disabled flag or the soft_mode flag is
+ *     set, else it shall be set to "\n";
+ *   - The third character of the string to be copied to user space shall b
+ *     set to "\n" if either the soft_disabled flag or the soft_mode flag is
+ *     set, else it shall be set to "0";
+ *   - Any other character in the string to be copied to user space shall be
+ *     set to "0";
+ * - This function shall invoke simple_read_from_buffer() to perform the copy
+ *   of the kernel space string to ubuf.
+ *
+ * Assumptions of Use:
+ * - The caller shall  pass cnt equal or greater than the length of the string
+ *   to be copied to user space;
+ * - Any read operation on a file descriptor, unless it is the first operation
+ *   following a trace event file open, shall be preceded by an lseek
+ *   invocation to reposition the file offset to zero.
+ *
+ * Context: process context, locks and unlocks event_mutex.
+ *
+ * Return: the number of copied bytes on success, -ENODEV if the event file
+ * cannot be retrieved from the input filp, -EINVAL if cnt is less than the
+ * length of the string to be copied to ubuf, any error returned by
+ * simple_read_from_buffer
+ */
 static ssize_t
 event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		  loff_t *ppos)
@@ -1801,6 +1847,41 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf));
 }
 
+/**
+ * event_enable_write - write to a trace event file to enable/disable it.
+ * @filp: file pointer associated with the target trace event;
+ * @ubuf: user space buffer where the enable/disable value is copied from;
+ * @cnt: number of bytes to be copied from the user space buffer;
+ * @ppos: the current position in the buffer.
+ *
+ * This is a way for user space executables to enable or disable event
+ * recording.
+ *
+ * Function's expectations:
+ * - This function shall copy cnt bytes from the input ubuf buffer to a kernel
+ *   space buffer and shall convert the string within the kernel space buffer
+ *   into a decimal base format number;
+ * - This function shall lock the global event_mutex before performing any
+ *   operation on the target event file and unlock it after all operations on
+ *   the target event file have completed;
+ * - This function shall check the size of the per-cpu ring-buffers used for
+ *   the event trace data and, if smaller than TRACE_BUF_SIZE_DEFAULT, expand
+ *   them to TRACE_BUF_SIZE_DEFAULT bytes (sizes larger than
+ *   TRACE_BUF_SIZE_DEFAULT are not allowed);
+ * - This function shall invoke ftrace_event_enable_disable to enable or
+ *   disable the target trace event according to the value read from user space
+ *   (0 - disable, 1 - enable);
+ * - This function shall increase the file position pointed by ppos by the
+ *   number of bytes speicified by cnt;
+ *
+ * Context: process context, locks and unlocks event_mutex.
+ *
+ * Return: the number of written bytes on success, any error returned by
+ * kstrtoul_from_user, -ENODEV if the event file cannot be retrieved from the
+ * input filp, any error returned by tracing_update_buffers, any error returned
+ * by ftrace_event_enable_disable, -EINVAL if the value copied from the user
+ * space ubuf is different from 0 or 1.
+ */
 static ssize_t
 event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		   loff_t *ppos)
-- 
2.48.1

