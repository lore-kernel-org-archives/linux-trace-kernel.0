Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8430C63E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668205; cv=none; b=JGZFADE7bCBlRoHVoxtDGC/FB9XrabscsXb3lRqnZkiMybLKH/GI6/zo/kvuyLBv/Ojxd3kVSAayP4SmupZKedPt9cI+KPf3Cprn/79nRUJ0+7/JquZXqxKayrU4hFlInY/O4sZbrIu/pTtDkYzW1JCeRilYzz84AUmlu1GHf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668205; c=relaxed/simple;
	bh=qxvxJ2jhWhit59amBLOQDsgN4DCLBr6daXNmJfWK41w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FmMDoVazMhdwk1+tqe0i+Og0Em1OzcJIlWljNHu92meKV2axd2zWXgCZbNCstIw77NXUOC47CCCbYWXWhP1qToq3d4mXEeL/GWjWOeZfc82WSLr6x49cfhDGguVqQLux9JoyETpbeUNd1XJFqRTuxWCZfapwcDQ+eCeFQz/sOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi5gsMvW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi5gsMvW"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477771366cbso31850845e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668201; x=1765273001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu7GyFLfNLwQVA6ni9FoSx3ZpEkIIUn3sjQhqzYAiz8=;
        b=Gi5gsMvWkckGLYUKpegUsANkhSiPdkCEWSWEYySFqQXNZ4eZuRmty4r+pPFSe350bK
         wgmB3Hp5WWo5dxJZYUmeFxA8iE65Cf/HjDJNnX1Kb40IVBDaCsYEJf2IT6YTO28CUBZK
         cgPeSU58Ion1S9VVyHQAV53zXVydmCvCAR0yHJip4vvZXuEf5hrqdqF0KfoFSRS+u5tZ
         WXN6x0Uj9PJxCQ51GF5UufEC0Mu+aFXvW2zeVViOhIOcjyl+WmQzPyu0gJh32XuGkX3H
         G4fBhQ626nCS03G4PK0k+PNJtydw3FthBtnk9O2gGIn90N6O0+czqquQJ0Xv3gGDPut7
         2eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668201; x=1765273001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu7GyFLfNLwQVA6ni9FoSx3ZpEkIIUn3sjQhqzYAiz8=;
        b=YQtBS2kFxJJhfMkhI9XVqu3lAMPv8xC8BsRGHaDMBp+yZOlDdPW0ZwkDbanOt/rFKO
         jGBcbRTcVHJPO+MBoBxxWWm2WJFV4edYk+LUPzaZEpnOaLEBdwwOIJCQs0yMDUpmnla+
         vi9CfvfvJWXtdM+e8vNMEpzqAbDi/NzGIR72xVaI0eX1frEBeFTLvtWlqF74e67ngkhd
         3PGZAaeJJL+gn/92cVln11Se+R0QXHHEc9HdETzepKomA04YdTuWC45JX2B9s+7nN7oG
         cxRfo6BTWOb1MVq1EOQf0TJIF/TPJXGY2GHsvDA+9BAlsr2NkDKRXDVuLujQdse4jNKn
         Lpag==
X-Forwarded-Encrypted: i=1; AJvYcCWVRR6vp0D1qHWoTTS7mLX7cJIcz+xycFqqh43DEWHetWjRUNLrXpXf9NP/TBXd5ucHVEZxz+JcQDlIfcLTSlvAQAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPyMnJ6VzB9HcE5okfHP6cNvOiSz9asRWOeNqWBl5oMXr4XUfB
	WYedyv7c2SGXC7vsxi3SGRuWZngr9ElOh40Vo4rAzpPy9mkVOzPECJx43/iAQrz27KVyMTJMYz0
	eAj3h/oAruZ9gfD9rnAy2kQ==
X-Google-Smtp-Source: AGHT+IGBhA+hYCk05ot5XcSydU2F4dh3hUYcdu6uEl1EyzVytZWMoWSTTtHR1nwrUQLSQ9KOqoRHKY+3DhHSVcCR
X-Received: from wmaj12.prod.google.com ([2002:a05:600c:6c0c:b0:477:7893:c737])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474b:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-477c01b494fmr433009495e9.19.1764668200914;
 Tue, 02 Dec 2025 01:36:40 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:03 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-11-vdonnefort@google.com>
Subject: [PATCH v9 10/30] tracing: Add events/ root files to trace remotes
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index cb674a9fc359..9f28e7b3058c 100644
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
index 8527804f2d22..e54cc3e75dc5 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1078,10 +1078,145 @@ static int remote_event_callback(const char *name, umode_t *mode, void **data,
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
@@ -1097,7 +1232,8 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
 	bool eventfs_create = false;
 
 	if (!eventfs) {
-		eventfs = eventfs_create_events_dir("events", remote->dentry, NULL, 0, NULL);
+		eventfs = eventfs_create_events_dir("events", remote->dentry, dir_entries,
+						    ARRAY_SIZE(dir_entries), remote);
 		if (IS_ERR(eventfs))
 			return PTR_ERR(eventfs);
 
-- 
2.52.0.107.ga0afd4fd5b-goog

