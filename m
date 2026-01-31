Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD835505A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866176; cv=none; b=IjfkXrz41dY0eVlkzcvLJ0abHQ7S7R3xJV5DmzJ2bKg89g49IY7tG5+G4CQsP7AbJiD1hbFnPsoAH1dqMwuZgZGqSNPWTdphBuSr/37EKF+2dXNUB95S3Dfz2fnFonTCQeLMroAxo5Wb8HHXD3T0ryz3UaFcHqJLgbfOTtyCB+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866176; c=relaxed/simple;
	bh=eRffXUckXcnAARjC6Ts6AzruwJOgdF+tgT6EGLF7ldw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rvy54dUAzsUmk4OwzPQDB3tsTfE5nqyA5b2CqmbE1pKts2s21rKhIvKdSsfZJv4oyH3si6aOMngI9MKhEVWOOEu3Prss8YF/KnP5ooJjHmmPXAW2rdcShkUYBO99mLFNsPYNhywo0RA4NqaHFy74gsMJ9j50kGeoGVn7SJovghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=An5gUhcZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="An5gUhcZ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48071615686so22052405e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866171; x=1770470971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKtOhL3oFvJF/4kwFHqLo6w652pvqCPdYh+Oa+lYSBY=;
        b=An5gUhcZ1hyPch1kKoH+dZttR0D2y2Sh5F5+YAuAOShw7cvu0dpnFcp9Luzv2Ppv0a
         PtRyCxOGcvH5GdI+VJjZH6dsut841K5IjJqFa5pfecyCJTkrlPLZ8STKc0NZEHnslbXq
         HFGbCkyOHrp3VrkGlSn0sh4LBUM/6oofexJagxNpAn2CSPM+hBvjvkGmSaQxlVH+LuJI
         nE2v42JiwensVJA+zZO+nIEVXvEf0kNxtNDzk8F2M1t/Kj8dXTg+zflH0YFBPqaco9mf
         o3nKxOfIxQESAS9AkCImcUh7qnPjCKRi6rqeUNd8e8Q6NK5HI2aLoXq5vnaR13MsEjng
         NTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866171; x=1770470971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKtOhL3oFvJF/4kwFHqLo6w652pvqCPdYh+Oa+lYSBY=;
        b=HNGi+fFPXTen2IswKWvLrEmp9UKYbFVzX7Nl/qntbkOTnheUZIeOdEDBCAPsPqAkTA
         UvVX9sMGkWsBUs1w1OpL+PgaNDBguko4cOCoEwSEO8z78HZbiJQhP9NI2MD8/ftR/8Nb
         3zP2bPt2NM7GNsq4gp9O+MKaZSL9ODzEFxol4bRLdP//O8lrhiIQHBp/S+/yKFbbCfMu
         TBQz4VTTG+2P0/SF4rsc5I8peyWsaFOsO8iQOx8/+WlcJ9bA5SU5odMOJhe8CHmEAzxo
         u+VPsZODjerWJxI8rbPADAKfpXFYWuBQ9CPUxpJUiK/jScAa938ApJquiVTz1j/e9M2V
         P5zw==
X-Forwarded-Encrypted: i=1; AJvYcCWM+0YZq4ZaBierTPUDVUcS5PtA7DwlQpiqQpIUww6krJO1BPW+h89v1a7L+Smg23+OJWTyYBxt+Zv8LGmlIOQtBks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyN0hmgAe1sRkew7BKRNFeA3eOu4DMbt40Qw2K3KqiAgeaFkBA
	x3hWxhMUKQsilVc0VE+KD4C+stDbxBqtzdEk0Y1zpI6rDm0KdkDfk1zXPE1rbJQn7P8aqo7qv1w
	D/xntwQYRQ6TW1e/2xhqcmg==
X-Received: from wmcn7.prod.google.com ([2002:a05:600c:c0c7:b0:47a:9289:c5d8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e8a:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-482db4992famr80888375e9.35.1769866170752;
 Sat, 31 Jan 2026 05:29:30 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:28 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-11-vdonnefort@google.com>
Subject: [PATCH v11 10/30] tracing: Add events/ root files to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Just like for the kernel events directory, add 'enable', 'header_page'
and 'header_event' at the root of the trace remote events/ directory.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2d08dd326309..e28cc02d1a70 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -639,7 +639,8 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)buffer->subbuf_size,
+			 (unsigned int)(buffer ? buffer->subbuf_size :
+						 PAGE_SIZE - BUF_PAGE_HDR_SIZE),
 			 (unsigned int)is_signed_type(char));
 
 	return !trace_seq_has_overflowed(s);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index b8bb43b3acd2..999bf93f40c1 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1128,10 +1128,145 @@ static int remote_event_callback(const char *name, umode_t *mode, void **data,
 	return 0;
 }
 
