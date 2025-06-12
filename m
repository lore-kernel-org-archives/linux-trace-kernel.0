Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F123AE7C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Jun 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725055; cv=none; b=Eh0TR8xtVIthPS+DUm6orbZN3gXB758L60j24rc9921J8yfj+YgOXj5fj5QKBmCbnHvBdpjF448FLZKJXArFQfdDmJ3g1s5Bu0SXElfAkVfAgh9EK6HKEl1CbJU+Ptv5o4GN5FPCmCagiaqmy5vsCjqjyRU4rQXfkNYkbPAHZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725055; c=relaxed/simple;
	bh=2T7OvIvbXQpz1az1cTon17qTeu5hxE6aNMsf4Szhn7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UosemfYrcB70j+ZOTfE5ggF3Z3A/2F2AzmkY8gzVgLM8KdJnCnCWAbu+L7/g/n3usvy7mY6RFy/lZ/JqaAXqATzOR+nMxzoBR8TWPRyy4LDzJR6u8Vg1W5TBvpe5KM/EGCD0A+UnbhseUHDn6GEABR4+dlFlmB6Dd4f1LATLGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxZK6CIV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxZK6CIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749725052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mv1uqkDZHNNjQcmTQAzf5MMmJ3eI0GyQ5KwebHi6ukY=;
	b=YxZK6CIVwS8mh53iw5bzHPHNeDpHsE45MUFpDq+pza7FyB8rn5faLQnfU4xE0gVj6dFiIe
	Dyxtc1JvJpNYWNBifPLI0GzCy0culI9xJmsz7AhLPoJI1qCPiL19RjTr/8CKUFkHsqgQRH
	uxbBxcDQym5swS1QqWROdpRMnrEpkgE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-tKtALmS2PBKkTbNK5PcTxw-1; Thu,
 12 Jun 2025 06:44:09 -0400
X-MC-Unique: tKtALmS2PBKkTbNK5PcTxw-1
X-Mimecast-MFC-AGG-ID: tKtALmS2PBKkTbNK5PcTxw_1749725048
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 455AF1800283;
	Thu, 12 Jun 2025 10:44:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.242.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B58B19560B2;
	Thu, 12 Jun 2025 10:44:04 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: acarmina@redhat.com,
	chuck.wolber@boeing.com,
	Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH 2/2] tracing: add testable specifications for event_enable_write/read
Date: Thu, 12 Jun 2025 12:43:49 +0200
Message-ID: <20250612104349.5047-3-gpaoloni@redhat.com>
In-Reply-To: <20250612104349.5047-1-gpaoloni@redhat.com>
References: <20250612104349.5047-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This patch implements the documentation of event_enable_write and
event_enable_read in the form of testable function's expectations.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
 kernel/trace/trace_events.c | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 5e84ef01d0c8..eb3c5e6e557d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1771,6 +1771,46 @@ static void p_stop(struct seq_file *m, void *p)
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
+ * - This function shall check if the requested cnt bytes are equal or greater
+ *   than the length of the string to be copied to user space (else a
+ *   corrupted event status could be reported);
+ * - This function shall invoke simple_read_from_buffer() to perform the copy
+ *   of the kernel space string to ubuf.
+ *
+ * Returns the number of copied bytes on success, -ENODEV if the event file
+ * cannot be retrieved from the input filp, -EINVAL if cnt is less than the
+ * length of the string to be copied to ubuf, any error returned by
+ * simple_read_from_buffer
+ */
 static ssize_t
 event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		  loff_t *ppos)
@@ -1808,6 +1848,38 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
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
+ *   space buffer (or the whole input ubuf if cnt is larger than ubuf size)
+ *   and shall convert the string within the kernel space buffer into a decimal
+ *   base format number;
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
+ *
+ * Returns 0 on success, any error returned by kstrtoul_from_user, -ENODEV if
+ * the event file cannot be retrieved from the input filp, any error returned by
+ * tracing_update_buffers, any error returned by ftrace_event_enable_disable,
+ * -EINVAL if the value copied from the user space ubuf is different from 0 or
+ *  1.
+ */
 static ssize_t
 event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		   loff_t *ppos)
-- 
2.48.1

