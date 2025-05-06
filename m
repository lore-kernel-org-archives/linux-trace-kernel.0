Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34F2853F3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 May 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550143; cv=none; b=Khegx9JV6cgdcXazyiQoQ/moViEls8wGffPMIHXffpzwNAEi/pPOT2giX883mDwFj8ylETlj1w/Oya/M089cuj4jkKAMFlR8i+22MDpksk+VYtkayfjBzddS3smO3GUw/AslbA5s7iAsjwY7qPyHueaeXd0C0geO0yJTNPxL/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550143; c=relaxed/simple;
	bh=TjaTEjsg0+DXvyUXwwBtev0LdVcHX9+wqh45SuZo7+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qhddExnKquRd6Smb+zNZjQNQKVRz8GkwpHafXD2Q26FmRcCH9T750o4oBH0XceFWIIDOf9ai6lfqe9i16mCV7irqulm3E7govtWn+D0EZPwO2vScG8lpnMeBe5Kt/cPNXf6wmepTcQx+03dMO/uLGxgcpX45tMA3PekoIYxopxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AM6VtBmN; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AM6VtBmN"
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-549927ec579so3316519e87.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 May 2025 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550140; x=1747154940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jp1lLJLaGjaKoXy64OEgzLoF8SWUPuFbMZNzmgUGvY=;
        b=AM6VtBmNZzshHyEtMTlaoOzEyKyt3H4x3kTHf38DaA4oJXpqK/L7DckswcTrzanOu2
         FC6CWt6LlwuiAN0CgAD7dQ+LhVHWLSjx4oYSfhIKgaJieTqzSt4PCaP+Am2bsa1AfCxF
         j015/Rirk3Xj7vRDW9wOy3d0cGQsxDRxzJrcnnTzCXb0lJJOtmUN/DRjRagiAWGn3L8m
         d+j7LRlybIbmKbrKIyrmyvj6FLXzNIim8fr9EO/rw0u8fGC0V62ennUja4ziSxJjhrWw
         joU84LeW53wmwXtWJ+KQTRlXNbDLA/xePwC1EVGWHJmeXc99BJ9nP4l+ULWx9HgCdB5r
         xhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550140; x=1747154940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jp1lLJLaGjaKoXy64OEgzLoF8SWUPuFbMZNzmgUGvY=;
        b=Sg5UupDZFsd0TY+lABboR0rznW0CzLrLa/6UUXwrWbwdLHA8Jbd7jcqec9lTiZbB3E
         eZCX8aBZNbR7sPKBKE76AX3kFRpEIBt9G7/JOAe4gntYPC8C2sXAfRFPA2f9Gg1X1O6G
         oM6PabZNBW8QFtxe7tN5BwRc12PIUnmXRz7XVNWa9LaJH4TFc10V8XCjlVZl8+phK35y
         vUurbo99csjLO6sAeIUFgboVpI18JEehzpoze4LVTo1sJR4ISIXCqtankec6jJ4KVN3Z
         nsJUStZqx4Asz1kK8+aDL5kU6tPKTmgXa+RiDjGr20+iZKPeGjbwT+fVLH2i+FvAV0mF
         JQxw==
X-Forwarded-Encrypted: i=1; AJvYcCWpE1gS6oJWaAH6VAhRFXTnb8N1nKM/2PJzI4/bWGoDGeT4ZO0PKGc8YFv/jhWoQZ/c0J/UvDULy+BTJqDnDmsiYSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8FTkWloE81EbR1LgdevflPmZzsjGD2LTG16cc82XkYPdtr8Z
	RTlJcyz0L7O8fpTtXJYSmKUbwK0N831wfyTjKbJvlTOcbGfsmI1p20RwR4ngUKrtyqZByQ4yQjB
	WQDV7idzzouvnO7ySow==
X-Google-Smtp-Source: AGHT+IGiXAgVMRbfLIS8SOyIvtLGncb5XoCWTw3YHC2KCY3kpynNJbuNPStX2fauF3TpS7pG9j8sT4PCVtP6V84+
X-Received: from wmbdq15.prod.google.com ([2002:a05:600c:64cf:b0:441:d228:3918])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:1c:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-441c4933d05mr112672305e9.31.1746550129253;
 Tue, 06 May 2025 09:48:49 -0700 (PDT)
Date: Tue,  6 May 2025 17:48:02 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-7-vdonnefort@google.com>
Subject: [PATCH v4 06/24] tracing: Add events/ root files to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Just like for the kernel events directory, add 'enable', 'header_page'
and 'header_event' at the root of the trace remote events/ directory.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a96a0b231fee..cff1e700d4b7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -604,7 +604,8 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)buffer->subbuf_size,
+			 (unsigned int)(buffer ? buffer->subbuf_size :
+						 PAGE_SIZE - BUF_PAGE_HDR_SIZE),
 			 (unsigned int)is_signed_type(char));
 
 	return !trace_seq_has_overflowed(s);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 00ef80da043b..5c9f2b07941f 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -707,10 +707,118 @@ static int remote_event_callback(const char *name, umode_t *mode, void **data,
 	return 0;
 }
 
+static ssize_t remote_events_dir_enable_write(struct file *filp, const char __user *ubuf,
+					      size_t count, loff_t *ppos)
+{
+	struct trace_remote *remote = file_inode(filp)->i_private;
+	u8 enable;
+	int i, ret;
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
+static const struct file_operations remote_events_dir_enable_fops = {
+	.write = remote_events_dir_enable_write,
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
+		*mode = 0200;
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
@@ -726,7 +834,8 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
 	bool eventfs_create = false;
 
 	if (!eventfs) {
-		eventfs = eventfs_create_events_dir("events", remote->dentry, NULL, 0, NULL);
+		eventfs = eventfs_create_events_dir("events", remote->dentry, dir_entries,
+						    ARRAY_SIZE(dir_entries), remote);
 		if (IS_ERR(eventfs))
 			return PTR_ERR(eventfs);
 
-- 
2.49.0.967.g6a0df3ecc3-goog