+static ssize_t remote_events_dir_enable_write(struct file *filp, const char __user *ubuf,
+					      size_t count, loff_t *ppos)
+{
+	struct trace_remote *remote = file_inode(filp)->i_private;
+	int i, ret;
+	u8 enable;
+
+	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&remote->lock);
+
+	for (i = 0; i < remote->nr_events; i++) {
+		struct remote_event *evt = &remote->events[i];
+
+		trace_remote_enable_event(remote, evt, enable);
+	}
+
+	return count;
+}
+
+static ssize_t remote_events_dir_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
+					     loff_t *ppos)
+{
+	struct trace_remote *remote = file_inode(filp)->i_private;
+	const char enabled_char[] = {'0', '1', 'X'};
+	char enabled_str[] = " \n";
+	int i, enabled = -1;
+
+	guard(mutex)(&remote->lock);
+
+	for (i = 0; i < remote->nr_events; i++) {
+		struct remote_event *evt = &remote->events[i];
+
+		if (enabled == -1) {
+			enabled = evt->enabled;
+		} else if (enabled != evt->enabled) {
+			enabled = 2;
+			break;
+		}
+	}
+
+	enabled_str[0] = enabled_char[enabled == -1 ? 0 : enabled];
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, enabled_str, 2);
+}
+
+static const struct file_operations remote_events_dir_enable_fops = {
+	.write = remote_events_dir_enable_write,
+	.read = remote_events_dir_enable_read,
+};
+
+static ssize_t
+remote_events_dir_header_page_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_seq *s;
+	int ret;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	trace_seq_init(s);
+
+	ring_buffer_print_page_header(NULL, s);
+	ret = simple_read_from_buffer(ubuf, cnt, ppos, s->buffer, trace_seq_used(s));
+	kfree(s);
+
+	return ret;
+}
+
+static const struct file_operations remote_events_dir_header_page_fops = {
+	.read = remote_events_dir_header_page_read,
+};
+
+static ssize_t
+remote_events_dir_header_event_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_seq *s;
+	int ret;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	trace_seq_init(s);
+
+	ring_buffer_print_entry_header(s);
+	ret = simple_read_from_buffer(ubuf, cnt, ppos, s->buffer, trace_seq_used(s));
+	kfree(s);
+
+	return ret;
+}
+
+static const struct file_operations remote_events_dir_header_event_fops = {
+	.read = remote_events_dir_header_event_read,
+};
+
+static int remote_events_dir_callback(const char *name, umode_t *mode, void **data,
+				      const struct file_operations **fops)
+{
+	if (!strcmp(name, "enable")) {
+		*mode = TRACEFS_MODE_WRITE;
+		*fops = &remote_events_dir_enable_fops;
+		return 1;
+	}
+
+	if (!strcmp(name, "header_page")) {
+		*mode = TRACEFS_MODE_READ;
+		*fops = &remote_events_dir_header_page_fops;
+		return 1;
+	}
+
+	if (!strcmp(name, "header_event")) {
+		*mode = TRACEFS_MODE_READ;
+		*fops = &remote_events_dir_header_event_fops;
+		return 1;
+	}
+
+	return 0;
+}
+
 static int trace_remote_init_eventfs(const char *remote_name, struct trace_remote *remote,
 				     struct remote_event *evt)
 {
 	struct eventfs_inode *eventfs = remote->eventfs;
+	static struct eventfs_entry dir_entries[] = {
+		{
+			.name		= "enable",
+			.callback	= remote_events_dir_callback,
+		}, {
+			.name		= "header_page",
+			.callback	= remote_events_dir_callback,
+		}, {
+			.name		= "header_event",
+			.callback	= remote_events_dir_callback,
+		}
+	};
 	static struct eventfs_entry entries[] = {
 		{
 			.name		= "enable",
@@ -1147,7 +1282,8 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
 	bool eventfs_create = false;
 
 	if (!eventfs) {
-		eventfs = eventfs_create_events_dir("events", remote->dentry, NULL, 0, NULL);
+		eventfs = eventfs_create_events_dir("events", remote->dentry, dir_entries,
+						    ARRAY_SIZE(dir_entries), remote);
 		if (IS_ERR(eventfs))
 			return PTR_ERR(eventfs);
 
-- 
2.53.0.rc1.225.gd81095ad13-goog

