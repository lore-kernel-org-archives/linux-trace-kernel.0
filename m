Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC43446D8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513413; cv=none; b=XlQUUu8ezc3j9VUt/9EAE0CLvemXXFnhT3xLiKyoB88a3xb5NytgLDa8LEQwXyRZPP5FX1swl7qTG8ACdVnA0RlBk4Gk1TkQ2QdaN5zKxt2o7/xpo34NZB1ogbONL49FqvWPJN3Ga0fx1qEjU3uEEZWXZnPaJelfbCFewnmJnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513413; c=relaxed/simple;
	bh=ac6x4vYZSm+r1uz4MgWz1R9fYRlDNIMlSMLgt343eG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n6NwEkZHQHdIHwAl3MjUKHZPQwhF7M5O9gz9OKdZk7/1N4Hww1tShIBgBWMImMt0xeE5Nz4pwSfhytIdrdts/YwZKvyITjuy0o0UBfIYzsFuOvNSS9VMpiflu18Pw0U5g93e8wDY0BG5FBP1+iCMWFfYksRV5/UXsKecy1X8NmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ff0ARiIz; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ff0ARiIz"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8fbf7b70c7so117134166b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513409; x=1772118209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzK/3B1VQb6SprmKmRsZnV3yZajCXE7sXg4mEEAwt00=;
        b=ff0ARiIzmQEksPHcyJHO+vLYpaE55W2uRUe8oMIxYUGH5kyhEbDkZnRav35uvZcMnT
         1D56IMVA+e4wZJY31d4DY5EEsW/3yCM1ucrcrOGFsVxHGAS9cWd5TJzm3r1mWh25gUfU
         8MM0HV7PMV7ZjEFASV7djLudgQfbvuT7rTeNALV7kJcLKxjlAOsVTXydr0QHyD1Wxr+2
         cjLayrrfa3O/+IKB3GdlWm18vc78LsclwNT+/mJIpYW5PW7w3GeKOB+I6eMiyLe5vlL0
         ivSAhYCbynt1tVcDYvwp9h6vQtwKmxpSzgykS2qnoSssenkDCS8pEIYKFbKXA750D3nW
         LR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513409; x=1772118209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzK/3B1VQb6SprmKmRsZnV3yZajCXE7sXg4mEEAwt00=;
        b=QmN4PJcTdLBlZETcQYKR6KW2dAf6GSPNG7nce+BvlsbtZKepfdLNIZUH1WsexFrujH
         bJGhsgH6rJMLM6UpfvAKHVS7/su8zuKBQE0uuU6nMzJsK+r7rMLzVF4nOGMt2vhzObtw
         kWagJpRcNPtjlvsn4ezCcQwywnmFEDOKIFsKU4+cm1tEBQpOrCbDgm+nsuPINN8aYjeu
         Za7ywufjvZnkneyZSlW0j/x8FiPD30Wb/WTpoU7sDvvdG7ZJRw1Fku7fdLboRQ+ZfGOS
         qKYz0rbn7eecCWL2IRGZf0LPHO8gC9k9JUTPhkVL1naWLcaOCrYu4y/YfLeYvCmSw7fU
         EV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcZZ2Y+Nu9wZYjtEQYOaiAK0OVcrybN83TA26YU6YQdgg2xI+1ozHjdvL4LCnNOLEXvyOmsgNqB+26jhzm3Bsyjk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBjsngf4l6JtR5kNhM4l6GGrhguXo/85yLZWS7srwXMT/C6hK
	5a63KG12sv3+wrYxGD+x4Cg0OG5idLgKBBtSgjUXbM1wGOcW6mENFkRs0ddFGFeU17M9JmqCekd
	Yw1k4fDFnOPJ1oETQ2CLQJw==
X-Received: from ejfw17.prod.google.com ([2002:a17:906:a11:b0:b8f:b527:5d02])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:980a:b0:b88:6309:c300 with SMTP id a640c23a62f3a-b903dc90470mr313180566b.39.1771513409188;
 Thu, 19 Feb 2026 07:03:29 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:47 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-11-vdonnefort@google.com>
Subject: [PATCH v12 10/30] tracing: Add events/ root files to trace remotes
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
index e36e70e2c998..190a90816f02 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -640,7 +640,8 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)buffer->subbuf_size,
+			 (unsigned int)(buffer ? buffer->subbuf_size :
+						 PAGE_SIZE - BUF_PAGE_HDR_SIZE),
 			 (unsigned int)is_signed_type(char));
 
 	return !trace_seq_has_overflowed(s);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 7dde7143aa20..595277fe5b2f 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1125,10 +1125,145 @@ static int remote_event_callback(const char *name, umode_t *mode, void **data,
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
@@ -1144,7 +1279,8 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
 	bool eventfs_create = false;
 
 	if (!eventfs) {
-		eventfs = eventfs_create_events_dir("events", remote->dentry, NULL, 0, NULL);
+		eventfs = eventfs_create_events_dir("events", remote->dentry, dir_entries,
+						    ARRAY_SIZE(dir_entries), remote);
 		if (IS_ERR(eventfs))
 			return PTR_ERR(eventfs);
 
-- 
2.53.0.335.g19a08e0c02-goog

